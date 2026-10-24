import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

void main() {
  late MemberInteractor members;

  setUp(() async {
    await setUpApp();
    members = getIt<MemberInteractor>();
  });

  group('invitations', () {
    test('an admin invites, and the invitation is listed and logged', () async {
      final invite =
          await members.invite(' Ada@Northwind.dev ', languageCode: 'it');
      expect(invite.email, 'ada@northwind.dev');
      expect(invite.companyId, 'c_northwind');
      expect(invite.expiresAt.difference(invite.createdAt).inDays, 7);

      expect((await members.getInvites()).map((i) => i.email),
          ['ada@northwind.dev']);
      final activity = await getIt<ActivityInteractor>().getActivity();
      expect(activity.first.type, ActivityType.memberInvited);
      expect(activity.first.subject, 'ada@northwind.dev');
    });

    test('inviting again replaces the code', () async {
      final first =
          await members.invite('ada@northwind.dev', languageCode: 'en');
      final second =
          await members.invite('ada@northwind.dev', languageCode: 'en');
      expect(second.code, isNot(first.code));
      expect((await members.getInvites()).single.id, second.id);
    });

    test('revoking cancels it', () async {
      final invite =
          await members.invite('ada@northwind.dev', languageCode: 'en');
      await members.revokeInvite(invite);
      expect(await members.getInvites(), isEmpty);
    });

    test('only new people with a valid email', () async {
      await expectLater(members.invite('ada', languageCode: 'en'),
          throwsAdminError(AdminError.invalidEmail));
      await expectLater(
          members.invite('Giulia.Bianchi@northwind.dev', languageCode: 'en'),
          throwsAdminError(AdminError.alreadyMember));
    });

    test('members cannot invite', () async {
      await setUpApp(prefs: {...basePrefs(), 'session_user_id': 'u_02'});
      await expectLater(
          getIt<MemberInteractor>()
              .invite('x@northwind.dev', languageCode: 'en'),
          throwsAdminError(AdminError.notAdmin));
    });
  });

  group('admin role', () {
    test('lists the company only', () async {
      final people = await members.getMembers();
      expect(people.every((u) => u.companyId == 'c_northwind'), isTrue);
      expect(
          people.where((u) => u.isCompanyAdmin).map((u) => u.id), [demoUserId]);
    });

    test('is granted and revoked, and survives a restart', () async {
      final giulia =
          (await members.getMembers()).firstWhere((u) => u.id == 'u_01');
      await members.setAdmin(giulia, true);

      await setUpApp(prefs: await savedPrefs());
      members = getIt<MemberInteractor>();
      final admins = (await members.getMembers())
          .where((u) => u.isCompanyAdmin)
          .map((u) => u.id);
      expect(admins, containsAll([demoUserId, 'u_01']));

      // With another admin, the demo user can step down.
      final me =
          (await members.getMembers()).firstWhere((u) => u.id == demoUserId);
      await members.setAdmin(me, false);
      expect(
          (await getIt<ScoreboardInteractor>().getCurrentUser()).isCompanyAdmin,
          isFalse);
    });

    test('the last admin keeps the role', () async {
      final me =
          (await members.getMembers()).firstWhere((u) => u.id == demoUserId);
      await expectLater(
          members.setAdmin(me, false), throwsAdminError(AdminError.lastAdmin));
    });
  });
}
