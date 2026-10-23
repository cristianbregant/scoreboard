import 'package:flutter/material.dart';
import 'package:scoreboard/widgets/common/leaderboard_tile.dart';

class PodiumEntry {
  final Widget avatar;
  final String title;
  final String subtitle;
  final int points;

  const PodiumEntry(
      {required this.avatar,
      required this.title,
      required this.subtitle,
      required this.points});
}

/// Top three of a leaderboard, laid out 2nd - 1st - 3rd.
class Podium extends StatelessWidget {
  final List<PodiumEntry> entries;

  const Podium({super.key, required this.entries});

  static const List<double> _heights = [112, 86, 66];

  @override
  Widget build(BuildContext context) {
    final order = [1, 0, 2].where((i) => i < entries.length);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final i in order)
              Expanded(child: _buildStep(context, entries[i], i)),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, PodiumEntry entry, int index) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = podiumColors[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          if (index == 0)
            Icon(Icons.workspace_premium_rounded, color: color, size: 26),
          entry.avatar,
          const SizedBox(height: 8),
          Text(entry.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          Text(entry.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
          const SizedBox(height: 10),
          Container(
            height: _heights[index],
            width: double.infinity,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha: 0.35),
                  color.withValues(alpha: 0.04),
                ],
              ),
            ),
            child: Column(
              children: [
                Text("${index + 1}",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: color)),
                Text("${entry.points} XP",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
