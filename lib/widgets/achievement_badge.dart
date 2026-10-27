import 'package:flutter/material.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Compact square with the achievement's icon on its tier gradient, for
/// lists where a full card would be too big.
class AchievementBadge extends StatelessWidget {
  final Achievement achievement;
  final double size;

  const AchievementBadge(
      {super.key, required this.achievement, this.size = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: achievement.tier.gradient,
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(achievement.iconData, color: Colors.white, size: size * 0.52),
    );
  }
}

extension ReactionTypeIcon on ReactionType {
  IconData get icon => switch (this) {
        ReactionType.like => LucideIcons.thumbsUp,
        ReactionType.celebrate => LucideIcons.partyPopper,
        ReactionType.love => LucideIcons.heart,
        ReactionType.insightful => LucideIcons.lightbulb,
      };

  Color get color => switch (this) {
        ReactionType.like => const Color(0xFF4A9FD8),
        ReactionType.celebrate => const Color(0xFFE9B949),
        ReactionType.love => const Color(0xFFD9605A),
        ReactionType.insightful => const Color(0xFF8FBF9F),
      };
}
