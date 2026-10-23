import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/achievement/achievement_contract.dart';
import 'package:window_manager/window_manager.dart';

class AchievementView extends BaseStatefulWidget {
  final Achievement achievement;
  final Object? heroTag;
  AchievementView({Key? key, required this.achievement, this.heroTag})
      : super(_AchievementViewState(), key: key);
}

class _AchievementViewState extends BaseState<
    AchievementView,
    AchievementViewModelContract,
    AchievementState> implements AchievementViewContract {
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
                  DragToMoveArea(
                    child: Padding(
                      // Clears the macOS traffic lights.
                      padding: const EdgeInsets.fromLTRB(84, 10, 24, 0),
                      child: Row(
                        children: [
                          IconButton.filledTonal(
                            tooltip: "Back",
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(Icons.arrow_back_rounded),
                          ),
                          const SizedBox(width: 12),
                          Text("Achievement",
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
                Icon(Icons.flip_rounded,
                    size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Text("Click the card to flip it",
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
                  label: tier.label,
                  icon: Icons.workspace_premium_rounded,
                  color: tier.color),
              const TagChip(
                  label: "Verified by the company",
                  icon: Icons.verified_rounded,
                  color: AppColors.verified),
            ] else
              TagChip(
                  label: "From a colleague",
                  icon: Icons.handshake_rounded,
                  color: tier.color),
          ],
        ),
        const SizedBox(height: 16),
        Text(achievement.name ?? '',
            style: const TextStyle(
                fontSize: 34,
                height: 1.1,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8)),
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
              label: "Experience",
              value: "${achievement.points ?? 0} XP",
              icon: Icons.bolt_rounded),
          StatTile(
              label: "Tier",
              value: tier.label,
              icon: Icons.workspace_premium_rounded,
              color: tier.color),
        ]),
        const SizedBox(height: 12),
        StatRow(tiles: [
          if (achievement.verified == true)
            StatTile(
                label: "Company",
                value: achievement.company ?? '-',
                icon: Icons.business_rounded,
                leading: CompanyLogo(
                    name: achievement.company ?? '',
                    brand: achievement.companyBrand,
                    size: 42))
          else
            StatTile(
                label: "Sent by",
                value: achievement.awardedByName ?? '-',
                icon: Icons.person_rounded,
                color: AppColors.verified),
          StatTile(
              label: "Earned on",
              value: formatDate(achievement.date),
              icon: Icons.event_rounded,
              color: AppColors.success),
        ]),
        const SizedBox(height: 20),
        Text("ID ${achievement.id ?? '-'}",
            style:
                TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
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
          Text("\u2014 ${achievement.awardedByName ?? 'A colleague'}",
              style:
                  TextStyle(fontSize: 13, color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
