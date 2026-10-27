import 'package:scoreboard/core/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:scoreboard/core/theme.dart';

/// Shows a spinner while [state] is loading, an error with retry when it
/// failed, and [builder] otherwise.
class ContentStateView extends StatelessWidget {
  final BaseVMState state;
  final VoidCallback onRetry;
  final WidgetBuilder builder;

  const ContentStateView(
      {super.key,
      required this.state,
      required this.onRetry,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.circleAlert, size: 48),
            const SizedBox(height: 12),
            Text(context.l10n.loadError),
            const SizedBox(height: 12),
            FilledButton(
                onPressed: onRetry, child: Text(context.l10n.commonRetry)),
          ],
        ),
      );
    }
    return builder(context);
  }
}

/// What a list says when it has nothing to show: a quiet panel with an
/// icon and [message], so an empty page still looks finished.
class EmptyNote extends StatelessWidget {
  final IconData icon;
  final String message;

  /// Without the border and with less room, e.g. inside a popover.
  final bool compact;

  const EmptyNote(
      {super.key,
      required this.icon,
      required this.message,
      this.compact = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppSpace.xl, vertical: compact ? AppSpace.xl : 40),
      decoration: compact
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radius),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpace.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 380),
            child: Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13.5,
                    height: 1.45,
                    color: colorScheme.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}
