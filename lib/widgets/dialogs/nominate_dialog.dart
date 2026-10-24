import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

/// Asks a manager which verified achievement to propose for [member], and
/// why. Returns the catalog id and the message, or null if cancelled.
Future<({String catalogId, String message})?> showNominateDialog(
    BuildContext context,
    {required UserProfile member,
    required Company company,
    required List<CatalogAchievement> catalog}) {
  return showDialog<({String catalogId, String message})>(
    context: context,
    builder: (_) =>
        _NominateDialog(member: member, company: company, catalog: catalog),
  );
}

class _NominateDialog extends StatefulWidget {
  final UserProfile member;
  final Company company;

  /// What the member doesn't have yet.
  final List<CatalogAchievement> catalog;

  const _NominateDialog(
      {required this.member, required this.company, required this.catalog});

  @override
  State<_NominateDialog> createState() => _NominateDialogState();
}

class _NominateDialogState extends State<_NominateDialog> {
  final _messageController = TextEditingController();
  String? _catalogId;

  CatalogAchievement? get _item =>
      widget.catalog.where((c) => c.id == _catalogId).firstOrNull;

  bool get _canSend =>
      _item != null && _messageController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final item = _item;

    return DialogScaffold(
      title: l10n.nominateDialogTitle,
      subtitle: l10n.nominateDialogSubtitle(widget.member.name),
      preview: item == null
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Text(l10n.sendPreviewHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.onSurfaceVariant)),
            )
          : InteractiveCard(
              achievement: item.preview(widget.company),
              heroTag: 'nominate_preview',
              onPressed: () {}),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton.icon(
            onPressed: _canSend
                ? () => Navigator.of(context).pop((
                      catalogId: _catalogId!,
                      message: _messageController.text.trim(),
                    ))
                : null,
            icon: const Icon(Icons.send_rounded),
            label: Text(l10n.commonSend)),
      ],
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldLabel(l10n.fieldAchievement),
          for (final option in widget.catalog) _buildOption(option),
          const SizedBox(height: 12),
          FieldLabel(l10n.requestMessage),
          TextField(
            controller: _messageController,
            maxLength: 300,
            maxLines: 3,
            decoration: InputDecoration(hintText: l10n.nominateMessageHint),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(CatalogAchievement option) {
    final colorScheme = Theme.of(context).colorScheme;
    final tier = AchievementTier.fromPoints(option.points);
    final selected = option.id == _catalogId;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: selected
            ? colorScheme.primary.withValues(alpha: 0.12)
            : colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: selected ? colorScheme.primary : Colors.transparent,
              width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => _catalogId = option.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    gradient: tier.gradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                      achievementIcons[option.icon] ??
                          Icons.emoji_events_rounded,
                      size: 18,
                      color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(option.name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                Text(context.l10n.xpValue(option.points),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.legible(tier.color))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
