import 'package:scoreboard/interactors/report_interactor.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class ReportsViewContract extends AdminViewContract {}

abstract class ReportsViewModelContract
    extends BaseViewModelContract<ReportsState, ReportsViewContract> {
  void load();
  void onSelectPeriod(ReportPeriod period);
  void onSelectPerson(String? userId);
  void onExport(ReportKind kind);
  void onExportPersonalData();
}

enum ReportPeriod {
  last30Days,
  thisQuarter,
  thisYear,
  allTime;

  /// First and last day covered, as of [now].
  (DateTime, DateTime) range(DateTime now) {
    final today = DateTime(now.year, now.month, now.day);
    return switch (this) {
      ReportPeriod.last30Days => (
          today.subtract(const Duration(days: 29)),
          today
        ),
      ReportPeriod.thisQuarter => (
          DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 1, 1),
          today
        ),
      ReportPeriod.thisYear => (DateTime(now.year, 1, 1), today),
      ReportPeriod.allTime => (DateTime(2000, 1, 1), today),
    };
  }
}

class ReportsState extends BaseVMState {
  ReportPeriod period = ReportPeriod.thisQuarter;
  List<UserProfile> members = [];
  String? personId;

  /// An export in progress; buttons wait for it.
  bool isExporting = false;
}
