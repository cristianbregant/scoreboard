import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/insights.dart';

/// Stacked columns: verified (bottom) and peer (top) achievements per month.
class MonthlyAchievementsChart extends StatelessWidget {
  final List<MonthlyCount> months;

  const MonthlyAchievementsChart({super.key, required this.months});

  static const double _plotHeight = 180;
  static const double _barWidth = 24;
  static const double _gap = 2;
  static const double _capLabelHeight = 22;

  /// A clean axis maximum (1, 2, 5, 10, 20, 50, …) above [value].
  static int _niceMax(int value) {
    if (value <= 4) return 4;
    final magnitude =
        math.pow(10, (math.log(value) / math.ln10).floor()).toInt();
    for (final step in [1, 2, 5, 10]) {
      final candidate = step * magnitude;
      if (candidate >= value) return candidate;
    }
    return 10 * magnitude;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final verifiedColor =
        dark ? AppColors.chartVerifiedDark : AppColors.chartVerifiedLight;
    const peerColor = AppColors.chartPeer;
    final maxTotal = months.fold(0, (m, c) => math.max(m, c.total));
    final axisMax = _niceMax(maxTotal);
    final mutedStyle =
        TextStyle(fontSize: 11.5, color: colorScheme.onSurfaceVariant);
    final monthFormat = DateFormat.MMM();

    Widget legendItem(Color color, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(fontSize: 12.5, color: colorScheme.onSurface)),
          ],
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 16, children: [
          legendItem(verifiedColor, l10n.statVerified),
          legendItem(peerColor, l10n.legendPeer),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          height: _plotHeight + _capLabelHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Y axis: 0, half and the maximum.
              SizedBox(
                width: 28,
                child: Stack(
                  // Tick labels are centered on their line, so the lowest
                  // one reaches below the plot.
                  clipBehavior: Clip.none,
                  children: [
                    for (final value in [0, axisMax ~/ 2, axisMax])
                      Positioned(
                        right: 6,
                        bottom: value / axisMax * _plotHeight - 7,
                        child: Text('$value',
                            style: mutedStyle.copyWith(fontFeatures: const [
                              FontFeature.tabularFigures()
                            ])),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    for (final value in [0, axisMax ~/ 2, axisMax])
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: value / axisMax * _plotHeight,
                        child: Container(
                            height: 1, color: colorScheme.outlineVariant),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final month in months)
                          Expanded(
                            child: _Column(
                              month: month,
                              label: monthFormat.format(month.month),
                              scale: _plotHeight / axisMax,
                              verifiedColor: verifiedColor,
                              peerColor: peerColor,
                              gapColor: colorScheme.surfaceContainer,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const SizedBox(width: 28),
            for (final month in months)
              Expanded(
                child: Text(monthFormat.format(month.month),
                    textAlign: TextAlign.center, style: mutedStyle),
              ),
          ],
        ),
      ],
    );
  }
}

class _Column extends StatelessWidget {
  final MonthlyCount month;
  final String label;
  final double scale;
  final Color verifiedColor;
  final Color peerColor;
  final Color gapColor;

  const _Column(
      {required this.month,
      required this.label,
      required this.scale,
      required this.verifiedColor,
      required this.peerColor,
      required this.gapColor});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    const width = MonthlyAchievementsChart._barWidth;
    const gap = MonthlyAchievementsChart._gap;
    const top = Radius.circular(4);
    final summary =
        '$label · ${l10n.statVerified}: ${month.verified} · ${l10n.legendPeer}: ${month.peer}';

    Widget segment(int count, Color color, {required bool isTop}) => Container(
          width: width,
          height: math.max(count * scale - (isTop ? 0 : gap), 0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: isTop
                ? const BorderRadius.only(topLeft: top, topRight: top)
                : null,
          ),
        );

    return Semantics(
      label: summary,
      child: Tooltip(
        message: summary,
        child: MouseRegion(
          cursor: SystemMouseCursors.basic,
          // The hit target spans the whole slot, wider than the bar.
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (month.total > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('${month.total}',
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface)),
                  ),
                if (month.peer > 0) segment(month.peer, peerColor, isTop: true),
                if (month.peer > 0 && month.verified > 0)
                  Container(width: width, height: gap, color: gapColor),
                if (month.verified > 0)
                  segment(month.verified, verifiedColor,
                      isTop: month.peer == 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
