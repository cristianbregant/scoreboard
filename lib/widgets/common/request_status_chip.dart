import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

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
          icon: LucideIcons.hourglass,
          color: colorScheme.primary),
      RequestStatus.approved => TagChip(
          label: l10n.statusApproved,
          icon: LucideIcons.circleCheck,
          color: AppColors.success),
      RequestStatus.rejected => TagChip(
          label: l10n.statusRejected,
          icon: LucideIcons.circleX,
          color: colorScheme.error),
    };
  }
}
