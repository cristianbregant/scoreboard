import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/widgets/common/request_status_chip.dart';
import 'package:scoreboard/widgets/dialogs/request_achievement_dialog.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/your_company/your_company_contract.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/leaderboard_tile.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/podium.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';

class YourCompanyView extends BaseStatefulWidget {
  YourCompanyView({
    super.key,
  }) : super(_YourCompanyViewState());
}

class _YourCompanyViewState extends BaseState<YourCompanyView,
        YourCompanyViewModelContract, YourCompanyState>
    with SendAchievementDialogs
    implements YourCompanyViewContract {
  @override
  Future<({String message, String? evidenceUrl})?> askRequest(
          CatalogAchievement item) =>
      showRequestAchievementDialog(context,
          company: vmState.company!, item: item);

  List<Widget> _buildCatalog() {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    if (vmState.catalog.isEmpty) return [];
    return [
      SectionTitle(l10n.companyCatalog),
      Text(l10n.companyCatalogHint,
          style: TextStyle(color: colorScheme.onSurfaceVariant)),
      const SizedBox(height: 16),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          for (final item in vmState.catalog)
            SizedBox(
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InteractiveCard(
                    achievement: item.preview(vmState.company!),
                    heroTag: 'company_catalog_${item.id}',
                    width: 150,
                    onPressed: () {
                      if (!vmState.ownedCatalogIds.contains(item.id) &&
                          !vmState.isPending(item.id)) {
                        viewModel.onTapRequest(item);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  if (vmState.ownedCatalogIds.contains(item.id))
                    Center(
                      child: TagChip(
                          label: l10n.earnedLabel,
                          icon: Icons.check_circle_rounded,
                          color: AppColors.success),
                    )
                  else if (vmState.isPending(item.id))
                    const Center(
                        child: RequestStatusChip(status: RequestStatus.pending))
                  else
                    OutlinedButton(
                      onPressed: () => viewModel.onTapRequest(item),
                      child: Text(l10n.requestAction),
                    ),
                ],
              ),
            ),
        ],
      ),
    ];
  }

  List<Widget> _buildMyRequests() {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    if (vmState.myRequests.isEmpty) return [];
    return [
      SectionTitle(l10n.myRequests),
      for (final request in vmState.myRequests)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vmState.catalogItem(request.catalogId)?.name ?? '-',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(
                          request.rejectionReason != null
                              ? l10n.rejectionReason(request.rejectionReason!)
                              : timeAgo(l10n, request.createdAt),
                          style: TextStyle(
                              fontSize: 12.5,
                              color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                RequestStatusChip(status: request.status),
              ],
            ),
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<YourCompanyViewModelContract, YourCompanyState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: ContentStateView(
                state: vmState,
                onRetry: viewModel.loadCompany,
                builder: (context) => ListView(
                  padding: pagePadding,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    StatRow(tiles: [
                      StatTile(
                          label: context.l10n.statMembers,
                          value: "${vmState.members.length}",
                          icon: Icons.people_rounded,
                          color: AppColors.verified),
                      StatTile(
                          label: context.l10n.statTotalXp,
                          value: "${vmState.totalPoints}",
                          icon: Icons.bolt_rounded),
                      StatTile(
                          label: context.l10n.statAchievements,
                          value: "${vmState.totalAchievements}",
                          icon: Icons.emoji_events_rounded,
                          color: AchievementTier.gold.color),
                      StatTile(
                          label: context.l10n.statYourRank,
                          value: context.l10n
                              .rankValue('${vmState.currentUserRank ?? '-'}'),
                          icon: Icons.leaderboard_rounded,
                          color: AppColors.success),
                    ]),
                    ..._buildCatalog(),
                    ..._buildMyRequests(),
                    SectionTitle(context.l10n.topPerformers),
                    Podium(
                      entries: vmState.members
                          .take(3)
                          .map((entry) => PodiumEntry(
                                avatar: UserAvatar(
                                    initials: entry.user.initials,
                                    imagePath: entry.user.avatarPath,
                                    radius: 26),
                                title: entry.user.name,
                                subtitle: entry.user.role,
                                points: entry.points,
                              ))
                          .toList(),
                    ),
                    SectionTitle(context.l10n.teamLeaderboard),
                    ...vmState.members.map((entry) => LeaderboardTile(
                          rank: entry.rank,
                          leading: UserAvatar(
                              initials: entry.user.initials,
                              imagePath: entry.user.avatarPath),
                          title: entry.user.id == vmState.currentUserId
                              ? context.l10n.youSuffix(entry.user.name)
                              : entry.user.name,
                          subtitle:
                              "${entry.user.role} · ${context.l10n.achievementsCount(entry.achievementsCount)}",
                          points: entry.points,
                          highlighted: entry.user.id == vmState.currentUserId,
                          action: entry.user.id == vmState.currentUserId
                              ? null
                              : IconButton(
                                  tooltip: context.l10n.sendAnAchievement,
                                  onPressed: () =>
                                      viewModel.onTapSendAchievement(
                                          colleagueId: entry.user.id),
                                  icon: const Icon(
                                      Icons.volunteer_activism_rounded,
                                      size: 20),
                                ),
                        )),
                  ],
                ),
              ));
            }));
  }

  Widget _buildHeader(BuildContext context) {
    final company = vmState.company!;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompanyLogo(name: company.name, brand: company.brand, size: 64),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(title: company.name),
              const SizedBox(height: 6),
              Text(company.description,
                  style: TextStyle(
                      fontSize: 14, color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  TagChip(
                      label: company.industry,
                      icon: Icons.category_rounded,
                      color: colorScheme.primary),
                  TagChip(label: company.location, icon: Icons.place_rounded),
                  TagChip(
                      label:
                          context.l10n.companySince('${company.foundedYear}'),
                      icon: Icons.history_rounded),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
