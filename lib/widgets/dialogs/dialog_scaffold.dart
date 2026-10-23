import 'package:scoreboard/core/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/theme.dart';

/// Two-column dialog: a form on the left and a preview on the right.
class DialogScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget form;
  final Widget preview;
  final List<Widget> actions;

  const DialogScaffold(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.form,
      required this.preview,
      required this.actions});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius * 1.25),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820, maxHeight: 600),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: TextStyle(color: colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 20),
                    Expanded(child: SingleChildScrollView(child: form)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        for (var i = 0; i < actions.length; i++) ...[
                          if (i > 0) const SizedBox(width: 8),
                          actions[i],
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 280,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(AppTheme.radius * 1.25)),
                border:
                    Border(left: BorderSide(color: colorScheme.outlineVariant)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(context.l10n.commonPreview,
                      style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 20),
                  preview,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }
}
