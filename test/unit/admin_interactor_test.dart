import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/admin_interactor.dart';
import 'package:scoreboard/interactors/notification_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

const _draft = CatalogAchievementDraft(
    name: 'Release Captain',
    description: 'Led a release end to end.',
    icon: 'rocket_icon.png',
    points: 150);

void main() {
  late AdminInteractor admin;

  setUp(() async {
    await setUpApp();
    admin = getIt<AdminInteractor>();
  });

  /// Signs in as Luca Ferrari, a Northwind member who is not an admin.
  Future<void> signInAsMember() async {
    await setUpApp(prefs: {...await savedPrefs(), 'session_user_id': 'u_02'});
    admin = getIt<AdminInteractor>();
  }

  /// A catalog entry Luca neither owns nor already asked for.
  Future<String> requestableCatalogId() async {
    for (final item in await admin.getCatalog()) {
      // req_seed_1 is Luca's pending request for cat_c_northwind_3.
      if (item.id == 'cat_c_northwind_3') continue;
      if (!(await admin.ownersOf(item.id)).contains('u_02')) return item.id;
    }
    throw StateError('Luca owns the whole catalog');
  }

  test('validates evidence links', () {
    expect(AdminInteractor.isValidUrl('https://github.com/x'), isTrue);
    expect(AdminInteractor.isValidUrl(' http://example.com '), isTrue);
    expect(AdminInteractor.isValidUrl('ftp://example.com'), isFalse);
    expect(AdminInteractor.isValidUrl('javascript:alert(1)'), isFalse);
    expect(AdminInteractor.isValidUrl('not a url'), isFalse);
  });

  group('catalog', () {
    test('is the company catalog, highest points first', () async {
      final catalog = await admin.getCatalog();
      expect(catalog, isNotEmpty);
      expect(catalog.every((c) => c.companyId == 'c_northwind'), isTrue);
      for (var i = 1; i < catalog.length; i++) {
        expect(catalog[i - 1].points, greaterThanOrEqualTo(catalog[i].points));
      }
    });

    test('admins create, edit and archive entries', () async {
      await admin.createCatalogAchievement(_draft);
      var item = (await admin.getCatalog())
          .firstWhere((c) => c.name == 'Release Captain');

      await admin.updateCatalogAchievement(
          item.id,
          const CatalogAchievementDraft(
              name: 'Release Captain',
              description: 'Updated',
              icon: 'rocket_icon.png',
              points: 200));
      item = (await admin.getCatalog()).firstWhere((c) => c.id == item.id);
      expect(item.points, 200);
      expect(item.description, 'Updated');

      await admin.setArchived(item.id, true);
      expect((await admin.getCatalog()).map((c) => c.id),
          isNot(contains(item.id)));
      expect((await admin.getCatalog(includeArchived: true)).map((c) => c.id),
          contains(item.id));
    });

    test(
        'points must stay between ${CatalogAchievement.minPoints} and '
        '${CatalogAchievement.maxPoints}', () async {
      for (final points in [
        CatalogAchievement.minPoints - 1,
        CatalogAchievement.maxPoints + 1
      ]) {
        await expectLater(
            admin.createCatalogAchievement(CatalogAchievementDraft(
                name: 'X',
                description: 'Y',
                icon: 'rocket_icon.png',
                points: points)),
            throwsAdminError(AdminError.invalidPoints));
      }
      await expectLater(
          admin.createCatalogAchievement(const CatalogAchievementDraft(
              name: ' ',
              description: 'Y',
              icon: 'rocket_icon.png',
              points: 100)),
          throwsAdminError(AdminError.missingFields));
    });

    test('members cannot manage it', () async {
      await signInAsMember();
      await expectLater(admin.createCatalogAchievement(_draft),
          throwsAdminError(AdminError.notAdmin));
      await expectLater(
          admin.getInsights(), throwsAdminError(AdminError.notAdmin));
    });
  });

  group('issuing', () {
    test('gives verified achievements and skips who has them', () async {
      final item = (await admin.getCatalog()).first;
      final owners = await admin.ownersOf(item.id);
      final members = {'u_01', 'u_02', 'u_03'};
      final expected = members.difference(owners).length;

      final result = await admin.issue(item.id, members, note: 'Great work');
      expect(result.issued, expected);
      expect(result.skipped, members.length - expected);
      expect(await admin.ownersOf(item.id), containsAll(members));

      final again = await admin.issue(item.id, members);
      expect(again.issued, 0);
      expect(again.skipped, members.length);

      final achievement =
          (await getIt<ScoreboardInteractor>().getAchievementsOf('u_02'))
              .firstWhere((a) => a.catalogId == item.id);
      expect(achievement.verified, isTrue);
      expect(achievement.companyBrand, isNotNull);
    });

    test('ignores people of other companies', () async {
      final item = (await admin.getCatalog()).first;
      final result = await admin.issue(item.id, {'u_04'});
      expect(result.issued, 0);
      expect(await admin.ownersOf(item.id), isNot(contains('u_04')));
    });
  });

  group('requests', () {
    test('members submit them with valid evidence, once', () async {
      await signInAsMember();
      final catalogId = await requestableCatalogId();

      await expectLater(admin.submitRequest(catalogId, message: '  '),
          throwsAdminError(AdminError.missingFields));
      await expectLater(
          admin.submitRequest(catalogId,
              message: 'Proof', evidenceUrl: 'ftp://nope'),
          throwsAdminError(AdminError.invalidUrl));

      await admin.submitRequest(catalogId,
          message: 'Proof', evidenceUrl: 'https://example.com/proof');
      final mine = (await admin.getRequests())
          .where((r) => r.userId == 'u_02' && r.catalogId == catalogId);
      expect(mine.single.status, RequestStatus.pending);

      await expectLater(admin.submitRequest(catalogId, message: 'Again'),
          throwsAdminError(AdminError.requestPending));
    });

    test('cannot ask for an achievement already owned', () async {
      await signInAsMember();
      final scoreboard = getIt<ScoreboardInteractor>();
      final owned = (await scoreboard.getAchievementsOf('u_02'))
          .firstWhere((a) => a.verified == true);
      await expectLater(admin.submitRequest(owned.catalogId!, message: 'Hi'),
          throwsAdminError(AdminError.alreadyOwned));
    });

    test('notify the admins when submitted', () async {
      await signInAsMember();
      final catalogId = await requestableCatalogId();
      await admin.submitRequest(catalogId, message: 'Please');

      final notifications =
          await getIt<ScoreboardRepository>().getNotifications(demoUserId);
      expect(
          notifications.where((n) =>
              n.type == NotificationType.newRequest &&
              n.actorName == 'Luca Ferrari'),
          isNotEmpty);
    });

    test('approval issues the achievement and tells the requester', () async {
      // req_seed_2: Sara Romano (u_03) asks for cat_c_northwind_1.
      await admin.approveRequest('req_seed_2');

      final request =
          (await admin.getRequests()).firstWhere((r) => r.id == 'req_seed_2');
      expect(request.status, RequestStatus.approved);
      expect(await admin.ownersOf('cat_c_northwind_1'), contains('u_03'));

      final notifications =
          await getIt<ScoreboardRepository>().getNotifications('u_03');
      expect(notifications.map((n) => n.type),
          contains(NotificationType.requestApproved));
      // Told once, as an approval, not also as a plain new achievement.
      expect(
          notifications.where((n) =>
              n.type == NotificationType.verifiedAchievementReceived &&
              n.createdAt.isAfter(request.createdAt)),
          isEmpty);

      await expectLater(admin.approveRequest('req_seed_2'),
          throwsAdminError(AdminError.notFound));
    });

    test('rejection keeps the reason', () async {
      await admin.rejectRequest('req_seed_1', 'Needs more detail');
      final request =
          (await admin.getRequests()).firstWhere((r) => r.id == 'req_seed_1');
      expect(request.status, RequestStatus.rejected);
      expect(request.rejectionReason, 'Needs more detail');

      final notifications =
          await getIt<ScoreboardRepository>().getNotifications('u_02');
      expect(
          notifications.where((n) =>
              n.type == NotificationType.requestRejected &&
              n.text == 'Needs more detail'),
          hasLength(1));
    });
  });

  test('insights cover the last six months of the company', () async {
    final insights = await admin.getInsights();
    expect(insights.monthly, hasLength(6));
    final now = DateTime.now();
    expect(insights.monthly.last.month, DateTime(now.year, now.month));
    expect(insights.coveragePercent, inInclusiveRange(0, 100));
    expect(insights.leastRecognized.length, lessThanOrEqualTo(3));
    expect(
        insights.leastRecognized.every((e) => e.$1.companyId == 'c_northwind'),
        isTrue);
    expect(insights.verifiedThisMonth + insights.peerThisMonth,
        insights.monthly.last.total);

    // An achievement issued now counts in this month.
    final item = (await admin.getCatalog()).first;
    final owners = await admin.ownersOf(item.id);
    final target = {'u_01', 'u_02', 'u_03'}.difference(owners);
    if (target.isEmpty) return;
    await admin.issue(item.id, {target.first});
    final after = await admin.getInsights();
    expect(after.verifiedThisMonth, insights.verifiedThisMonth + 1);
  });

  test('decisions reach the member after a restart', () async {
    await admin.rejectRequest('req_seed_1', 'Not yet');
    await signInAsMember();
    final notifications =
        await getIt<NotificationInteractor>().getNotifications();
    expect(notifications.map((n) => n.type),
        contains(NotificationType.requestRejected));
  });
}
