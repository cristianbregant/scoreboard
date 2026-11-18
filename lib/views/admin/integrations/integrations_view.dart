import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/chat_integration.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/integrations/integrations_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';

/// Teams and Slack channels, and single sign-on: how Scoreboard plugs into
/// the tools the company already uses.
class IntegrationsView extends BaseStatefulWidget {
  IntegrationsView({super.key}) : super(_IntegrationsViewState());
}

class _IntegrationsViewState extends BaseState<IntegrationsView,
        IntegrationsViewModelContract, IntegrationsState>
    with AdminScreenMessages
    implements IntegrationsViewContract {
  @override
  Future<String?> askWebhook(ChatChannel channel) => showDialog<String>(
        context: context,
        builder: (_) => _WebhookDialog(channel: channel),
      );

  @override
  Widget build(BuildContext context) {
    return BaseWidget<IntegrationsViewModelContract, IntegrationsState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.load,
          builder: (context) {
            final l10n = context.l10n;
            final chat = vmState.chat;
            final settings = vmState.settings;
            if (chat == null || settings == null) {
              return const SizedBox.shrink();
            }
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                    title: l10n.consoleIntegrations,
                    subtitle: l10n.consoleIntegrationsSubtitle),
                SectionTitle(l10n.chatTitle),
                _buildChat(chat),
                SectionTitle(l10n.ssoTitle),
                _SsoSettings(settings: settings, onSave: viewModel.onSaveSso),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChat(ChatIntegration chat) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final error = chat.lastError;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chatBody,
                style: TextStyle(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 12),
            for (final channel in ChatChannel.values) ...[
              _buildChannel(chat, channel),
              const Divider(),
            ],
            if (error != null) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(LucideIcons.circleAlert,
                      size: 18, color: colorScheme.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                        l10n.chatLastError(
                            _name(error.channel), formatDate(error.at)),
                        style: TextStyle(color: colorScheme.error)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.chatPostVerified),
              value: chat.postVerified,
              onChanged: viewModel.onTogglePostVerified,
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.chatPostPeer),
              subtitle: Text(l10n.chatPostPeerHint),
              value: chat.postPeer,
              onChanged: viewModel.onTogglePostPeer,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text(l10n.chatLanguage)),
                DropdownButton<String>(
                  value: chat.language,
                  underline: const SizedBox.shrink(),
                  items: [
                    for (final code in ChatIntegration.languages)
                      DropdownMenuItem(
                          value: code, child: Text(_languageName(code))),
                  ],
                  onChanged: (code) {
                    if (code != null) viewModel.onSelectLanguage(code);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChannel(ChatIntegration chat, ChatChannel channel) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final connected = chat.isConnected(channel);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
                channel == ChatChannel.teams
                    ? LucideIcons.users
                    : LucideIcons.hash,
                size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_name(channel),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(
                    connected
                        ? l10n.chatConnectedTo(chat.hint(channel) ?? '')
                        : l10n.chatNotConnected,
                    style: TextStyle(
                        fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          if (connected) ...[
            TextButton(
                onPressed: () => viewModel.onTapTest(channel),
                child: Text(l10n.chatSendTest)),
            IconButton(
              tooltip: l10n.chatDisconnect,
              onPressed: () => viewModel.onTapDisconnect(channel),
              icon: const Icon(LucideIcons.unplug, size: 18),
            ),
          ] else
            OutlinedButton(
                onPressed: () => viewModel.onTapConnect(channel),
                child: Text(l10n.chatConnect)),
        ],
      ),
    );
  }

  static String _name(ChatChannel channel) => switch (channel) {
        ChatChannel.teams => 'Microsoft Teams',
        ChatChannel.slack => 'Slack',
      };

  static String _languageName(String code) => switch (code) {
        'it' => 'Italiano',
        'en' => 'English',
        'de' => 'Deutsch',
        'es' => 'Español',
        _ => 'Français',
      };
}

/// Asks for a webhook URL, with where to find it.
class _WebhookDialog extends StatefulWidget {
  final ChatChannel channel;

  const _WebhookDialog({required this.channel});

  @override
  State<_WebhookDialog> createState() => _WebhookDialogState();
}

class _WebhookDialogState extends State<_WebhookDialog> {
  final _url = TextEditingController();

  bool get _valid => ChatIntegration.isWebhookUrl(widget.channel, _url.text);

  @override
  void dispose() {
    _url.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final teams = widget.channel == ChatChannel.teams;
    return AlertDialog(
      title: Text(l10n.chatConnectTitle(teams ? 'Microsoft Teams' : 'Slack')),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(teams ? l10n.chatTeamsHowTo : l10n.chatSlackHowTo),
            const SizedBox(height: 16),
            TextField(
              controller: _url,
              autofocus: true,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.chatWebhookUrl,
                prefixIcon: const Icon(LucideIcons.link),
                errorText: _url.text.isNotEmpty && !_valid
                    ? l10n.errorInvalidWebhook
                    : null,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton(
          onPressed:
              _valid ? () => Navigator.of(context).pop(_url.text.trim()) : null,
          child: Text(l10n.chatConnect),
        ),
      ],
    );
  }
}

/// The Entra tenant and Workspace domain allowed to sign in, saved together.
class _SsoSettings extends StatefulWidget {
  final CompanySettings settings;
  final void Function(String tenant, String domain) onSave;

  const _SsoSettings({required this.settings, required this.onSave});

  @override
  State<_SsoSettings> createState() => _SsoSettingsState();
}

class _SsoSettingsState extends State<_SsoSettings> {
  late final _tenant =
      TextEditingController(text: widget.settings.ssoMicrosoftTenant ?? '');
  late final _domain =
      TextEditingController(text: widget.settings.ssoGoogleDomain ?? '');

  bool get _changed =>
      _tenant.text.trim() != (widget.settings.ssoMicrosoftTenant ?? '') ||
      _domain.text.trim() != (widget.settings.ssoGoogleDomain ?? '');

  @override
  void dispose() {
    _tenant.dispose();
    _domain.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.ssoBody,
                style: TextStyle(color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            TextField(
              controller: _tenant,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.ssoMicrosoftTenant,
                helperText: l10n.ssoMicrosoftTenantHint,
                hintText: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _domain,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: l10n.ssoGoogleDomain,
                helperText: l10n.ssoGoogleDomainHint,
                hintText: 'example.com',
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: _changed
                    ? () => widget.onSave(_tenant.text, _domain.text)
                    : null,
                child: Text(l10n.commonSave),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
