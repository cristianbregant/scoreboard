/// A chat service the company's recognition can be posted to.
enum ChatChannel { teams, slack }

/// The company's Teams and Slack channels, as admins see them: whether each
/// is connected, never its webhook URL.
class ChatIntegration {
  /// Languages the messages can be written in.
  static const List<String> languages = ['it', 'en', 'de', 'es', 'fr'];

  final bool teamsConnected;
  final bool slackConnected;

  /// The webhook's host, e.g. `hooks.slack.com/…`, to recognize it.
  final String? teamsHint;
  final String? slackHint;

  /// What is posted: verified achievements, and those between colleagues.
  final bool postVerified;
  final bool postPeer;
  final String language;

  /// The last delivery that failed, until one works again.
  final ({ChatChannel channel, DateTime at, String message})? lastError;

  const ChatIntegration(
      {this.teamsConnected = false,
      this.slackConnected = false,
      this.teamsHint,
      this.slackHint,
      this.postVerified = true,
      this.postPeer = false,
      this.language = 'en',
      this.lastError});

  bool isConnected(ChatChannel channel) => switch (channel) {
        ChatChannel.teams => teamsConnected,
        ChatChannel.slack => slackConnected,
      };

  String? hint(ChatChannel channel) => switch (channel) {
        ChatChannel.teams => teamsHint,
        ChatChannel.slack => slackHint,
      };

  factory ChatIntegration.fromJson(Map<String, dynamic> json) {
    final error = json['last_error'];
    return ChatIntegration(
      teamsConnected: json['teams_configured'] ?? false,
      slackConnected: json['slack_configured'] ?? false,
      teamsHint: json['teams_hint'],
      slackHint: json['slack_hint'],
      postVerified: json['post_verified'] ?? true,
      postPeer: json['post_peer'] ?? false,
      language: json['language'] ?? 'en',
      lastError: error == null
          ? null
          : (
              channel: ChatChannel.values.byName(error['channel']),
              at: DateTime.parse(error['at']),
              message: error['message'] as String,
            ),
    );
  }

  /// Whether [url] is an HTTPS webhook of [channel]'s service, as the
  /// backend checks: Slack's, or Microsoft's (Teams Workflows and the older
  /// connectors).
  static bool isWebhookUrl(ChatChannel channel, String url) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || uri.scheme != 'https') return false;
    final host = uri.host;
    return switch (channel) {
      ChatChannel.slack => host == 'hooks.slack.com',
      ChatChannel.teams => host.endsWith('.logic.azure.com') ||
          host.endsWith('.powerplatform.com') ||
          host.endsWith('.webhook.office.com'),
    };
  }
}

/// A change to the integration; null fields stay as they are, and an
/// empty webhook URL disconnects the channel.
class ChatIntegrationUpdate {
  final String? teamsWebhookUrl;
  final String? slackWebhookUrl;
  final bool? postVerified;
  final bool? postPeer;
  final String? language;

  const ChatIntegrationUpdate(
      {this.teamsWebhookUrl,
      this.slackWebhookUrl,
      this.postVerified,
      this.postPeer,
      this.language});

  ChatIntegrationUpdate.webhook(ChatChannel channel, String url)
      : teamsWebhookUrl = channel == ChatChannel.teams ? url : null,
        slackWebhookUrl = channel == ChatChannel.slack ? url : null,
        postVerified = null,
        postPeer = null,
        language = null;

  Map<String, dynamic> toJson() => {
        if (teamsWebhookUrl != null) 'teams_webhook_url': teamsWebhookUrl,
        if (slackWebhookUrl != null) 'slack_webhook_url': slackWebhookUrl,
        if (postVerified != null) 'post_verified': postVerified,
        if (postPeer != null) 'post_peer': postPeer,
        if (language != null) 'language': language,
      };
}
