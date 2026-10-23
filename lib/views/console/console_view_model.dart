import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/admin_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/console/console_contract.dart';

class ConsoleViewModel extends BaseViewModel<ConsoleViewContract, ConsoleState>
    implements ConsoleViewModelContract {
  final AdminInteractor _admin;
  final ScoreboardInteractor _scoreboard;

  ConsoleViewModel(this._admin, this._scoreboard);

  @override
  void onInitState() {
    _scoreboard.addListener(_reloadSilently);
    loadConsole();
  }

  @override
  void onDispose() => _scoreboard.removeListener(_reloadSilently);

  @override
  Future<void> loadConsole() async {
    vmState.hasError = false;
    startLoadingState();
    await _fetch();
    stopLoadingState();
  }

  Future<void> _reloadSilently() async {
    await _fetch();
    notifyListeners();
  }

  Future<void> _fetch() async {
    try {
      final user = await _scoreboard.getCurrentUser();
      if (!user.isCompanyAdmin) return;
      vmState.company = await _scoreboard.getCompany(user.companyId);
      vmState.catalog = await _admin.getCatalog(includeArchived: true);
      vmState.requests = await _admin.getRequests();
      vmState.members = (await _scoreboard.getUserLeaderboard(
              companyId: user.companyId))
          .map((e) => e.user)
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      if (vmState.assignCatalogId != null) {
        vmState.owners = await _admin.ownersOf(vmState.assignCatalogId!);
      }
    } catch (_) {
      vmState.hasError = true;
    }
  }

  /// Runs [action], reporting failures as a message.
  Future<bool> _run(Future<void> Function() action) async {
    try {
      await action();
      return true;
    } on AdminException catch (e) {
      sourceView.showMessage(e.localized(l10n));
    } catch (_) {
      sourceView.showMessage(l10n.actionError);
    }
    return false;
  }

  @override
  void onChangeTab(ConsoleTab tab) {
    vmState.tab = tab;
    notifyListeners();
  }

  @override
  void onToggleShowArchived(bool value) {
    vmState.showArchived = value;
    notifyListeners();
  }

  @override
  Future<void> onTapNewCatalogAchievement() async {
    final draft = await sourceView.askCatalogAchievement();
    if (draft == null) return;
    if (await _run(() => _admin.createCatalogAchievement(draft))) {
      sourceView.showMessage(l10n.catalogSaved);
    }
  }

  @override
  Future<void> onTapEditCatalogAchievement(CatalogAchievement item) async {
    final draft = await sourceView.askCatalogAchievement(existing: item);
    if (draft == null) return;
    if (await _run(() => _admin.updateCatalogAchievement(item.id, draft))) {
      sourceView.showMessage(l10n.catalogSaved);
    }
  }

  @override
  Future<void> onToggleArchived(CatalogAchievement item) async {
    await _run(() => _admin.setArchived(item.id, !item.archived));
  }

  @override
  Future<void> onSelectAssignAchievement(String catalogId) async {
    vmState.assignCatalogId = catalogId;
    vmState.owners = await _admin.ownersOf(catalogId);
    vmState.assignees.removeAll(vmState.owners);
    notifyListeners();
  }

  @override
  void onToggleAssignee(String userId) {
    if (vmState.owners.contains(userId)) return;
    final assignees = vmState.assignees;
    assignees.contains(userId)
        ? assignees.remove(userId)
        : assignees.add(userId);
    notifyListeners();
  }

  @override
  void onSelectAllAssignees() {
    vmState.assignees = {
      for (final m in vmState.members)
        if (!vmState.owners.contains(m.id)) m.id
    };
    notifyListeners();
  }

  @override
  Future<void> onAssign(String note) async {
    final catalogId = vmState.assignCatalogId;
    if (catalogId == null || vmState.assignees.isEmpty) return;
    vmState.isAssigning = true;
    notifyListeners();
    IssueResult? result;
    await _run(() async =>
        result = await _admin.issue(catalogId, vmState.assignees, note: note));
    vmState.isAssigning = false;
    if (result != null) {
      vmState.assignees = {};
      sourceView.clearAssignForm();
      sourceView.showMessage(l10n.issuedCount(result!.issued));
    }
    notifyListeners();
  }

  @override
  Future<void> onApprove(VerificationRequest request) async {
    if (await _run(() => _admin.approveRequest(request.id))) {
      sourceView.showMessage(l10n.requestApprovedMessage);
    }
  }

  @override
  Future<void> onReject(VerificationRequest request) async {
    final reason = await sourceView.askRejectionReason();
    if (reason == null) return;
    if (await _run(() => _admin.rejectRequest(request.id, reason))) {
      sourceView.showMessage(l10n.requestRejectedMessage);
    }
  }
}
