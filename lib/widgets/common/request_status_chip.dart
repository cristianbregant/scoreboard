import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';

class RequestStatusChip extends StatelessWidget {
  final RequestStatus status;

  const RequestStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return switch (status) {
      RequestStatus.pending => TagChip(
          label: l10n.statusPending,
          icon: Icons.hourglass_top_rounded,
          color: colorScheme.primary),
      RequestStatus.approved => TagChip(
          label: l10n.statusApproved,
          icon: Icons.check_circle_rounded,
          color: AppColors.success),
      RequestStatus.rejected => TagChip(
          label: l10n.statusRejected,
          icon: Icons.cancel_rounded,
          color: colorScheme.error),
    };
  }
}
