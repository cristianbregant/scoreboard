import 'package:flutter/material.dart';
import 'package:scoreboard/core/theme.dart';

/// One figure of a [StatRow]: a small label with its icon over a large
/// number, like a scoreboard.
class StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  /// Tints the icon; defaults to the theme's accent.
  final Color? color;

  /// Replaces the tinted [icon], e.g. with a company logo.
  final Widget? leading;

  /// A detail under the figure, e.g. "10 verified".
  final String? caption;

  const StatTile(
      {super.key,
      required this.label,
      required this.value,
      required this.icon,
      this.color,
      this.leading,
      this.caption});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color =
        colorScheme.legible(this.color ?? colorScheme.primary, minContrast: 3);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpace.lg + 4, AppSpace.lg, AppSpace.lg, AppSpace.lg + 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: 16,
                // Any leading is scaled to the icon's slot.
                child: leading == null
                    ? Icon(icon, color: color, size: 15)
                    : FittedBox(child: leading),
              ),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                child: Text(label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.5,
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant)),
              ),
            ],
          ),
          // Figures share one line across the row; captions hang below.
          const SizedBox(height: AppSpace.md),
          _TickingFigure(value),
          if (caption != null)
            Text(caption!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12, color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

/// [value], whose first number counts up to its final value when it first
/// appears or changes, like a scoreboard catching up. Static when the
/// platform asks for reduced motion.
class _TickingFigure extends StatelessWidget {
  final String value;

  const _TickingFigure(this.value);

  static final RegExp _number = RegExp(r'^(\D*)(\d+)(.*)$');

  @override
  Widget build(BuildContext context) {
    final match = _number.firstMatch(value);
    Widget text(String shown) => Text(shown,
        maxLines: 1, overflow: TextOverflow.ellipsis, style: AppText.figure);
    if (match == null || MediaQuery.disableAnimationsOf(context)) {
      return text(value);
    }
    final target = int.parse(match.group(2)!);
    // Screen readers get the final value, not every step on the way.
    return Semantics(
      label: value,
      excludeSemantics: true,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: target.toDouble()),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        builder: (context, shown, _) =>
            text('${match.group(1)}${shown.round()}${match.group(3)}'),
      ),
    );
  }
}

/// Lays out [StatTile]s as one panel of equal-width cells split by hairlines.
class StatRow extends StatelessWidget {
  final List<StatTile> tiles;

  const StatRow({super.key, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      // Same height for every tile, even when a label wraps.
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < tiles.length; i++) ...[
              if (i > 0) const VerticalDivider(width: 1),
              Expanded(child: tiles[i]),
            ]
          ],
        ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final foreground =
        colorScheme.legible(color ?? colorScheme.onSurfaceVariant, tint: 0.12);
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
          // Shrinks with an ellipsis in a narrow parent.
          Flexible(
            child: Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: foreground)),
          ),
        ],
      ),
    );
  }
}
