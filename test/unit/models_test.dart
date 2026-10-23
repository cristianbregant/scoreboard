import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/app_navigation.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/player_level.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/achievements/achievements_contract.dart';
import 'package:scoreboard/widgets/achievement_style.dart';

Achievement _achievement(String name,
        {int points = 100,
        bool verified = true,
        DateTime? date,
        String? awardedByName}) =>
    Achievement(
        id: name,
        name: name,
        description: '$name description',
        company: 'Northwind Labs',
        points: points,
        verified: verified,
        date: date ?? DateTime(2026, 1, 1),
        awardedByName: awardedByName);

void main() {
  group('PlayerLevel', () {
    test('starts at level 1 with no points', () {
      const level = PlayerLevel(0);
      expect(level.level, 1);
      expect(level.progress, 0);
      expect(level.pointsToNextLevel, PlayerLevel.pointsPerLevel);
    });

    test('moves up every ${PlayerLevel.pointsPerLevel} XP', () {
      expect(const PlayerLevel(299).level, 1);
      expect(const PlayerLevel(300).level, 2);
      const level = PlayerLevel(750);
      expect(level.level, 3);
      expect(level.pointsIntoLevel, 150);
      expect(level.pointsToNextLevel, 150);
      expect(level.progress, 0.5);
    });
  });

  group('AchievementTier', () {
    test('maps points to tiers at the thresholds', () {
      expect(AchievementTier.fromPoints(0), AchievementTier.bronze);
      expect(AchievementTier.fromPoints(99), AchievementTier.bronze);
      expect(AchievementTier.fromPoints(100), AchievementTier.silver);
      expect(AchievementTier.fromPoints(120), AchievementTier.gold);
      expect(AchievementTier.fromPoints(139), AchievementTier.gold);
      expect(AchievementTier.fromPoints(140), AchievementTier.platinum);
    });

    test('base achievements are always peer, whatever their points', () {
      expect(_achievement('a', points: 50, verified: false).tier,
          AchievementTier.peer);
      expect(_achievement('b', points: 150).tier, AchievementTier.platinum);
    });
  });

  test('Achievement survives a JSON round trip', () {
    final original = Achievement(
      id: 'ach_1',
      name: 'Bug Hunter',
      description: 'Fixed it',
      company: 'Northwind Labs',
      companyId: 'c_northwind',
      companyBrand: const CompanyBrand(symbol: 'air', color: 0xFF0EA5E9),
      icon: 'bug_icon.png',
      points: 80,
      date: DateTime(2026, 5, 4, 10, 30),
      verified: true,
      userId: 'u_me',
      catalogId: 'cat_c_northwind_1',
      note: 'Well done',
    );
    final copy = Achievement.fromJson(original.toJson());
    expect(copy.toJson(), original.toJson());
    expect(copy.companyBrand?.symbol, 'air');
    expect(copy.date, original.date);
  });

  group('UserProfile', () {
    final user = UserProfile(
        id: 'u',
        name: 'mario de rossi',
        role: 'Dev',
        email: 'm@x.dev',
        companyId: 'c',
        joinedAt: DateTime(2020),
        avatarPath: '/tmp/a.png');

    test('initials use the first two words', () {
      expect(user.initials, 'MD');
    });

    test('copyWith keeps null fields and clears empty strings', () {
      expect(user.copyWith(bio: 'hi').avatarPath, '/tmp/a.png');
      expect(user.copyWith(avatarPath: '').avatarPath, isNull);
      expect(
          user.copyWith(hiddenFromCommunity: true).hiddenFromCommunity, isTrue);
    });
  });

  group('AchievementsState', () {
    late AchievementsState state;

    setUp(() {
      state = AchievementsState()
        ..achievements = [
          _achievement('Bug Hunter', points: 80, date: DateTime(2026, 3, 1)),
          _achievement('Code Ninja', points: 140, date: DateTime(2026, 1, 1)),
          _achievement('Great Idea',
              points: 25,
              verified: false,
              date: DateTime(2026, 2, 1),
              awardedByName: 'Giulia Bianchi'),
        ];
    });

    List<String?> names() =>
        state.visibleAchievements.map((a) => a.name).toList();

    test('sorts newest first by default', () {
      expect(names(), ['Bug Hunter', 'Great Idea', 'Code Ninja']);
    });

    test('sorts by the other criteria', () {
      state.sort = AchievementSort.oldest;
      expect(names(), ['Code Ninja', 'Great Idea', 'Bug Hunter']);
      state.sort = AchievementSort.points;
      expect(names(), ['Code Ninja', 'Bug Hunter', 'Great Idea']);
      state.sort = AchievementSort.name;
      expect(names(), ['Bug Hunter', 'Code Ninja', 'Great Idea']);
    });

    test('searches names, descriptions and senders, ignoring case', () {
      state.query = '  NINJA ';
      expect(names(), ['Code Ninja']);
      state.query = 'giulia';
      expect(names(), ['Great Idea']);
      state.query = 'hunter description';
      expect(names(), ['Bug Hunter']);
      state.query = 'nothing like this';
      expect(names(), isEmpty);
    });

    test('filters by tier and sums up', () {
      state.selectedTier = AchievementTier.peer;
      expect(names(), ['Great Idea']);
      expect(state.countOf(AchievementTier.platinum), 1);
      expect(state.totalPoints, 245);
      expect(state.verifiedCount, 2);
    });
  });

  group('AppNavigation', () {
    test('hands each request over once', () {
      final navigation = AppNavigation();
      var notified = 0;
      navigation.addListener(() => notified++);

      expect(navigation.takeRequest(), isNull);
      navigation.openPage(AppPage.feed);
      expect(notified, 1);
      expect(
          navigation.takeRequest(), (NavigationRequest.openPage, AppPage.feed));
      expect(navigation.takeRequest(), isNull);

      navigation.quickSend();
      expect(navigation.takeRequest(), (NavigationRequest.quickSend, null));
    });
  });
}
