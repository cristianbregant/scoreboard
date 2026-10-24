/// Runs the REST repository against a real Scoreboard backend, started
/// from a fresh seed (`npm run reset && npm start` in scoreboard_backend):
///
///     flutter test test/integration \
///       --dart-define=SCOREBOARD_API_URL=http://localhost:3000
///
/// Skipped when SCOREBOARD_API_URL isn't set. It changes the backend's data.
/// The invitation codes are read from the backend's outbox, so the backend
/// must run without RESEND_API_KEY, from ../scoreboard_backend.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/api/api_client.dart';
import 'package:scoreboard/core/constants.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/services/mock_scoreboard_repository.dart';
import 'package:scoreboard/services/rest_scoreboard_repository.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/matchers.dart';

void main() {
  late RestScoreboardRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final preferences = SharedPreference(await SharedPreferences.getInstance());
    repository = RestScoreboardRepository(
        ApiClient(
            baseUrl: Constants.apiUrl, token: () => preferences.sessionToken),
        preferences);
  });

  test('the demo account works end to end', skip: Constants.apiUrl.isEmpty,
      () async {
    await expectLater(
        repository.signIn(MockScoreboardRepository.demoEmail, 'wrong'),
        throwsAuthError(AuthError.wrongCredentials));

    final me = await repository.signIn(MockScoreboardRepository.demoEmail,
        MockScoreboardRepository.demoPassword);
    expect(me.isCompanyAdmin, isTrue);
    expect((await repository.getCurrentUser()).id, me.id);

    final users = await repository.getUsers();
    final companies = await repository.getCompanies();
    expect(companies.map((c) => c.id), contains(me.companyId));
    expect((await repository.getCatalog(me.companyId)), isNotEmpty);
    expect((await repository.getSeasons(me.companyId)), isNotEmpty);
    expect((await repository.getTeams(me.companyId)), isNotEmpty);
    expect((await repository.getNotifications(me.id)), isNotEmpty);
    await repository.getCompanySettings(me.companyId);
    await repository.getActivity(me.companyId);

    // A base achievement to a colleague who doesn't have this one yet.
    final templates = await repository.getTemplates();
    final achievements = await repository.getAchievements();
    final (colleague, template) = users
        .where((u) => u.companyId == me.companyId && u.id != me.id)
        .expand((u) => templates.map((t) => (u, t)))
        .firstWhere((pair) => !achievements.any((a) =>
            a.awardedById == me.id &&
            a.userId == pair.$1.id &&
            a.templateId == pair.$2.id));
    Achievement send() => Achievement(
        id: 'it_${DateTime.now().microsecondsSinceEpoch}',
        userId: colleague.id,
        templateId: template.id,
        verified: false);
    await repository.addAchievement(send());
    await expectLater(repository.addAchievement(send()),
        throwsSendError(SendAchievementError.alreadySent));

    final sent = (await repository.getAchievements())
        .lastWhere((a) => a.awardedById == me.id && a.userId == colleague.id);
    await repository.setReaction(sent.id!, me.id, ReactionType.love);
    expect(
        (await repository.getReactions()).any(
            (r) => r.achievementId == sent.id && r.type == ReactionType.love),
        isTrue);

    await repository.signOut();
    expect(repository.sessionUserId, isNull);
  });

  test('invitations, the admin role and new companies',
      skip: Constants.apiUrl.isEmpty, () async {
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final email = 'it_$stamp@northwind.dev';
    final admin = await repository.signIn(MockScoreboardRepository.demoEmail,
        MockScoreboardRepository.demoPassword);

    final invite = await repository.createInvite(email, languageCode: 'it');
    expect(invite.code, isNull, reason: 'the server never shares the code');
    expect((await repository.getInvites(admin.companyId)).map((i) => i.email),
        contains(email));

    // Granting and revoking the admin role.
    await repository.setCompanyAdmin('u_01', true);
    expect(
        (await repository.getUsers())
            .firstWhere((u) => u.id == 'u_01')
            .isCompanyAdmin,
        isTrue);
    await repository.setCompanyAdmin('u_01', false);
    await expectLater(repository.setCompanyAdmin(admin.id, false),
        throwsAdminError(AdminError.lastAdmin));
    await repository.signOut();

    // The invited person joins with the code from the email.
    final outbox =
        await File('../scoreboard_backend/data/outbox.log').readAsString();
    final mail =
        outbox.split('--- ').lastWhere((m) => m.contains('To: $email'));
    final code = RegExp(r'[A-Z0-9]{4}-[A-Z0-9]{4}').firstMatch(mail)!.group(0)!;
    await expectLater(
        repository.register(RegistrationDraft.join(
            name: 'Ada',
            role: 'Engineer',
            email: email,
            password: 'analytical',
            inviteCode: 'ABCD-EFGH')),
        throwsAuthError(AuthError.invalidInviteCode));
    final joined = await repository.register(RegistrationDraft.join(
        name: 'Ada',
        role: 'Engineer',
        email: email,
        password: 'analytical',
        inviteCode: code));
    expect(joined.companyId, admin.companyId);
    expect(joined.isCompanyAdmin, isFalse);
    await repository.signOut();

    // A new company makes its founder an admin.
    final founder = await repository.register(RegistrationDraft.createCompany(
        name: 'Grace',
        role: 'Founder',
        email: 'founder_$stamp@acme.dev',
        password: 'compiler',
        newCompany: CompanyDraft(name: 'Acme $stamp')));
    expect(founder.isCompanyAdmin, isTrue);
    expect((await repository.getCompanies()).map((c) => c.name),
        contains('Acme $stamp'));
    await repository.signOut();
  });
}
