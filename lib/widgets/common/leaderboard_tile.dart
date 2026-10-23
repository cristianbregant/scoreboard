import 'package:flutter/material.dart';

const List<Color> podiumColors = [
  Color(0xFFF6C744),
  Color(0xFFB8C1CF),
  Color(0xFFD08A5B),
];

class LeaderboardTile extends StatelessWidget {
  final int rank;
  final Widget leading;
  final String title;
  final String subtitle;
  final int points;
  final bool highlighted;

  /// Optional button shown before the points, e.g. to send an achievement.
  final Widget? action;

  const LeaderboardTile(
      {super.key,
      required this.rank,
      required this.leading,
      required this.title,
      required this.subtitle,
      required this.points,
      this.highlighted = false,
      this.action});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final podiumColor = rank <= 3 ? podiumColors[rank - 1] : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: highlighted
              ? colorScheme.primary.withValues(alpha: 0.1)
              : colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: highlighted
                  ? colorScheme.primary.withValues(alpha: 0.5)
                  : colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Text(
                "$rank",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: podiumColor ?? colorScheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(width: 8),
            leading,
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 14.5, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            if (action != null) ...[action!, const SizedBox(width: 8)],
            PointsBadge(points: points),
          ],
        ),
      ),
    );
  }
}

class PointsBadge extends StatelessWidget {
  final int points;

  const PointsBadge({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text("$points XP",
          style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary)),
    );
  }
}
