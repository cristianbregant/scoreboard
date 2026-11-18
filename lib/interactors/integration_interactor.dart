import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/chat_integration.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// Where the company's recognition is posted: Teams and Slack channels,
/// through incoming webhooks. Admins only.
class IntegrationInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ActivityInteractor _activity;

  IntegrationInteractor(this._repository, this._scoreboard, this._activity);

  Future<ChatIntegration> chat() async {
    final admin = await _requireAdmin();
    return _repository.getChatIntegration(admin.companyId);
  }

  /// Connects [channel] to the webhook at [url], checked before sending.
  Future<ChatIntegration> connect(ChatChannel channel, String url) async {
    if (!ChatIntegration.isWebhookUrl(channel, url)) {
      throw const AdminException(AdminError.invalidWebhook);
    }
    return _update(ChatIntegrationUpdate.webhook(channel, url.trim()));
  }

  Future<ChatIntegration> disconnect(ChatChannel channel) =>
      _update(ChatIntegrationUpdate.webhook(channel, ''));

  Future<ChatIntegration> setPosting({bool? verified, bool? peer}) =>
      _update(ChatIntegrationUpdate(postVerified: verified, postPeer: peer));

  /// [language] from [ChatIntegration.languages].
  Future<ChatIntegration> setLanguage(String language) =>
      _update(ChatIntegrationUpdate(language: language));

  Future<void> sendTest(ChatChannel channel) async {
    final admin = await _requireAdmin();
    await _repository.testChatIntegration(admin.companyId, channel);
  }

  Future<ChatIntegration> _update(ChatIntegrationUpdate update) async {
    final admin = await _requireAdmin();
    final saved =
        await _repository.updateChatIntegration(admin.companyId, update);
    await _activity.log(ActivityType.integrationsUpdated);
    return saved;
  }

  Future<UserProfile> _requireAdmin() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return user;
  }
}
