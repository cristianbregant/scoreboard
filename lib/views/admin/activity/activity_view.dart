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
          Icons.collections_bookmark_outlined,
        ActivityType.achievementsIssued => Icons.verified_outlined,
        ActivityType.requestApproved => Icons.check_circle_outline_rounded,
        ActivityType.requestRejected => Icons.cancel_outlined,
        ActivityType.nominationSubmitted => Icons.how_to_reg_outlined,
        ActivityType.teamCreated ||
        ActivityType.teamUpdated ||
        ActivityType.teamDeleted ||
        ActivityType.memberMoved =>
          Icons.groups_outlined,
        ActivityType.seasonCreated ||
        ActivityType.seasonUpdated ||
        ActivityType.seasonDeleted =>
          Icons.flag_outlined,
        ActivityType.brandUpdated => Icons.palette_outlined,
        ActivityType.anniversariesUpdated => Icons.cake_outlined,
        ActivityType.reportExported => Icons.download_outlined,
        ActivityType.personalDataExported => Icons.shield_outlined,
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
                  Text(l10n.activityEmpty,
                      style: TextStyle(color: colorScheme.onSurfaceVariant))
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
