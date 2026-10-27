import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/admin_interactor.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Asks why the user deserves [item]. Returns the message and the optional
/// evidence link, or null if cancelled.
Future<({String message, String? evidenceUrl})?> showRequestAchievementDialog(
    BuildContext context,
    {required Company company,
    required CatalogAchievement item}) {
  return showDialog<({String message, String? evidenceUrl})>(
    context: context,
    builder: (_) => _RequestAchievementDialog(company: company, item: item),
  );
}

class _RequestAchievementDialog extends StatefulWidget {
  final Company company;
  final CatalogAchievement item;

  const _RequestAchievementDialog({required this.company, required this.item});

  @override
  State<_RequestAchievementDialog> createState() =>
      _RequestAchievementDialogState();
}

class _RequestAchievementDialogState extends State<_RequestAchievementDialog> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final url = _urlController.text.trim();
    Navigator.of(context).pop((
      message: _messageController.text,
      evidenceUrl: url.isEmpty ? null : url,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DialogScaffold(
      title: l10n.requestDialogTitle,
      subtitle: l10n.requestDialogSubtitle(widget.company.name),
      preview: InteractiveCard(
          achievement: widget.item.preview(widget.company),
          heroTag: 'request_preview',
          onPressed: () {}),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.commonCancel)),
        FilledButton.icon(
            onPressed: _onSubmit,
            icon: const Icon(LucideIcons.send, size: 18),
            label: Text(l10n.submitRequest)),
      ],
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.item.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(widget.item.description,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            FieldLabel(l10n.requestMessage),
            TextFormField(
              controller: _messageController,
              autofocus: true,
              maxLines: 4,
              maxLength: 400,
              decoration: InputDecoration(hintText: l10n.requestMessageHint),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.requestMessageRequired
                  : null,
            ),
            const SizedBox(height: 8),
            FieldLabel(l10n.evidenceUrlLabel),
            TextFormField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                  hintText: 'https://', prefixIcon: Icon(LucideIcons.link)),
              validator: (value) {
                final url = value?.trim() ?? '';
                return url.isEmpty || AdminInteractor.isValidUrl(url)
                    ? null
                    : l10n.invalidUrl;
              },
            ),
          ],
        ),
      ),
    );
  }
}
