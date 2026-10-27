import 'package:scoreboard/core/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Returns the [AchievementTemplateDraft] to create, or null if cancelled.
Future<AchievementTemplateDraft?> showCreateTemplateDialog(
    BuildContext context) {
  return showDialog<AchievementTemplateDraft>(
    context: context,
    builder: (_) => const _CreateTemplateDialog(),
  );
}

class _CreateTemplateDialog extends StatefulWidget {
  const _CreateTemplateDialog();

  @override
  State<_CreateTemplateDialog> createState() => _CreateTemplateDialogState();
}

class _CreateTemplateDialogState extends State<_CreateTemplateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _icon = achievementIcons.keys.first;
  int _points = AchievementTemplate.allowedPoints[1];

  @override
  void initState() {
    super.initState();
    // Keep the preview in sync while typing.
    _nameController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onCreate() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(AchievementTemplateDraft(
      name: _nameController.text,
      description: _descriptionController.text,
      icon: _icon,
      points: _points,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final preview = AchievementTemplate(
      id: 'new',
      name: _nameController.text.trim().isEmpty
          ? context.l10n.achievementNamePlaceholder
          : _nameController.text.trim(),
      description: _descriptionController.text,
      icon: _icon,
      points: _points,
      createdById: '',
      createdByName: '',
      createdAt: DateTime.now(),
    ).preview();

    return DialogScaffold(
      title: context.l10n.newBaseAchievement,
      subtitle: context.l10n.createDialogSubtitle,
      preview: InteractiveCard(
          achievement: preview, heroTag: 'create_preview', onPressed: () {}),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.l10n.commonCancel)),
        FilledButton.icon(
            onPressed: _onCreate,
            icon: const Icon(LucideIcons.plus),
            label: Text(context.l10n.commonCreate)),
      ],
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(context.l10n.fieldName),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              maxLength: 32,
              decoration: InputDecoration(hintText: context.l10n.nameHint),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? context.l10n.templateNameRequired
                  : null,
            ),
            const SizedBox(height: 8),
            FieldLabel(context.l10n.fieldDescription),
            TextFormField(
              controller: _descriptionController,
              maxLength: 100,
              maxLines: 2,
              decoration:
                  InputDecoration(hintText: context.l10n.descriptionHint),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? context.l10n.descriptionRequired
                  : null,
            ),
            const SizedBox(height: 8),
            FieldLabel(context.l10n.fieldExperience),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: [
                for (final points in AchievementTemplate.allowedPoints)
                  ButtonSegment(
                      value: points, label: Text(context.l10n.xpValue(points))),
              ],
              selected: {_points},
              onSelectionChanged: (value) =>
                  setState(() => _points = value.first),
            ),
            const SizedBox(height: 8),
            Text(context.l10n.experienceNote,
                style: TextStyle(
                    fontSize: 12, color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            FieldLabel(context.l10n.fieldIcon),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final entry in achievementIcons.entries)
                  _IconOption(
                    icon: entry.value,
                    selected: entry.key == _icon,
                    onTap: () => setState(() => _icon = entry.key),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _IconOption extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _IconOption(
      {required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final peerColor = AchievementTier.peer.color;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selected
              ? peerColor.withValues(alpha: 0.18)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: selected ? peerColor : Colors.transparent, width: 1.5),
        ),
        child: Icon(icon,
            size: 20,
            color: selected ? peerColor : colorScheme.onSurfaceVariant),
      ),
    );
  }
}
