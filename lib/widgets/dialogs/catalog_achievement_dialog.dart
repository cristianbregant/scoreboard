import 'package:flutter/material.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

/// Creates a catalog achievement, or edits [existing]. Returns the fields,
/// or null if cancelled.
Future<CatalogAchievementDraft?> showCatalogAchievementDialog(
    BuildContext context,
    {required Company company,
    CatalogAchievement? existing}) {
  return showDialog<CatalogAchievementDraft>(
    context: context,
    builder: (_) =>
        _CatalogAchievementDialog(company: company, existing: existing),
  );
}

class _CatalogAchievementDialog extends StatefulWidget {
  final Company company;
  final CatalogAchievement? existing;

  const _CatalogAchievementDialog({required this.company, this.existing});

  @override
  State<_CatalogAchievementDialog> createState() =>
      _CatalogAchievementDialogState();
}

class _CatalogAchievementDialogState extends State<_CatalogAchievementDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController =
      TextEditingController(text: widget.existing?.name ?? '');
  late final _descriptionController =
      TextEditingController(text: widget.existing?.description ?? '');
  late String _icon =
      widget.existing?.icon ?? achievementIcons.keys.elementAt(8);
  late double _points = (widget.existing?.points ?? 100).toDouble();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(CatalogAchievementDraft(
      name: _nameController.text,
      description: _descriptionController.text,
      icon: _icon,
      points: _points.round(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final points = _points.round();
    final tier = AchievementTier.fromPoints(points);
    final preview = CatalogAchievement(
      id: 'draft',
      companyId: widget.company.id,
      name: _nameController.text.trim().isEmpty
          ? l10n.achievementNamePlaceholder
          : _nameController.text.trim(),
      description: _descriptionController.text,
      icon: _icon,
      points: points,
      createdAt: DateTime.now(),
    ).preview(widget.company, date: DateTime.now());

    return DialogScaffold(
      title: widget.existing == null
          ? l10n.newCatalogAchievement
          : l10n.editCatalogAchievement,
      subtitle: l10n.catalogDialogSubtitle,
      preview: InteractiveCard(
          achievement: preview, heroTag: 'catalog_preview', onPressed: () {}),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton(onPressed: _onSave, child: Text(l10n.commonSave)),
      ],
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(l10n.fieldName),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              maxLength: 40,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.templateNameRequired
                  : null,
            ),
            const SizedBox(height: 8),
            FieldLabel(l10n.fieldDescription),
            TextFormField(
              controller: _descriptionController,
              maxLength: 140,
              maxLines: 2,
              decoration: InputDecoration(hintText: l10n.descriptionHint),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.descriptionRequired
                  : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                FieldLabel(l10n.fieldExperience),
                const Spacer(),
                Text('${l10n.xpValue(points)} · ${tier.localized(l10n)}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: tier.color)),
              ],
            ),
            Slider(
              value: _points,
              min: CatalogAchievement.minPoints.toDouble(),
              max: CatalogAchievement.maxPoints.toDouble(),
              divisions: (CatalogAchievement.maxPoints -
                      CatalogAchievement.minPoints) ~/
                  10,
              activeColor: tier.color,
              onChanged: (value) => setState(() => _points = value),
            ),
            Text(l10n.catalogPointsHint,
                style: TextStyle(
                    fontSize: 12, color: colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            FieldLabel(l10n.fieldIcon),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final entry in achievementIcons.entries)
                  InkWell(
                    onTap: () => setState(() => _icon = entry.key),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: entry.key == _icon
                            ? tier.color.withValues(alpha: 0.18)
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: entry.key == _icon
                                ? tier.color
                                : Colors.transparent,
                            width: 1.5),
                      ),
                      child: Icon(entry.value,
                          size: 20,
                          color: entry.key == _icon
                              ? tier.color
                              : colorScheme.onSurfaceVariant),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
