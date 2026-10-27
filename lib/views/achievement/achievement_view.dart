import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/dialogs/share_achievement_dialog.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/achievement/achievement_contract.dart';
import 'package:scoreboard/core/window_chrome.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AchievementView extends BaseStatefulWidget {
  final Achievement achievement;
  final Object? heroTag;
  AchievementView({super.key, required this.achievement, this.heroTag})
      : super(_AchievementViewState());
}

class _AchievementViewState extends BaseState<
    AchievementView,
    AchievementViewModelContract,
    AchievementState> implements AchievementViewContract {
  @override
  void openShareDialog(Achievement achievement, String postText,
      {required bool canAddToProfile}) {
    showShareAchievementDialog(
      context,
      achievement: achievement,
      postText: postText,
      onPost: viewModel.onPostOnLinkedIn,
      onCopy: viewModel.onCopyPostText,
      onSaveImage: (png) => viewModel.onSaveShareImage(png, achievement),
      onAddToProfile: canAddToProfile
          ? () => viewModel.onAddToLinkedInProfile(achievement)
          : null,
    );
  }

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final achievement = widget.achievement;
    final tier = achievement.tier;
    final colorScheme = Theme.of(context).colorScheme;

    return BaseWidget<AchievementViewModelContract, AchievementState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WindowDragArea(
                    child: Padding(
                      // Clears the macOS traffic lights.
                      padding: EdgeInsets.fromLTRB(
                          16 + WindowChrome.leadingInset, 10, 24, 0),
                      child: Row(
                        children: [
                          IconButton.filledTonal(
                            tooltip: context.l10n.commonBack,
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(LucideIcons.arrowLeft),
                          ),
                          const SizedBox(width: 12),
                          Text(context.l10n.achievementDetailTitle,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShowcase(tier),
                          const SizedBox(width: 32),
                          Expanded(child: _buildDetails(colorScheme, tier)),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
            }));
  }

  Widget _buildShowcase(AchievementTier tier) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 340,
      height: 440,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radius * 1.5),
        // Radius 0.5 fades out exactly at the edges, so no box is visible.
        gradient: RadialGradient(
          radius: 0.5,
          colors: [
            tier.color.withValues(alpha: 0.14),
            tier.color.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InteractiveCard(
              achievement: widget.achievement,
              heroTag: widget.heroTag,
              width: 250,
              flipOnTap: true,
              onPressed: () {}),
          if (InteractiveCard.canFlip(widget.achievement)) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.flipHorizontal2,
                    size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(context.l10n.flipHint,
                    style: TextStyle(
                        fontSize: 12, color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetails(ColorScheme colorScheme, AchievementTier tier) {
    final achievement = widget.achievement;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [
            if (achievement.verified == true) ...[
              TagChip(
                  label: tier.localized(context.l10n),
                  icon: LucideIcons.award,
                  color: tier.color),
              TagChip(
                  label: context.l10n.verifiedByCompany,
                  icon: LucideIcons.badgeCheck,
                  color: AppColors.verified),
            ] else
              TagChip(
                  label: context.l10n.fromAColleague,
                  icon: LucideIcons.handshake,
                  color: tier.color),
          ],
        ),
        const SizedBox(height: 16),
        Text(achievement.name ?? '',
            style: AppText.pageTitle
                .copyWith(fontSize: 34, height: 1.1, letterSpacing: -1.2)),
        const SizedBox(height: 12),
        Text(achievement.description ?? '',
            style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: colorScheme.onSurfaceVariant)),
        if (achievement.note != null) ...[
          const SizedBox(height: 20),
          _buildNote(colorScheme, tier),
        ],
        const SizedBox(height: 28),
        StatRow(tiles: [
          StatTile(
              label: context.l10n.detailExperience,
              value: context.l10n.xpValue(achievement.points ?? 0),
              icon: LucideIcons.zap),
          StatTile(
              label: context.l10n.detailTier,
              value: tier.localized(context.l10n),
              icon: LucideIcons.award,
              color: tier.color),
        ]),
        const SizedBox(height: 12),
        StatRow(tiles: [
          if (achievement.verified == true)
            StatTile(
                label: context.l10n.detailCompany,
                value: achievement.company ?? '-',
                icon: LucideIcons.building2,
                leading: CompanyLogo(
                    name: achievement.company ?? '',
                    brand: achievement.companyBrand,
                    size: 16))
          else
            StatTile(
                label: context.l10n.detailSentBy,
                value: achievement.awardedByName ?? '-',
                icon: LucideIcons.user,
                color: AppColors.verified),
          StatTile(
              label: context.l10n.detailEarnedOn,
              value: formatDate(achievement.date),
              icon: LucideIcons.calendar,
              color: AppColors.success),
        ]),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Text(context.l10n.detailId(achievement.id ?? '-'),
                  style: TextStyle(
                      fontSize: 12, color: colorScheme.onSurfaceVariant)),
            ),
            if (achievement.verified == true) ...[
              MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    leadingIcon: const Icon(LucideIcons.fileText),
                    onPressed: () => viewModel.onExportPdf(achievement),
                    child: Text(context.l10n.exportPdf),
                  ),
                  MenuItemButton(
                    leadingIcon: const Icon(LucideIcons.braces),
                    onPressed: () => viewModel.onExportOpenBadge(achievement),
                    child: Tooltip(
                        message: context.l10n.exportOpenBadgeHint,
                        child: Text(context.l10n.exportOpenBadge)),
                  ),
                ],
                builder: (context, controller, _) => OutlinedButton.icon(
                  onPressed: () => controller.isOpen
                      ? controller.close()
                      : controller.open(),
                  icon: const Icon(LucideIcons.download, size: 18),
                  label: Text(context.l10n.exportMenu),
                ),
              ),
              const SizedBox(width: 8),
            ],
            FilledButton.icon(
              onPressed: () => viewModel.onTapShare(achievement),
              icon: const Icon(LucideIcons.share2, size: 18),
              label: Text(context.l10n.shareOnLinkedIn),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNote(ColorScheme colorScheme, AchievementTier tier) {
    final achievement = widget.achievement;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tier.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: tier.color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\u201c${achievement.note}\u201d",
              style: const TextStyle(
                  fontSize: 15, height: 1.4, fontStyle: FontStyle.italic)),
          const SizedBox(height: 6),
          Text(
              "\u2014 ${(achievement.verified == true ? achievement.company : achievement.awardedByName) ?? context.l10n.noteAuthorFallback}",
              style:
                  TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
