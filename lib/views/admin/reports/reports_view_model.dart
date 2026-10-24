import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/report_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/reports/reports_contract.dart';

class ReportsViewModel extends BaseViewModel<ReportsViewContract, ReportsState>
    with AdminScreenFlow<ReportsViewContract, ReportsState>
    implements ReportsViewModelContract {
  final ReportInteractor _reports;
  @override
  final ScoreboardInteractor scoreboard;

  ReportsViewModel(this._reports, this.scoreboard);

  @override
  Future<void> fetch() async {
    final user = await scoreboard.getCurrentUser();
    vmState.members = (await scoreboard.getUserLeaderboard(
            companyId: user.companyId))
        .map((e) => e.user)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  void onSelectPeriod(ReportPeriod period) {
    vmState.period = period;
    notifyListeners();
  }

  @override
  void onSelectPerson(String? userId) {
    vmState.personId = userId;
    notifyListeners();
  }

  Future<void> _export(Future<String?> Function() save) async {
    vmState.isExporting = true;
    notifyListeners();
    String? path;
    await runAction(() async => path = await save());
    vmState.isExporting = false;
    notifyListeners();
    if (path != null) sourceView.showMessage(l10n.reportSaved);
  }

  @override
  Future<void> onExport(ReportKind kind) {
    final (from, to) = vmState.period.range(DateTime.now());
    return _export(() => _reports.saveCsv(kind, from: from, to: to));
  }

  @override
  Future<void> onExportPersonalData() async {
    final userId = vmState.personId;
    if (userId == null) return;
    await _export(() => _reports.savePersonalData(userId));
  }
}
