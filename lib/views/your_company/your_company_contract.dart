import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/leaderboard_entry.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

abstract class YourCompanyViewContract extends SendAchievementViewContract {
  Future<({String message, String? evidenceUrl})?> askRequest(
      CatalogAchievement item);
}

abstract class YourCompanyViewModelContract
    extends BaseViewModelContract<YourCompanyState, YourCompanyViewContract>
    implements SendAchievementActions {
  void loadCompany();
  void onTapRequest(CatalogAchievement item);
}

class YourCompanyState extends BaseVMState {
  Company? company;

  /// The season running today, with its leaderboard.
  Season? season;
  List<UserLeaderboardEntry> seasonBoard = [];

  UserLeaderboardEntry? get mySeasonEntry =>
      seasonBoard.where((e) => e.user.id == currentUserId).firstOrNull;
  String? currentUserId;
  List<UserLeaderboardEntry> members = [];

  /// Active catalog entries the user can earn.
  List<CatalogAchievement> catalog = [];

  /// Catalog entries the user already has.
  Set<String> ownedCatalogIds = {};

  /// The user's own requests, newest first.
  List<VerificationRequest> myRequests = [];

  bool isPending(String catalogId) => myRequests.any(
      (r) => r.catalogId == catalogId && r.status == RequestStatus.pending);
  CatalogAchievement? catalogItem(String id) =>
      catalog.where((c) => c.id == id).firstOrNull;

  int get totalPoints => members.fold(0, (sum, e) => sum + e.points);
  int get totalAchievements =>
      members.fold(0, (sum, e) => sum + e.achievementsCount);
  int? get currentUserRank =>
      members.where((e) => e.user.id == currentUserId).firstOrNull?.rank;
}
