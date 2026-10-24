import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class CompanySettingsViewContract extends AdminViewContract {}

abstract class CompanySettingsViewModelContract extends BaseViewModelContract<
    CompanySettingsState, CompanySettingsViewContract> {
  void load();
  void onSelectAccent(int? color);
  void onTapUploadLogo();
  void onTapRemoveLogo();
  void onToggleAnniversaries(bool enabled);
  void onToggleAnniversaryYear(int years);
}

class CompanySettingsState extends BaseVMState {
  Company? company;
  CompanySettings? settings;
}
