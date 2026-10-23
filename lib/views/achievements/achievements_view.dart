import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/routing/dynamic_routes.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/achievements/achievements_contract.dart';

class AchievementsView extends BaseStatefulWidget {
  AchievementsView({super.key}) : super(_AchievementsViewState());
}

class _AchievementsViewState extends BaseState<AchievementsView,
        AchievementsViewModelContract, AchievementsState>
    with SendAchievementDialogs
    implements AchievementsViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AchievementsViewModelContract, AchievementsState>(
        model: viewModel,
        builder: (context, viewModel, child) {
          return Scaffold(
              body: ContentStateView(
            state: vmState,
            onRetry: viewModel.loadAchievements,
            builder: (context) => SingleChildScrollView(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageHeader(
                    title: context.l10n.achievementsTitle,
                    subtitle: context.l10n.achievementsSubtitle,
                    trailing: FilledButton.icon(
                      onPressed: () => viewModel.onTapSendAchievement(),
                      icon: const Icon(Icons.send_rounded, size: 18),
                      label: Text(context.l10n.sendAchievement),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (vmState.achievements.isEmpty)
                    _buildEmptyState()
                  else ...[
                    StatRow(tiles: [
                      StatTile(
                          label: context.l10n.statTotalXp,
                          value: "${vmState.totalPoints}",
                          icon: Icons.bolt_rounded),
                      StatTile(
                          label: context.l10n.statAchievements,
                          value: "${vmState.achievements.length}",
                          icon: Icons.emoji_events_rounded,
                          color: AchievementTier.gold.color),
                      StatTile(
                          label: context.l10n.statVerified,
                          value:
                              "${vmState.verifiedCount}/${vmState.achievements.length}",
                          icon: Icons.verified_rounded,
                          color: AppColors.verified),
                    ]),
                    const SizedBox(height: 28),
                    _buildSearchAndSort(),
                    const SizedBox(height: 16),
                    _buildTierFilter(),
                    const SizedBox(height: 24),
                    if (vmState.visibleAchievements.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Center(
                            child: Text(vmState.query.trim().isEmpty
                                ? context.l10n.noAchievementsInTier
                                : context.l10n.noSearchResults)),
                      )
                    else
                      Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          children: vmState.visibleAchievements
                              .map((achievement) => InteractiveCard(
                                    achievement: achievement,
                                    onPressed: () =>
                                        viewModel.onTapAchievement(achievement),
                                  ))
                              .toList()),
                  ],
                ],
              ),
            ),
          ));
        });
  }

  Widget _buildSearchAndSort() {
    final l10n = context.l10n;
    final labels = {
      AchievementSort.newest: l10n.sortNewest,
      AchievementSort.oldest: l10n.sortOldest,
      AchievementSort.points: l10n.sortPoints,
      AchievementSort.name: l10n.sortName,
    };
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: viewModel.onSearchChanged,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_rounded),
              hintText: l10n.searchAchievementsHint,
            ),
          ),
        ),
        const SizedBox(width: 12),
        MenuAnchor(
          menuChildren: [
            for (final entry in labels.entries)
              MenuItemButton(
                leadingIcon: Icon(
                    entry.key == vmState.sort ? Icons.check_rounded : null),
                onPressed: () => viewModel.onSortChanged(entry.key),
                child: Text(entry.value),
              ),
          ],
          builder: (context, controller, _) => OutlinedButton.icon(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            icon: const Icon(Icons.sort_rounded, size: 18),
            label: Text('${l10n.sortLabel}: ${labels[vmState.sort]}'),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.emoji_events_outlined,
                    size: 36, color: colorScheme.primary),
              ),
              const SizedBox(height: 20),
              Text(l10n.achievementsEmptyTitle,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Text(l10n.achievementsEmptyBody,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.45, color: colorScheme.onSurfaceVariant)),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: viewModel.onTapOpenCatalog,
                    icon: const Icon(Icons.collections_bookmark_outlined,
                        size: 18),
                    label: Text(l10n.emptyOpenCatalog),
                  ),
                  FilledButton.icon(
                    onPressed: () => viewModel.onTapSendAchievement(),
                    icon: const Icon(Icons.send_rounded, size: 18),
                    label: Text(l10n.sendAchievement),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTierFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          label: Text(context.l10n.filterAll(vmState.achievements.length)),
          selected: vmState.selectedTier == null,
          onSelected: (_) => viewModel.onSelectTier(null),
        ),
        for (final tier in AchievementTier.values.reversed)
          ChoiceChip(
            avatar: CircleAvatar(radius: 5, backgroundColor: tier.color),
            label: Text(context.l10n.filterTier(
                tier.localized(context.l10n), vmState.countOf(tier))),
            selected: vmState.selectedTier == tier,
            onSelected: (_) => viewModel.onSelectTier(tier),
          ),
      ],
    );
  }

  @override
  void onTapAchievement(Achievement achievement) {
    Navigator.of(context).pushNamed(RouteNames.achievement,
        arguments: NavigatorArguments(nativeArgument: achievement));
  }
}
