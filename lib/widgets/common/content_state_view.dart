import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

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
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            const Text("Something went wrong while loading data."),
            const SizedBox(height: 12),
            FilledButton(onPressed: onRetry, child: const Text("Retry")),
          ],
        ),
      );
    }
    return builder(context);
  }
}
