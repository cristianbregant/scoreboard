import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

enum ConsoleTab { catalog, assign, requests }

abstract class ConsoleViewContract extends BaseViewContract {
  Future<CatalogAchievementDraft?> askCatalogAchievement(
      {CatalogAchievement? existing});
  Future<String?> askRejectionReason();
  void clearAssignForm();
  void showMessage(String message);
}

abstract class ConsoleViewModelContract
    extends BaseViewModelContract<ConsoleState, ConsoleViewContract> {
  void loadConsole();
  void onChangeTab(ConsoleTab tab);
  void onToggleShowArchived(bool value);
  void onTapNewCatalogAchievement();
  void onTapEditCatalogAchievement(CatalogAchievement item);
  void onToggleArchived(CatalogAchievement item);
  void onSelectAssignAchievement(String catalogId);
  void onToggleAssignee(String userId);
  void onSelectAllAssignees();
  void onAssign(String note);
  void onApprove(VerificationRequest request);
  void onReject(VerificationRequest request);
}

class ConsoleState extends BaseVMState {
  ConsoleTab tab = ConsoleTab.catalog;
  Company? company;
  List<CatalogAchievement> catalog = [];
  bool showArchived = false;
  List<UserProfile> members = [];
  List<VerificationRequest> requests = [];

  String? assignCatalogId;
  Set<String> assignees = {};

  /// Who already has [assignCatalogId].
  Set<String> owners = {};
  bool isAssigning = false;

  List<CatalogAchievement> get visibleCatalog =>
      catalog.where((c) => showArchived || !c.archived).toList();
  List<CatalogAchievement> get activeCatalog =>
      catalog.where((c) => !c.archived).toList();
  CatalogAchievement? get assignAchievement =>
      catalog.where((c) => c.id == assignCatalogId).firstOrNull;
  List<VerificationRequest> get pendingRequests =>
      requests.where((r) => r.status == RequestStatus.pending).toList();
  List<VerificationRequest> get decidedRequests =>
      requests.where((r) => r.status != RequestStatus.pending).toList();

  UserProfile? member(String id) =>
      members.where((m) => m.id == id).firstOrNull;
  CatalogAchievement? catalogItem(String id) =>
      catalog.where((c) => c.id == id).firstOrNull;
}
