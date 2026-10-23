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
  AchievementsView({Key? key}) : super(_AchievementsViewState(), key: key);
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
                  _buildTierFilter(),
                  const SizedBox(height: 24),
                  if (vmState.visibleAchievements.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                          child: Text(context.l10n.noAchievementsInTier)),
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
                            .toList())
                ],
              ),
            ),
          ));
        });
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
