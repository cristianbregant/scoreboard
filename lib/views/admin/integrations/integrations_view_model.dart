import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/company_settings_interactor.dart';
import 'package:scoreboard/interactors/integration_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/chat_integration.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/integrations/integrations_contract.dart';

class IntegrationsViewModel
    extends BaseViewModel<IntegrationsViewContract, IntegrationsState>
    with AdminScreenFlow<IntegrationsViewContract, IntegrationsState>
    implements IntegrationsViewModelContract {
  final IntegrationInteractor _integrations;
  final CompanySettingsInteractor _settings;
  @override
  final ScoreboardInteractor scoreboard;

  IntegrationsViewModel(this._integrations, this._settings, this.scoreboard);

  @override
  Future<void> fetch() async {
    vmState.chat = await _integrations.chat();
    vmState.settings = await _settings.currentSettings();
  }

  Future<void> _change(Future<ChatIntegration> Function() change,
      {String? success}) async {
    ChatIntegration? saved;
    final done =
        await runAction(() async => saved = await change(), success: success);
    if (!done || saved == null) return;
    vmState.chat = saved;
    notifyListeners();
  }

  @override
  Future<void> onTapConnect(ChatChannel channel) async {
    final url = await sourceView.askWebhook(channel);
    if (url == null) return;
    await _change(() => _integrations.connect(channel, url),
        success: l10n.chatConnected(_name(channel)));
  }

  @override
  Future<void> onTapDisconnect(ChatChannel channel) async {
    final confirmed = await sourceView.confirm(
        title: l10n.chatDisconnectTitle(_name(channel)),
        body: l10n.chatDisconnectBody,
        action: l10n.chatDisconnect);
    if (!confirmed) return;
    await _change(() => _integrations.disconnect(channel));
  }

  @override
  Future<void> onTapTest(ChatChannel channel) =>
      runAction(() => _integrations.sendTest(channel),
          success: l10n.chatTestSent(_name(channel)));

  @override
  Future<void> onTogglePostVerified(bool value) =>
      _change(() => _integrations.setPosting(verified: value));

  @override
  Future<void> onTogglePostPeer(bool value) =>
      _change(() => _integrations.setPosting(peer: value));

  @override
  Future<void> onSelectLanguage(String language) =>
      _change(() => _integrations.setLanguage(language));

  @override
  Future<void> onSaveSso(String tenant, String domain) =>
      runAction(() => _settings.setSso(tenant: tenant, domain: domain),
          success: l10n.settingsSavedMessage);

  static String _name(ChatChannel channel) => switch (channel) {
        ChatChannel.teams => 'Microsoft Teams',
        ChatChannel.slack => 'Slack',
      };
}
