import 'package:flutter/material.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/activity/activity_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ActivityView extends BaseStatefulWidget {
  ActivityView({super.key}) : super(_ActivityViewState());
}

class _ActivityViewState
    extends BaseState<ActivityView, ActivityViewModelContract, ActivityState>
    with AdminScreenMessages
    implements ActivityViewContract {
  static IconData _icon(ActivityType type) => switch (type) {
        ActivityType.catalogCreated ||
        ActivityType.catalogUpdated ||
        ActivityType.catalogArchived ||
        ActivityType.catalogRestored =>
          LucideIcons.libraryBig,
        ActivityType.achievementsIssued => LucideIcons.badgeCheck,
        ActivityType.requestApproved => LucideIcons.circleCheck,
        ActivityType.requestRejected => LucideIcons.circleX,
        ActivityType.nominationSubmitted => LucideIcons.userCheck,
        ActivityType.teamCreated ||
        ActivityType.teamUpdated ||
        ActivityType.teamDeleted ||
        ActivityType.memberMoved =>
          LucideIcons.users,
        ActivityType.seasonCreated ||
        ActivityType.seasonUpdated ||
        ActivityType.seasonDeleted =>
          LucideIcons.flag,
        ActivityType.brandUpdated => LucideIcons.palette,
        ActivityType.anniversariesUpdated => LucideIcons.cake,
        ActivityType.reportExported => LucideIcons.download,
        ActivityType.personalDataExported => LucideIcons.shield,
        ActivityType.memberInvited ||
        ActivityType.inviteRevoked =>
          LucideIcons.mail,
        ActivityType.adminGranted ||
        ActivityType.adminRevoked =>
          LucideIcons.userCog,
      };

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ActivityViewModelContract, ActivityState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.load,
          builder: (context) {
            final l10n = context.l10n;
            final colorScheme = Theme.of(context).colorScheme;
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                    title: l10n.consoleActivity, subtitle: l10n.activityHint),
                const SizedBox(height: 24),
                if (vmState.entries.isEmpty)
                  EmptyNote(
                      icon: LucideIcons.history, message: l10n.activityEmpty)
                else
                  Card(
                    child: Column(
                      children: [
                        for (final entry in vmState.entries)
                          ListTile(
                            leading: Icon(_icon(entry.type),
                                color: colorScheme.onSurfaceVariant),
                            title: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: entry.actorName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                              TextSpan(text: ' ${entry.describe(l10n)}'),
                            ])),
                            trailing: Text(timeAgo(l10n, entry.createdAt),
                                style: TextStyle(
                                    fontSize: 12.5,
                                    color: colorScheme.onSurfaceVariant)),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
