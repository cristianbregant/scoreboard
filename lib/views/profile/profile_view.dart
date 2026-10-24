import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/routing/dynamic_routes.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/model/player_level.dart';
import 'package:scoreboard/views/profile/profile_contract.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/profile_banner.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/dialogs/edit_profile_dialog.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

class ProfileView extends BaseStatefulWidget {
  ProfileView({
    super.key,
  }) : super(_ProfileViewState());
}

class _ProfileViewState
    extends BaseState<ProfileView, ProfileViewModelContract, ProfileState>
    implements ProfileViewContract {
  static const double _bannerHeight = 132;
  static const double _avatarRadius = 48;

  // Distinct from the Achievements tab, which shows the same cards in the
  // same route (IndexedStack) and would otherwise collide on Hero tags.
  Object _heroTag(Achievement achievement) => 'profile_${achievement.id}';

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileViewModelContract, ProfileState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: ContentStateView(
                state: vmState,
                onRetry: viewModel.loadProfile,
                builder: (context) => ListView(
                  padding: pagePadding,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 16),
                    StatRow(tiles: [
                      StatTile(
                          label: context.l10n.statTotalXp,
                          value: "${vmState.totalPoints}",
                          icon: Icons.bolt_rounded),
                      StatTile(
                          label:
                              context.l10n.verifiedCount(vmState.verifiedCount),
                          value: "${vmState.achievements.length}",
                          icon: Icons.emoji_events_rounded,
                          color: AchievementTier.gold.color),
                      StatTile(
                          label: context.l10n.statCompanyRank,
                          value: context.l10n
                              .rankValue('${vmState.companyRank ?? '-'}'),
                          icon: Icons.business_rounded,
                          color: AppColors.verified),
                      StatTile(
                          label: context.l10n.statGlobalRank,
                          value: vmState.user!.hiddenFromCommunity
                              ? context.l10n.rankHidden
                              : context.l10n
                                  .rankValue('${vmState.globalRank ?? '-'}'),
                          icon: Icons.public_rounded,
                          color: AppColors.success),
                    ]),
                    SectionTitle(context.l10n.recentAchievements),
                    if (vmState.recentAchievements.isEmpty)
                      Text(context.l10n.noAchievementsYet)
                    else
                      SizedBox(
                        // Room for the card's hover scale-up and shadow.
                        height: InteractiveCard.baseHeight + 48,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          itemCount: vmState.recentAchievements.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 24),
                          itemBuilder: (context, index) {
                            final achievement =
                                vmState.recentAchievements[index];
                            return InteractiveCard(
                              achievement: achievement,
                              heroTag: _heroTag(achievement),
                              onPressed: () =>
                                  viewModel.onTapAchievement(achievement),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ));
            }));
  }

  Widget _buildHeader(BuildContext context) {
    final user = vmState.user!;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ProfileBanner(
                  preset: user.bannerPreset,
                  imagePath: user.bannerImagePath,
                  height: _bannerHeight),
              Positioned(
                right: 16,
                top: 16,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black.withValues(alpha: 0.45),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                  ),
                  onPressed: viewModel.onTapEditProfile,
                  icon: const Icon(Icons.edit_rounded, size: 16),
                  label: Text(context.l10n.editProfile),
                ),
              ),
              Positioned(
                left: 24,
                bottom: -_avatarRadius,
                child: UserAvatar(
                    initials: user.initials,
                    imagePath: user.avatarPath,
                    radius: _avatarRadius,
                    ringColor: colorScheme.surfaceContainer),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: _avatarRadius - 4),
                      Text(user.name,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5)),
                      const SizedBox(height: 2),
                      Text(
                          context.l10n.roleAtCompany(
                              user.role, vmState.company?.name ?? '-'),
                          style: const TextStyle(fontSize: 15)),
                      if (user.bio.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(user.bio,
                            style: TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: colorScheme.onSurfaceVariant)),
                      ],
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          TagChip(label: user.email, icon: Icons.mail_rounded),
                          TagChip(
                              label: context.l10n
                                  .memberSince(formatDate(user.joinedAt)),
                              icon: Icons.event_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                SizedBox(width: 240, child: _buildLevel(colorScheme)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevel(ColorScheme colorScheme) {
    final level = PlayerLevel(vmState.totalPoints);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.military_tech_rounded,
                  color: colorScheme.primary, size: 20),
              const SizedBox(width: 6),
              Expanded(
                child: Text(context.l10n.levelN(level.level),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
              ),
              Text("${level.pointsIntoLevel}/${PlayerLevel.pointsPerLevel}",
                  style: TextStyle(
                      fontSize: 12, color: colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: level.progress,
              minHeight: 8,
              backgroundColor: colorScheme.surfaceContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
              context.l10n
                  .xpToNextLevel(level.pointsToNextLevel, level.level + 1),
              style:
                  TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  @override
  Future<ProfileDraft?> askEditProfile(UserProfile user) =>
      showEditProfileDialog(context,
          user: user, pickImage: viewModel.pickImage);

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void onTapAchievement(Achievement achievement) {
    Navigator.of(context).pushNamed(RouteNames.achievement,
        arguments: NavigatorArguments(
            nativeArgument: achievement,
            nativeArgument2: _heroTag(achievement)));
  }
}
