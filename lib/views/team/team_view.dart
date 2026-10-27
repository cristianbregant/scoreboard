import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons_300.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/interactors/team_interactor.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/team/team_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/dialogs/nominate_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// For managers: how each member of their team is being recognized, with
/// shortcuts to recognize them.
class TeamView extends BaseStatefulWidget {
  TeamView({super.key}) : super(_TeamViewState());
}

class _TeamViewState
    extends BaseState<TeamView, TeamViewModelContract, TeamState>
    with SendAchievementDialogs
    implements TeamViewContract {
  @override
  Future<({String catalogId, String message})?> askNomination(
          UserProfile member, List<CatalogAchievement> catalog) =>
      showNominateDialog(context,
          member: member, company: vmState.company!, catalog: catalog);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TeamViewModelContract, TeamState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.loadTeam,
          builder: (context) {
            final l10n = context.l10n;
            final overview = vmState.overview;
            if (overview == null) {
              return Center(child: Text(l10n.errorNotManager));
            }
            final now = DateTime.now();
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                    title: overview.team.name, subtitle: l10n.teamSubtitle),
                const SizedBox(height: 24),
                StatRow(tiles: [
                  StatTile(
                      label: l10n.statMembers,
                      value: '${overview.members.length}',
                      icon: LucideIcons.users),
                  StatTile(
                      label: l10n.teamStatNeedAttention,
                      value: '${vmState.needAttentionCount(now)}',
                      icon: LucideIcons.bellRing,
                      color: Theme.of(context).colorScheme.error),
                  StatTile(
                      label: l10n.teamStatReceived30,
                      value: '${vmState.receivedLast30Days}',
                      icon: LucideIcons.trophy),
                ]),
                const SizedBox(height: 24),
                if (overview.members.isEmpty)
                  EmptyNote(icon: LucideIcons.users, message: l10n.teamEmpty)
                else
                  for (final stats in overview.members)
                    _MemberCard(
                      stats: stats,
                      onSend: () => viewModel.onTapSendAchievement(
                          colleagueId: stats.member.id),
                      onNominate: () => viewModel.onTapNominate(stats.member),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final TeamMemberStats stats;
  final VoidCallback onSend;
  final VoidCallback onNominate;

  const _MemberCard(
      {required this.stats, required this.onSend, required this.onNominate});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final member = stats.member;
    final last = stats.lastRecognizedAt;
    final attention = stats.needsAttention(DateTime.now());

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              UserAvatar(
                  initials: member.initials,
                  imagePath: member.avatarPath,
                  radius: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(member.name,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                        if (attention)
                          TagChip(
                              label: l10n.teamNoRecent,
                              icon: LucideIcons.clock,
                              color: colorScheme.error),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(member.role,
                        style: TextStyle(color: colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    Text(
                        [
                          last == null
                              ? l10n.teamNeverRecognized
                              : l10n.teamLastRecognized(timeAgo(l10n, last)),
                          l10n.teamMemberActivity(
                              stats.receivedLast90Days, stats.sentLast90Days),
                        ].join(' · '),
                        style: TextStyle(
                            fontSize: 12.5,
                            color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                tooltip: l10n.sendAchievement,
                onPressed: onSend,
                icon: const Icon(LucideIcons300.send),
              ),
              const SizedBox(width: 4),
              OutlinedButton.icon(
                onPressed: onNominate,
                icon: Icon(LucideIcons300.badgeCheck,
                    size: 18, color: colorScheme.legible(colorScheme.primary)),
                label: Tooltip(
                    message: l10n.teamNominateTooltip,
                    child: Text(l10n.teamNominate)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
