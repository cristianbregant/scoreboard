import 'package:flutter/material.dart';
import 'package:scoreboard/core/theme.dart';

/// Horizontal and top padding shared by every page so content lines up.
const EdgeInsets pagePadding = EdgeInsets.fromLTRB(32, 40, 32, 32);

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const PageHeader(
      {super.key, required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppText.pageTitle),
              if (subtitle != null) ...[
                const SizedBox(height: 6),
                Text(subtitle!,
                    style: TextStyle(
                        fontSize: 14.5,
                        height: 1.4,
                        color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppSpace.lg),
          trailing!,
        ],
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionTitle(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: AppText.sectionTitle),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
