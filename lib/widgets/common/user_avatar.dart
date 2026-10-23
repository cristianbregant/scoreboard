import 'dart:io';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String initials;
  final double radius;

  /// Local profile photo; initials are shown when null or unreadable.
  final String? imagePath;

  /// Optional ring drawn around the avatar, e.g. to separate it from a banner.
  final Color? ringColor;

  const UserAvatar(
      {super.key,
      required this.initials,
      this.radius = 20,
      this.imagePath,
      this.ringColor});

  static const List<Color> _palette = [
    Color(0xFF4F7396),
    Color(0xFF5E8C6A),
    Color(0xFFB0794A),
    Color(0xFFB45F4F),
    Color(0xFF4F8783),
    Color(0xFF8C7A3E),
  ];

  @override
  Widget build(BuildContext context) {
    final color = _palette[initials.hashCode.abs() % _palette.length];
    final fallback = Text(initials,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: radius * 0.75));

    return Container(
      width: radius * 2,
      height: radius * 2,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: ringColor != null
            ? Border.all(color: ringColor!, width: radius * 0.1)
            : null,
      ),
      child: imagePath != null
          ? Image.file(
              File(imagePath!),
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
              frameBuilder: (_, child, frame, __) =>
                  frame == null ? fallback : child,
              errorBuilder: (_, __, ___) => fallback,
            )
          : fallback,
    );
  }
}
