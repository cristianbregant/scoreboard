import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/leaderboard_entry.dart';
import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// Seasons: periods with their own company leaderboard, set by the admins.
class SeasonInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ActivityInteractor _activity;

  SeasonInteractor(this._repository, this._scoreboard, this._activity);

  /// The current user's company seasons, oldest first.
  Future<List<Season>> getSeasons() async {
    final user = await _scoreboard.getCurrentUser();
    return _repository.getSeasons(user.companyId);
  }

  /// The season running today, if any.
  Future<Season?> currentSeason() async {
    final now = DateTime.now();
    return (await getSeasons()).where((s) => s.contains(now)).firstOrNull;
  }

  /// Company members ranked by the XP they earned during [season].
  Future<List<UserLeaderboardEntry>> leaderboard(Season season) async {
    final users = (await _repository.getUsers())
        .where((u) => u.companyId == season.companyId)
        .toList();
    final company = await _scoreboard.getCompany(season.companyId);
    final achievements = (await _repository.getAchievements())
        .where((a) => a.date != null && season.contains(a.date!))
        .toList();
    final entries = [
      for (final user in users)
        () {
          final earned = achievements.where((a) => a.userId == user.id);
          return (
            user: user,
            points: earned.fold<int>(0, (sum, a) => sum + (a.points ?? 0)),
            count: earned.length,
          );
        }(),
    ]..sort((a, b) => b.points.compareTo(a.points));
    return [
      for (var i = 0; i < entries.length; i++)
        UserLeaderboardEntry(
          rank: i + 1,
          user: entries[i].user,
          company: company,
          points: entries[i].points,
          achievementsCount: entries[i].count,
        )
    ];
  }

  Future<void> createSeason(SeasonDraft draft) async {
    final admin = await _requireAdmin();
    final season = Season(
      id: 's_${DateTime.now().microsecondsSinceEpoch}',
      companyId: admin.companyId,
      name: draft.name.trim(),
      start: _day(draft.start),
      end: _day(draft.end),
    );
    await _validate(season);
    await _repository.saveSeason(season);
    await _activity.log(ActivityType.seasonCreated, subject: season.name);
    _scoreboard.dataChanged();
  }

  Future<void> updateSeason(String seasonId, SeasonDraft draft) async {
    final existing = await _season(seasonId);
    final season = existing.copyWith(
        name: draft.name.trim(),
        start: _day(draft.start),
        end: _day(draft.end));
    await _validate(season);
    await _repository.saveSeason(season);
    await _activity.log(ActivityType.seasonUpdated, subject: season.name);
    _scoreboard.dataChanged();
  }

  Future<void> deleteSeason(String seasonId) async {
    final season = await _season(seasonId);
    await _repository.deleteSeason(season.id);
    await _activity.log(ActivityType.seasonDeleted, subject: season.name);
    _scoreboard.dataChanged();
  }

  static DateTime _day(DateTime time) =>
      DateTime(time.year, time.month, time.day);

  Future<UserProfile> _requireAdmin() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return user;
  }

  Future<Season> _season(String seasonId) async {
    final admin = await _requireAdmin();
    final season = (await _repository.getSeasons(admin.companyId))
        .where((s) => s.id == seasonId)
        .firstOrNull;
    if (season == null) throw const AdminException(AdminError.notFound);
    return season;
  }

  /// A name, an end not before the start, and no overlap with the other
  /// seasons of the company.
  Future<void> _validate(Season season) async {
    if (season.name.isEmpty) {
      throw const AdminException(AdminError.missingFields);
    }
    if (season.end.isBefore(season.start)) {
      throw const AdminException(AdminError.invalidDates);
    }
    final others = (await _repository.getSeasons(season.companyId))
        .where((s) => s.id != season.id);
    if (others.any(season.overlaps)) {
      throw const AdminException(AdminError.seasonOverlap);
    }
  }
}
