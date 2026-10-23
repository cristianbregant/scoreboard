import 'package:scoreboard/core/theme.dart';
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
    Key? key,
  }) : super(_YourCompanyViewState(), key: key);
}

class _YourCompanyViewState extends BaseState<YourCompanyView,
        YourCompanyViewModelContract, YourCompanyState>
    with SendAchievementDialogs
    implements YourCompanyViewContract {
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
                          label: "Members",
                          value: "${vmState.members.length}",
                          icon: Icons.people_rounded,
                          color: AppColors.verified),
                      StatTile(
                          label: "Total XP",
                          value: "${vmState.totalPoints}",
                          icon: Icons.bolt_rounded),
                      StatTile(
                          label: "Achievements",
                          value: "${vmState.totalAchievements}",
                          icon: Icons.emoji_events_rounded,
                          color: AchievementTier.gold.color),
                      StatTile(
                          label: "Your rank",
                          value: "#${vmState.currentUserRank ?? '-'}",
                          icon: Icons.leaderboard_rounded,
                          color: AppColors.success),
                    ]),
                    const SectionTitle("Top performers"),
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
                    const SectionTitle("Team leaderboard"),
                    ...vmState.members.map((entry) => LeaderboardTile(
                          rank: entry.rank,
                          leading: UserAvatar(
                              initials: entry.user.initials,
                              imagePath: entry.user.avatarPath),
                          title: entry.user.id == vmState.currentUserId
                              ? "${entry.user.name} (you)"
                              : entry.user.name,
                          subtitle:
                              "${entry.user.role} · ${entry.achievementsCount} achievements",
                          points: entry.points,
                          highlighted: entry.user.id == vmState.currentUserId,
                          action: entry.user.id == vmState.currentUserId
                              ? null
                              : IconButton(
                                  tooltip: "Send an achievement",
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
                      label: "Since ${company.foundedYear}",
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
