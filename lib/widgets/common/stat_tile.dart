import 'package:flutter/material.dart';

class StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  /// Defaults to the theme's accent.
  final Color? color;

  /// Replaces the tinted [icon], e.g. with a company logo.
  final Widget? leading;

  const StatTile(
      {super.key,
      required this.label,
      required this.value,
      required this.icon,
      this.color,
      this.leading});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = this.color ?? colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            leading ??
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4)),
                  Text(label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lays out [StatTile]s in a row of equal-width cells.
class StatRow extends StatelessWidget {
  final List<StatTile> tiles;

  const StatRow({super.key, required this.tiles});

  @override
  Widget build(BuildContext context) {
    // Same height for every tile, even when a label wraps.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < tiles.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: tiles[i]),
          ]
        ],
      ),
    );
  }
}

/// Small tinted label, e.g. "Software" or "Gold".
class TagChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;

  const TagChip({super.key, required this.label, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? Theme.of(context).colorScheme.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: foreground.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 5),
          ],
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: foreground)),
        ],
      ),
    );
  }
}
