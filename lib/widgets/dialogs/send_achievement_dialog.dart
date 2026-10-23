import 'package:flutter/material.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

/// Returns what to send, or null if cancelled.
Future<SendAchievementRequest?> showSendAchievementDialog(
    BuildContext context, SendAchievementOptions options,
    {String? colleagueId, String? templateId}) {
  return showDialog<SendAchievementRequest>(
    context: context,
    builder: (_) => _SendAchievementDialog(
        options: options, colleagueId: colleagueId, templateId: templateId),
  );
}

class _SendAchievementDialog extends StatefulWidget {
  final SendAchievementOptions options;
  final String? colleagueId;
  final String? templateId;

  const _SendAchievementDialog(
      {required this.options, this.colleagueId, this.templateId});

  @override
  State<_SendAchievementDialog> createState() => _SendAchievementDialogState();
}

class _SendAchievementDialogState extends State<_SendAchievementDialog> {
  final _noteController = TextEditingController();
  String? _colleagueId;
  String? _templateId;

  SendAchievementOptions get options => widget.options;

  AchievementTemplate? get _template =>
      options.templates.where((t) => t.id == _templateId).firstOrNull;

  bool _isSent(AchievementTemplate template) =>
      _colleagueId != null && options.alreadySent(template.id, _colleagueId!);

  bool get _canSend =>
      _colleagueId != null && _template != null && !_isSent(_template!);

  @override
  void initState() {
    super.initState();
    _colleagueId = widget.colleagueId;
    _templateId = widget.templateId;
    _noteController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onSelectColleague(String colleagueId) {
    setState(() {
      _colleagueId = colleagueId;
      // Drop a choice that is no longer valid for this colleague.
      final template = _template;
      if (template != null && _isSent(template)) _templateId = null;
    });
  }

  void _onSend() {
    Navigator.of(context).pop(SendAchievementRequest(
      templateId: _templateId!,
      colleagueId: _colleagueId!,
      note: _noteController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final template = _template;

    return DialogScaffold(
      title: "Send an achievement",
      subtitle: "Recognize a colleague with one of your base achievements.",
      preview: template == null
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Text("Pick an achievement to see how it will look.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.onSurfaceVariant)),
            )
          : InteractiveCard(
              achievement: template.preview(
                  awardedByName: options.currentUser.name,
                  date: DateTime.now()),
              heroTag: 'send_preview',
              onPressed: () {}),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel")),
        FilledButton.icon(
            onPressed: _canSend ? _onSend : null,
            icon: const Icon(Icons.send_rounded),
            label: const Text("Send")),
      ],
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel("Colleague"),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final colleague in options.colleagues)
                ChoiceChip(
                  avatar: UserAvatar(
                      initials: colleague.initials,
                      imagePath: colleague.avatarPath,
                      radius: 11),
                  label: Text(colleague.name),
                  selected: colleague.id == _colleagueId,
                  onSelected: (_) => _onSelectColleague(colleague.id),
                ),
            ],
          ),
          const SizedBox(height: 20),
          const FieldLabel("Achievement"),
          for (final t in options.templates) _buildTemplateOption(t),
          const SizedBox(height: 12),
          const FieldLabel("Message (optional)"),
          TextField(
            controller: _noteController,
            maxLength: 140,
            maxLines: 2,
            decoration: const InputDecoration(
                hintText: "Tell them why they deserve it"),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateOption(AchievementTemplate template) {
    final colorScheme = Theme.of(context).colorScheme;
    final peerColor = AchievementTier.peer.color;
    final selected = template.id == _templateId;
    final sent = _isSent(template);

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Opacity(
        opacity: sent ? 0.45 : 1,
        child: Material(
          color: selected
              ? peerColor.withValues(alpha: 0.12)
              : colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
                color: selected ? peerColor : Colors.transparent, width: 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap:
                sent ? null : () => setState(() => _templateId = template.id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      gradient: AchievementTier.peer.gradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                        achievementIcons[template.icon] ??
                            Icons.emoji_events_rounded,
                        size: 18,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(template.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                            sent
                                ? "Already sent to this colleague"
                                : template.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("${template.points} XP",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: peerColor)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
