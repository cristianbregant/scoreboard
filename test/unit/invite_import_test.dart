import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/invite_csv.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

void main() {
  group('CSV', () {
    test('an Italian Excel export: semicolons, BOM and a header', () {
      final rows = InviteCsv.parse('﻿Nome;Email;Ruolo;Squadra\r\n'
          'Ada;ADA@northwind.dev;Ingegnera;Platform & QA\r\n'
          'Linus;linus@northwind.dev;;\r\n');
      expect(rows.map((r) => r.email),
          ['ada@northwind.dev', 'linus@northwind.dev']);
      expect(rows.first.role, 'Ingegnera');
      expect(rows.first.team, 'Platform & QA');
      expect(rows.last.role, isNull);
      expect(rows.map((r) => r.line), [2, 3]);
    });

    test('without a header the columns are email, role and team', () {
      final rows =
          InviteCsv.parse('grace@northwind.dev,Designer\nken@northwind.dev');
      expect(rows.first.email, 'grace@northwind.dev');
      expect(rows.first.role, 'Designer');
      expect(rows.last.role, isNull);
      expect(rows.map((r) => r.line), [1, 2]);
    });

    test('quoted fields may hold separators, quotes and blank lines', () {
      final rows = InviteCsv.parse('email,role\n\n'
          '"bob@northwind.dev","Lead, ""Platform"""\n');
      expect(rows.single.role, 'Lead, "Platform"');
      expect(rows.single.line, 3);
    });
  });

  group('import', () {
    late MemberInteractor members;

    setUp(() async {
      await setUpApp();
      members = getIt<MemberInteractor>();
    });

    test('matches teams by name and lists what is left out', () async {
      final read = await members.readImport('email;ruolo;team\n'
          'ada@northwind.dev;Engineer;platform & qa\n'
          'ada@northwind.dev;;\n'
          'giulia.bianchi@northwind.dev;;\n'
          'not-an-email;;\n'
          'linus@northwind.dev;;Marketing\n');
      expect(read.drafts.single.email, 'ada@northwind.dev');
      expect(read.drafts.single.role, 'Engineer');
      expect(read.drafts.single.teamId, isNotNull);
      expect(read.problems.map((p) => (p.line, p.type)), [
        (3, InviteProblem.duplicate),
        (4, InviteProblem.alreadyMember),
        (5, InviteProblem.invalidEmail),
        (6, InviteProblem.unknownTeam),
      ]);
    });

    test('invites everyone, logs it, and the team applies on joining',
        () async {
      final read = await members.readImport(
          'email,role,team\nada@northwind.dev,Engineer,Platform & QA\n'
          'linus@northwind.dev,,\n');
      final result =
          await members.importInvites(read.drafts, languageCode: 'en');
      expect(result.created.map((i) => i.email),
          ['ada@northwind.dev', 'linus@northwind.dev']);
      expect(result.skipped, isEmpty);
      final activity = await getIt<ActivityInteractor>().getActivity();
      expect(activity.first.type, ActivityType.membersImported);
      expect(activity.first.count, 2);

      await getIt<AuthInteractor>().signOut();
      final ada = await getIt<ScoreboardRepository>().register(
          RegistrationDraft.join(
              name: 'Ada Lovelace',
              role: 'Engineer',
              email: 'ada@northwind.dev',
              password: 'analytical',
              inviteCode: result.created.first.code!));
      expect(ada.teamId, read.drafts.first.teamId);
    });

    test('imports are for admins, and have a size limit', () async {
      final drafts = [
        for (var i = 0; i <= ScoreboardRepository.maxBulkInvites; i++)
          InviteDraft(email: 'p$i@northwind.dev')
      ];
      await expectLater(members.importInvites(drafts, languageCode: 'en'),
          throwsAdminError(AdminError.tooManyInvites));

      await setUpApp(prefs: {
        ...await savedPrefs(),
        'session_user_id': 'u_02',
        'onboarding_done_u_02': true,
      });
      await expectLater(getIt<MemberInteractor>().readImport('a@b.co'),
          throwsAdminError(AdminError.notAdmin));
    });
  });
}
