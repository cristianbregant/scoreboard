import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

enum BannerPattern { grid, topography, dots, waves, diagonal, plain }

class BannerPreset {
  final String key;
  final String label;
  final Color background;
  final Color ink;
  final BannerPattern pattern;

  const BannerPreset(
      this.key, this.label, this.background, this.ink, this.pattern);
}

const List<BannerPreset> bannerPresets = [
  BannerPreset('graphite_grid', 'Graphite', Color(0xFF24272C),
      Color(0x14FFFFFF), BannerPattern.grid),
  BannerPreset('gold_topography', 'Gold', Color(0xFF2B2416), Color(0x55E9B949),
      BannerPattern.topography),
  BannerPreset('forest_dots', 'Forest', Color(0xFF233A2E), Color(0x26FFFFFF),
      BannerPattern.dots),
  BannerPreset('ocean_waves', 'Ocean', Color(0xFF1C3347), Color(0x2EA9CFEE),
      BannerPattern.waves),
  BannerPreset('clay_diagonal', 'Clay', Color(0xFF6B3F2E), Color(0x1FFFFFFF),
      BannerPattern.diagonal),
  BannerPreset('sand_plain', 'Sand', Color(0xFFD8CCB4), Color(0x00000000),
      BannerPattern.plain),
];

BannerPreset bannerPresetOf(String key) => bannerPresets
    .firstWhere((p) => p.key == key, orElse: () => bannerPresets.first);

/// Profile cover: a custom image when available, a preset pattern otherwise.
class ProfileBanner extends StatelessWidget {
  final String preset;
  final String? imagePath;
  final double height;

  const ProfileBanner(
      {super.key, required this.preset, this.imagePath, this.height = 132});

  @override
  Widget build(BuildContext context) {
    final pattern = BannerPatternView(preset: bannerPresetOf(preset));
    return SizedBox(
      height: height,
      width: double.infinity,
      child: imagePath != null
          ? Image.file(File(imagePath!),
              fit: BoxFit.cover,
              // The preset stays visible while the image loads.
              frameBuilder: (_, child, frame, __) =>
                  frame == null ? pattern : child,
              errorBuilder: (_, __, ___) => pattern)
          : pattern,
    );
  }
}

class BannerPatternView extends StatelessWidget {
  final BannerPreset preset;

  const BannerPatternView({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    // The painters draw past the edges; keep them inside the banner.
    return ClipRect(
      child: ColoredBox(
        color: preset.background,
        child: CustomPaint(
          painter: _PatternPainter(preset.pattern, preset.ink),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final BannerPattern pattern;
  final Color ink;

  _PatternPainter(this.pattern, this.ink);

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = ink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    switch (pattern) {
      case BannerPattern.grid:
        for (double x = 0; x < size.width; x += 24) {
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), stroke);
        }
        for (double y = 0; y < size.height; y += 24) {
          canvas.drawLine(Offset(0, y), Offset(size.width, y), stroke);
        }
      case BannerPattern.topography:
        // Concentric, slightly wobbly rings around two off-screen peaks.
        for (final center in [
          Offset(size.width * 0.82, size.height * 0.15),
          Offset(size.width * 0.18, size.height * 1.1),
        ]) {
          for (var r = 18.0; r < size.width * 0.6; r += 16) {
            final path = Path();
            for (var a = 0.0; a <= math.pi * 2 + 0.01; a += 0.08) {
              final wobble = 1 + 0.08 * math.sin(a * 3 + r / 30);
              final p = center +
                  Offset(
                      math.cos(a) * r * wobble, math.sin(a) * r * wobble * 0.7);
              a == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
            }
            canvas.drawPath(path, stroke);
          }
        }
      case BannerPattern.dots:
        final fill = Paint()..color = ink;
        for (double y = 10; y < size.height; y += 16) {
          for (double x = 10; x < size.width; x += 16) {
            canvas.drawCircle(Offset(x, y), 1.4, fill);
          }
        }
      case BannerPattern.waves:
        stroke.strokeWidth = 1.5;
        for (double y = -10; y < size.height + 20; y += 14) {
          final path = Path()..moveTo(0, y);
          for (double x = 0; x <= size.width; x += 8) {
            path.lineTo(x, y + math.sin(x / 40 + y / 25) * 6);
          }
          canvas.drawPath(path, stroke);
        }
      case BannerPattern.diagonal:
        stroke.strokeWidth = 6;
        for (double x = -size.height; x < size.width; x += 22) {
          canvas.drawLine(
              Offset(x, size.height), Offset(x + size.height, 0), stroke);
        }
      case BannerPattern.plain:
        break;
    }
  }

  @override
  bool shouldRepaint(_PatternPainter oldDelegate) =>
      oldDelegate.pattern != pattern || oldDelegate.ink != ink;
}
