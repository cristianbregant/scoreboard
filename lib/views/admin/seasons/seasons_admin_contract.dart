import 'package:scoreboard/model/season.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class SeasonsAdminViewContract extends AdminViewContract {
  /// A new season, or [existing] edited; null if cancelled.
  Future<SeasonDraft?> askSeason({Season? existing});
}

abstract class SeasonsAdminViewModelContract
    extends BaseViewModelContract<SeasonsAdminState, SeasonsAdminViewContract> {
  void load();
  void onTapNewSeason();
  void onTapEditSeason(Season season);
  void onTapDeleteSeason(Season season);
}

class SeasonsAdminState extends BaseVMState {
  /// Newest first.
  List<Season> seasons = [];
}
