import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons_300.dart';
import 'package:lucide_icons_flutter/lucide_icons_500.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/window_chrome.dart';
import 'package:scoreboard/widgets/common/nav_button.dart';

/// The main window's navigation, set in Geist with Lucide icons.
///
/// In admin mode it lists the console sections, on a background tinted
/// with the admin accent (the theme around it provides the accent).
class Sidebar extends StatelessWidget {
  static const String fontFamily = 'Geist';

  final List<SidebarItem> items;
  final ValueChanged<int> onItemSelected;
  final int index;

  /// Small caps label above [items], e.g. "MENU"; items can also carry
  /// their own, see [SidebarItem.header].
  final String? sectionLabel;
  final bool adminMode;

  /// Under the header, e.g. [AdminBanner].
  final Widget? banner;
  final Widget? trailing;

  /// Shown at the end of the header row, e.g. the notifications bell.
  final Widget? headerAction;

  /// The company logo replacing Scoreboard's trophy, a local file.
  final String? logoPath;

  const Sidebar(
      {super.key,
      required this.items,
      required this.onItemSelected,
      required this.index,
      this.sectionLabel,
      this.adminMode = false,
      this.banner,
      this.trailing,
      this.headerAction,
      this.logoPath});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background = adminMode
        ? Color.alphaBlend(colorScheme.primary.withValues(alpha: 0.07),
            colorScheme.surfaceContainerLow)
        : colorScheme.surfaceContainerLow;

    return DefaultTextStyle.merge(
      style: const TextStyle(fontFamily: fontFamily),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 232,
        decoration: BoxDecoration(
          color: background,
          border: Border(right: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: Column(children: [
          // Leaves room for the macOS traffic lights and lets the user drag
          // the window where the title bar is hidden.
          WindowDragArea(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(18, 18 + WindowChrome.topInset, 8, 16),
              child: Row(
                children: [
                  _buildLogo(colorScheme),
                  const SizedBox(width: 10),
                  // Shrinks rather than wrapping when the header action
                  // leaves little room.
                  const Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text('Scoreboard',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4)),
                    ),
                  ),
                  if (headerAction != null) headerAction!,
                ],
              ),
            ),
          ),
          if (banner != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: banner!,
            ),
          // Scrolls when the window is too short for every page, so the
          // user card below always stays visible.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (sectionLabel != null)
                    _SectionLabel(sectionLabel!, first: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        for (var i = 0; i < items.length; i++) ...[
                          if (items[i].header != null)
                            _SectionLabel(items[i].header!,
                                first: i == 0 && sectionLabel == null,
                                inset: 12),
                          NavButton(
                            label: items[i].label,
                            icon: items[i].icon,
                            selectedIcon: items[i].selectedIcon,
                            badge: items[i].badge,
                            selected: i == index,
                            onTap: () => onItemSelected(i),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (trailing != null)
            Padding(padding: const EdgeInsets.all(12), child: trailing!),
        ]),
      ),
    );
  }
}

extension on Sidebar {
  Widget _buildLogo(ColorScheme colorScheme) {
    final trophy = Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child:
          Icon(LucideIcons500.trophy, color: colorScheme.onPrimary, size: 17),
    );
    final path = logoPath;
    if (path == null) return trophy;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(File(path),
          width: 30,
          height: 30,
          fit: BoxFit.cover,
          // A logo moved or deleted outside the app.
          errorBuilder: (_, __, ___) => trophy),
    );
  }
}

class SidebarItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  /// A count shown at the end, e.g. pending requests; hidden when 0.
  final int badge;

  /// Small caps label starting a group with this item.
  final String? header;

  SidebarItem(
      {required this.label,
      required this.icon,
      required this.selectedIcon,
      this.badge = 0,
      this.header});
}

class _SectionLabel extends StatelessWidget {
  final String text;

  /// The first label sits closer to the header above it.
  final bool first;

  /// Already inside the items' horizontal padding.
  final double inset;

  const _SectionLabel(this.text, {this.first = false, this.inset = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24 - inset, first ? 4 : 14, 24 - inset, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text,
            style: TextStyle(
                fontSize: 10.5,
                letterSpacing: 0.9,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ),
    );
  }
}

/// "Admin · Northwind Labs", under the header in admin mode.
class AdminBanner extends StatelessWidget {
  final String label;

  const AdminBanner({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(LucideIcons500.shieldCheck,
              size: 15, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}

/// Switches the window between the app and the admin console.
class AdminModeSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AdminModeSwitch(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: value
          ? colorScheme.primary.withValues(alpha: 0.12)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
            color: value
                ? colorScheme.primary.withValues(alpha: 0.5)
                : colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      // One control for screen readers: the switch, named by its label.
      child: MergeSemantics(
        child: InkWell(
          onTap: () => onChanged(!value),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 4, 6),
            child: Row(
              children: [
                Icon(value ? LucideIcons500.shieldCheck : LucideIcons300.shield,
                    size: 17,
                    color: value
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(context.l10n.adminMode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: value
                              ? colorScheme.primary
                              : colorScheme.onSurface)),
                ),
                // A smaller switch, so the label fits on one line.
                Transform.scale(
                  scale: 0.72,
                  child: Switch(value: value, onChanged: onChanged),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
