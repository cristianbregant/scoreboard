import 'package:flutter/material.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

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
          ? "Achievement name"
          : _nameController.text.trim(),
      description: _descriptionController.text,
      icon: _icon,
      points: _points,
      createdById: '',
      createdByName: '',
      createdAt: DateTime.now(),
    ).preview();

    return DialogScaffold(
      title: "New base achievement",
      subtitle: "Anyone in your company can send it to a colleague.",
      preview: InteractiveCard(
          achievement: preview, heroTag: 'create_preview', onPressed: () {}),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel")),
        FilledButton.icon(
            onPressed: _onCreate,
            icon: const Icon(Icons.add_rounded),
            label: const Text("Create")),
      ],
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FieldLabel("Name"),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              maxLength: 32,
              decoration: const InputDecoration(hintText: "e.g. Team Player"),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? "Give it a name"
                  : null,
            ),
            const SizedBox(height: 8),
            const FieldLabel("Description"),
            TextFormField(
              controller: _descriptionController,
              maxLength: 100,
              maxLines: 2,
              decoration: const InputDecoration(
                  hintText: "What does someone do to deserve it?"),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? "Add a short description"
                  : null,
            ),
            const SizedBox(height: 8),
            const FieldLabel("Experience"),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: [
                for (final points in AchievementTemplate.allowedPoints)
                  ButtonSegment(value: points, label: Text("$points XP")),
              ],
              selected: {_points},
              onSelectionChanged: (value) =>
                  setState(() => _points = value.first),
            ),
            const SizedBox(height: 8),
            Text(
                "Base achievements are worth less than the verified ones "
                "issued by your company.",
                style: TextStyle(
                    fontSize: 12, color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            const FieldLabel("Icon"),
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
