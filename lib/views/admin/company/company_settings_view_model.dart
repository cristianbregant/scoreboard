import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/company_settings_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/company/company_settings_contract.dart';

class CompanySettingsViewModel
    extends BaseViewModel<CompanySettingsViewContract, CompanySettingsState>
    with AdminScreenFlow<CompanySettingsViewContract, CompanySettingsState>
    implements CompanySettingsViewModelContract {
  final CompanySettingsInteractor _settings;
  @override
  final ScoreboardInteractor scoreboard;

  CompanySettingsViewModel(this._settings, this.scoreboard);

  @override
  Future<void> fetch() async {
    final user = await scoreboard.getCurrentUser();
    vmState.company = await scoreboard.getCompany(user.companyId);
    vmState.settings = await _settings.currentSettings();
  }

  @override
  Future<void> onSelectAccent(int? color) async {
    if (color == vmState.settings?.accentColor) return;
    await runAction(() => _settings.setAccent(color),
        success: l10n.settingsSavedMessage);
  }

  @override
  Future<void> onTapUploadLogo() async {
    final path = await _settings.pickLogo();
    if (path == null) return;
    await runAction(() => _settings.setLogo(path),
        success: l10n.settingsSavedMessage);
  }

  @override
  Future<void> onTapRemoveLogo() => runAction(() => _settings.setLogo(null),
      success: l10n.settingsSavedMessage);

  @override
  Future<void> onToggleAnniversaries(bool enabled) {
    final settings = vmState.settings!;
    return runAction(() => _settings.setAnniversaries(
        enabled: enabled, years: settings.anniversaryYears));
  }

  @override
  Future<void> onToggleAnniversaryYear(int years) {
    final settings = vmState.settings!;
    final selected = {...settings.anniversaryYears};
    selected.contains(years) ? selected.remove(years) : selected.add(years);
    return runAction(() => _settings.setAnniversaries(
        enabled: settings.anniversariesEnabled, years: selected.toList()));
  }
}
