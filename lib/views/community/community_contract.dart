import 'package:scoreboard/model/leaderboard_entry.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class CommunityViewContract extends BaseViewContract {}

abstract class CommunityViewModelContract
    extends BaseViewModelContract<CommunityState, CommunityViewContract> {
  void loadLeaderboards();
  void onChangeTab(CommunityTab tab);
  void onSearchChanged(String query);
}

enum CommunityTab { people, companies }

class CommunityState extends BaseVMState {
  CommunityTab tab = CommunityTab.people;
  String query = '';
  String? currentUserId;
  String? currentCompanyId;
  List<UserLeaderboardEntry> users = [];
  List<CompanyLeaderboardEntry> companies = [];

  List<UserLeaderboardEntry> get filteredUsers => users
      .where((e) =>
          _matches(e.user.name) ||
          _matches(e.user.role) ||
          _matches(e.company.name))
      .toList();

  List<CompanyLeaderboardEntry> get filteredCompanies => companies
      .where((e) => _matches(e.company.name) || _matches(e.company.industry))
      .toList();

  bool _matches(String value) =>
      value.toLowerCase().contains(query.trim().toLowerCase());
}
