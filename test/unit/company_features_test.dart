import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

/// Signs in as someone else, keeping the data of the current session.
Future<void> _signInAs(String userId) =>
    savedPrefs().then((prefs) => setUpApp(prefs: {
          ...prefs,
          'session_user_id': userId,
          'onboarding_done_$userId': true,
        }));

Future<List<ActivityEntry>> _activity() =>
    getIt<ActivityInteractor>().getActivity();

void main() {
  setUp(setUpApp);

  group('teams', () {
    late TeamInteractor teams;

    setUp(() => teams = getIt<TeamInteractor>());

    test('the demo user manages Platform & QA', () async {
      expect((await teams.managedTeam())?.name, 'Platform & QA');
      final overview = await teams.getOverview();
      expect(overview.members.map((m) => m.member.id), ['u_03']);
    });

    test('members who manage nothing get no overview', () async {
      await _signInAs('u_02');
      expect(await getIt<TeamInteractor>().managedTeam(), isNull);
      await expectLater(getIt<TeamInteractor>().getOverview(),
          throwsAdminError(AdminError.notManager));
    });

    test('the overview puts who needs attention first', () async {
      await _signInAs('u_01'); // Giulia leads App & Web.
      final overview = await getIt<TeamInteractor>().getOverview();
      expect(overview.members.map((m) => m.member.id),
          unorderedEquals(['u_me', 'u_01', 'u_02']));
      final dates = overview.members.map((m) => m.lastRecognizedAt).toList();
      for (var i = 1; i < dates.length; i++) {
        if (dates[i - 1] == null || dates[i] == null) continue;
        expect(dates[i - 1]!.isAfter(dates[i]!), isFalse);
      }
    });

    test('admins create, edit and delete teams, and move people', () async {
      await teams.createTeam('  Design ', managerId: 'u_02');
      var design =
          (await teams.getTeams()).firstWhere((t) => t.name == 'Design');
      expect(design.managerId, 'u_02');

      await teams.moveMember('u_03', design.id);
      final users = await getIt<ScoreboardRepository>().getUsers();
      expect(users.firstWhere((u) => u.id == 'u_03').teamId, design.id);

      await teams.updateTeam(design.id, name: 'Design', managerId: null);
      design = (await teams.getTeams()).firstWhere((t) => t.id == design.id);
      expect(design.managerId, isNull);

      await teams.deleteTeam(design.id);
      final after = await getIt<ScoreboardRepository>().getUsers();
      expect(after.firstWhere((u) => u.id == 'u_03').teamId, isNull);

      final log = (await _activity()).map((e) => e.type).toList();
      expect(
          log,
          containsAll([
            ActivityType.teamCreated,
            ActivityType.memberMoved,
            ActivityType.teamUpdated,
            ActivityType.teamDeleted,
          ]));
    });

    test('team names are required and people must be colleagues', () async {
      await expectLater(
          teams.createTeam(' '), throwsAdminError(AdminError.missingFields));
      await expectLater(teams.createTeam('X', managerId: 'u_04'),
          throwsAdminError(AdminError.notFound));
    });

    test('members cannot manage teams', () async {
      await _signInAs('u_02');
      await expectLater(getIt<TeamInteractor>().createTeam('X'),
          throwsAdminError(AdminError.notAdmin));
    });

    test('team membership survives a restart', () async {
      final design = await () async {
        await teams.createTeam('Design');
        return (await teams.getTeams()).firstWhere((t) => t.name == 'Design');
      }();
      await teams.moveMember('u_02', design.id);
      await setUpApp(prefs: await savedPrefs());
      final users = await getIt<ScoreboardRepository>().getUsers();
      expect(users.firstWhere((u) => u.id == 'u_02').teamId, design.id);
    });
  });

  group('nominations', () {
    Future<String> unownedBySara() async {
      final achievements =
          await getIt<ScoreboardRepository>().getAchievements();
      final owned = {
        for (final a in achievements)
          if (a.userId == 'u_03') a.catalogId
      };
      final catalog = await getIt<AdminInteractor>().getCatalog();
      // req_seed_2: Sara already asked for cat_c_northwind_1.
      return catalog
          .map((c) => c.id)
          .firstWhere((id) => !owned.contains(id) && id != 'cat_c_northwind_1');
    }

    test('a manager proposes for their team and the admins see who', () async {
      final catalogId = await unownedBySara();
      await getIt<TeamInteractor>()
          .nominate('u_03', catalogId, message: 'Great release work');

      final request = (await getIt<AdminInteractor>().getRequests())
          .firstWhere((r) => r.userId == 'u_03' && r.catalogId == catalogId);
      expect(request.nominatedById, demoUserId);
      expect(request.status, RequestStatus.pending);

      // Other admins are told it is a proposal, not a request from Sara.
      final notifications =
          await getIt<ScoreboardRepository>().getNotifications('u_01');
      expect(notifications.where((n) => n.type == NotificationType.newRequest),
          isEmpty);
      expect((await _activity()).first.type, ActivityType.nominationSubmitted);
    });

    test('only for members of the manager\'s own team', () async {
      final catalogId = await unownedBySara();
      await expectLater(
          getIt<TeamInteractor>().nominate('u_02', catalogId, message: 'Hi'),
          throwsAdminError(AdminError.notInTeam));
      await expectLater(
          getIt<TeamInteractor>().nominate('u_03', catalogId, message: ' '),
          throwsAdminError(AdminError.missingFields));
      await getIt<TeamInteractor>()
          .nominate('u_03', catalogId, message: 'First time');
      await expectLater(
          getIt<TeamInteractor>().nominate('u_03', catalogId, message: 'Again'),
          throwsAdminError(AdminError.requestPending));
    });

    test('an approved proposal issues the achievement', () async {
      final catalogId = await unownedBySara();
      await getIt<TeamInteractor>()
          .nominate('u_03', catalogId, message: 'Great release work');
      final request = (await getIt<AdminInteractor>().getRequests())
          .firstWhere((r) => r.userId == 'u_03' && r.catalogId == catalogId);
      await getIt<AdminInteractor>().approveRequest(request.id);
      expect(
          await getIt<AdminInteractor>().ownersOf(catalogId), contains('u_03'));
    });
  });

  group('seasons', () {
    late SeasonInteractor seasons;

    setUp(() => seasons = getIt<SeasonInteractor>());

    test('the seed has a season running today', () async {
      final current = await seasons.currentSeason();
      expect(current, isNotNull);
      expect(current!.statusAt(DateTime.now()), SeasonStatus.active);
      expect(current.daysLeft(DateTime.now()), greaterThan(0));
    });

    test('the season leaderboard counts only XP earned during it', () async {
      final season = (await seasons.currentSeason())!;
      final board = await seasons.leaderboard(season);
      final achievements =
          await getIt<ScoreboardRepository>().getAchievements();
      final mario = board.firstWhere((e) => e.user.id == demoUserId);
      final expected = achievements
          .where((a) =>
              a.userId == demoUserId &&
              a.date != null &&
              season.contains(a.date!))
          .fold(0, (sum, a) => sum + (a.points ?? 0));
      expect(mario.points, expected);
      expect(board.every((e) => e.user.companyId == 'c_northwind'), isTrue);
    });

    test('admins add seasons that do not overlap', () async {
      final all = await seasons.getSeasons();
      final last = all.last.end;
      final start = last.add(const Duration(days: 1));
      final draft = SeasonDraft(
          name: 'Season 4',
          start: start,
          end: start.add(const Duration(days: 60)));
      await seasons.createSeason(draft);
      expect((await seasons.getSeasons()).last.name, 'Season 4');

      await expectLater(seasons.createSeason(draft),
          throwsAdminError(AdminError.seasonOverlap));
      await expectLater(
          seasons.createSeason(SeasonDraft(
              name: 'Backwards',
              start: start.add(const Duration(days: 400)),
              end: start.add(const Duration(days: 300)))),
          throwsAdminError(AdminError.invalidDates));
      await expectLater(
          seasons.createSeason(SeasonDraft(
              name: ' ',
              start: start.add(const Duration(days: 500)),
              end: start.add(const Duration(days: 510)))),
          throwsAdminError(AdminError.missingFields));
    });

    test('a season can be edited without overlapping itself', () async {
      final current = (await seasons.currentSeason())!;
      await seasons.updateSeason(current.id,
          SeasonDraft(name: 'Renamed', start: current.start, end: current.end));
      expect((await seasons.currentSeason())!.name, 'Renamed');
      await seasons.deleteSeason(current.id);
      expect(await seasons.currentSeason(), isNull);
    });

    test('a single-day season contains the whole day', () {
      final season = Season(
          id: 's',
          companyId: 'c',
          name: 'Day',
          start: DateTime(2026, 5, 1),
          end: DateTime(2026, 5, 1));
      expect(season.contains(DateTime(2026, 5, 1, 23, 59)), isTrue);
      expect(season.contains(DateTime(2026, 5, 2)), isFalse);
    });
  });

  group('reports', () {
    late ReportInteractor reports;

    setUp(() => reports = getIt<ReportInteractor>());

    test('the achievements CSV lists the period with a header', () async {
      final now = DateTime.now();
      final csv = await reports.buildCsv(ReportKind.achievements,
          from: now.subtract(const Duration(days: 365)), to: now);
      final lines = csv.split('\r\n');
      expect(lines.first, 'Date,Recipient,Email,Team,Achievement,Kind,XP,From');
      expect(lines.length, greaterThan(5));
      expect(csv, contains('Mario Rossi'));
      expect(csv, isNot(contains('Marco Colombo')),
          reason: 'only the admin\'s company');
      expect(csv, contains(',verified,'));
      expect(csv, contains(',peer,'));
    });

    test('the people CSV has one row per member', () async {
      final now = DateTime.now();
      final csv = await reports.buildCsv(ReportKind.people,
          from: now.subtract(const Duration(days: 90)), to: now);
      final lines = csv.split('\r\n');
      expect(lines, hasLength(1 + 4)); // Northwind has four people.
      expect(lines[1], startsWith('Giulia Bianchi,'));
    });

    test('cells are quoted and formulas neutralized', () async {
      await getIt<ScoreboardInteractor>().createTemplate(
          const AchievementTemplateDraft(
              name: '=HYPERLINK("x"), "quoted"',
              description: 'Tricky',
              icon: 'star_icon.png',
              points: 10));
      final template = (await getIt<ScoreboardInteractor>().getTemplates())
          .firstWhere((t) => t.description == 'Tricky');
      final options = await getIt<ScoreboardInteractor>().getSendOptions();
      if (options.remainingBudget == 0) {
        return markTestSkipped('seed used the budget');
      }
      await getIt<ScoreboardInteractor>().sendAchievement(
          SendAchievementRequest(templateId: template.id, colleagueId: 'u_02'));
      final now = DateTime.now();
      final csv =
          await reports.buildCsv(ReportKind.achievements, from: now, to: now);
      expect(csv, contains('"\'=HYPERLINK(""x""), ""quoted"""'));
    });

    test('personal data holds the person and nothing secret', () async {
      final data = await reports.buildPersonalData('u_02');
      expect(data['profile']['name'], 'Luca Ferrari');
      expect(data['profile']['team'], 'App & Web');
      expect(data['achievements_received'], isNotEmpty);
      expect(data['requests'], isNotEmpty); // req_seed_1
      final json = jsonEncode(data);
      expect(json, isNot(contains('hash')));
      expect(json, isNot(contains('salt')));
    });

    test('only admins export, and not other companies', () async {
      await expectLater(reports.buildPersonalData('u_04'),
          throwsAdminError(AdminError.notFound));
      await _signInAs('u_02');
      await expectLater(
          getIt<ReportInteractor>().buildCsv(ReportKind.people,
              from: DateTime(2020), to: DateTime.now()),
          throwsAdminError(AdminError.notAdmin));
    });
  });

  group('company settings', () {
    late CompanySettingsInteractor settings;

    setUp(() => settings = getIt<CompanySettingsInteractor>());

    test('the accent is stored, logged and can go back to gold', () async {
      var changed = 0;
      getIt<ScoreboardInteractor>().addListener(() => changed++);
      await settings.setAccent(0xFF2563EB);
      expect((await settings.currentSettings())!.accentColor, 0xFF2563EB);
      expect(changed, 1);
      expect((await _activity()).first.type, ActivityType.brandUpdated);

      await settings.setAccent(null);
      expect((await settings.currentSettings())!.accentColor, isNull);
    });

    test('members see the settings but cannot change them', () async {
      await settings.setAccent(0xFF16A34A);
      await _signInAs('u_02');
      final member = getIt<CompanySettingsInteractor>();
      expect((await member.currentSettings())!.accentColor, 0xFF16A34A);
      await expectLater(
          member.setAccent(null), throwsAdminError(AdminError.notAdmin));
    });

    test('signed out there are no company settings', () async {
      await getIt<AuthInteractor>().signOut();
      expect(await settings.currentSettings(), isNull);
    });
  });

  group('work anniversaries', () {
    Future<List<String>> anniversaryIds(String userId) async =>
        (await getIt<ScoreboardRepository>().getAchievements())
            .where((a) => a.userId == userId && a.id!.startsWith('anniv_'))
            .map((a) => a.id!)
            .toList();

    test('each celebrated anniversary is a verified achievement', () async {
      // Giulia joined in 2019: 1, 3 and 5 years by now.
      final achievements =
          (await getIt<ScoreboardRepository>().getAchievements())
              .where((a) => a.userId == 'u_01' && a.id!.startsWith('anniv_'))
              .toList();
      expect(achievements.map((a) => a.id),
          containsAll(['anniv_u_01_1', 'anniv_u_01_3', 'anniv_u_01_5']));
      final five = achievements.firstWhere((a) => a.id == 'anniv_u_01_5');
      expect(five.verified, isTrue);
      expect(five.name, '5 years at Northwind Labs');
      expect(five.points, CompanySettings.anniversaryPoints(5));
      expect(five.date!.month, isNot(0));
    });

    test('the company picks which anniversaries to celebrate', () async {
      final settings = getIt<CompanySettingsInteractor>();
      await settings.setAnniversaries(enabled: true, years: [2]);
      expect(await anniversaryIds('u_01'), ['anniv_u_01_2']);

      await settings.setAnniversaries(enabled: false, years: [2]);
      expect(await anniversaryIds('u_01'), isEmpty);
      // Other companies keep theirs.
      expect(await anniversaryIds('u_04'), isNotEmpty);

      await expectLater(settings.setAnniversaries(enabled: true, years: [4]),
          throwsAdminError(AdminError.missingFields));
    });

    test('anniversaries are worth 60 XP and grow to the catalog maximum', () {
      expect(CompanySettings.anniversaryPoints(1), 60);
      expect(CompanySettings.anniversaryPoints(10), 150);
      expect(CompanySettings.anniversaryPoints(20), 200);
      expect(CompanySettings.defaultAnniversaryYears, [1, 3, 5, 10]);
    });
  });

  group('activity log', () {
    test('admin actions are recorded, newest first', () async {
      final admin = getIt<AdminInteractor>();
      await admin.rejectRequest('req_seed_1', 'Not yet');
      final entries = await _activity();
      expect(entries.first.type, ActivityType.requestRejected);
      expect(entries.first.target, 'Luca Ferrari');
      expect(entries.first.actorName, 'Mario Rossi');
      for (var i = 1; i < entries.length; i++) {
        expect(
            entries[i - 1].createdAt.isBefore(entries[i].createdAt), isFalse);
      }
    });

    test('is for admins only', () async {
      await _signInAs('u_02');
      await expectLater(getIt<ActivityInteractor>().getActivity(),
          throwsAdminError(AdminError.notAdmin));
    });
  });
}
