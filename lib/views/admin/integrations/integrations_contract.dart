import 'package:scoreboard/model/chat_integration.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class IntegrationsViewContract extends AdminViewContract {
  /// The webhook URL to connect [channel] to; null if cancelled.
  Future<String?> askWebhook(ChatChannel channel);
}

abstract class IntegrationsViewModelContract
    extends BaseViewModelContract<IntegrationsState, IntegrationsViewContract> {
  void load();
  void onTapConnect(ChatChannel channel);
  void onTapDisconnect(ChatChannel channel);
  void onTapTest(ChatChannel channel);
  void onTogglePostVerified(bool value);
  void onTogglePostPeer(bool value);
  void onSelectLanguage(String language);
  void onSaveSso(String tenant, String domain);
}

class IntegrationsState extends BaseVMState {
  ChatIntegration? chat;
  CompanySettings? settings;
}
