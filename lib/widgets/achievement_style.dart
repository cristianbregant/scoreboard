import 'package:flutter/material.dart';
import 'package:scoreboard/model/achievement.dart';

/// Company-issued achievements are ranked by points (bronze to platinum);
/// achievements sent between colleagues all share the [peer] style.
enum AchievementTier {
  peer([Color(0xFF3F6B52), Color(0xFF8FBF9F)]),
  bronze([Color(0xFF8A4B2A), Color(0xFFD08A5B)]),
  silver([Color(0xFF5B6478), Color(0xFFC7CEDB)]),
  gold([Color(0xFFB7791F), Color(0xFFF6D365)]),
  platinum([Color(0xFF35597A), Color(0xFFA9CFEE)]);

  /// Gradient stops; the display name is in `AchievementTierText`.
  final List<Color> colors;

  const AchievementTier(this.colors);

  factory AchievementTier.fromPoints(int points) {
    if (points >= 140) return AchievementTier.platinum;
    if (points >= 120) return AchievementTier.gold;
    if (points >= 100) return AchievementTier.silver;
    return AchievementTier.bronze;
  }

  Color get color => colors.last;

  LinearGradient get gradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      );
}

extension AchievementStyle on Achievement {
  AchievementTier get tier => verified == true
      ? AchievementTier.fromPoints(points ?? 0)
      : AchievementTier.peer;

  IconData get iconData => achievementIcons[icon] ?? Icons.emoji_events_rounded;
}

/// Icon keys stored on achievements, mapped to the icon drawn for them.
const Map<String, IconData> achievementIcons = {
  'handshake_icon.png': Icons.handshake_rounded,
  'star_icon.png': Icons.star_rounded,
  'heart_icon.png': Icons.favorite_rounded,
  'coffee_icon.png': Icons.coffee_rounded,
  'review_icon.png': Icons.rate_review_rounded,
  'support_icon.png': Icons.support_rounded,
  'celebration_icon.png': Icons.celebration_rounded,
  'anniversary_icon.png': Icons.cake_rounded,
  'speed_icon.png': Icons.speed_rounded,
  'code_icon.png': Icons.code_rounded,
  'bug_icon.png': Icons.bug_report_rounded,
  'innovation_icon.png': Icons.lightbulb_rounded,
  'opensource_icon.png': Icons.hub_rounded,
  'data_icon.png': Icons.insights_rounded,
  'agile_icon.png': Icons.bolt_rounded,
  'cybersecurity_icon.png': Icons.shield_rounded,
  'cloud_icon.png': Icons.cloud_rounded,
  'mentor_icon.png': Icons.school_rounded,
  'ci_icon.png': Icons.rocket_launch_rounded,
};
