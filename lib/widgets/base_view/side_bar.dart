import 'package:scoreboard/core/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/widgets/common/nav_button.dart';
import 'package:scoreboard/core/window_chrome.dart';

class Sidebar extends StatelessWidget {
  final List<SidebarItem> items;
  final Function(int index) onItemSelected;
  final int index;
  final Widget? leading;
  final Widget? trailing;

  /// Shown at the end of the header row, e.g. the notifications bell.
  final Widget? headerAction;
  const Sidebar(
      {super.key,
      required this.items,
      required this.onItemSelected,
      required this.index,
      this.leading,
      this.trailing,
      this.headerAction});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 232,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border(right: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Column(children: [
        // Leaves room for the macOS traffic lights and lets the user drag
        // the window where the title bar is hidden.
        WindowDragArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20 + WindowChrome.topInset, 8, 24),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(Icons.emoji_events_rounded,
                      color: colorScheme.onPrimary, size: 19),
                ),
                const SizedBox(width: 12),
                // Shrinks rather than wrapping when the header action
                // leaves little room.
                const Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text("Scoreboard",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4)),
                  ),
                ),
                if (headerAction != null) headerAction!,
              ],
            ),
          ),
        ),
        if (leading != null) leading!,
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(context.l10n.menuLabel,
                style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++)
                NavButton(
                  label: items[i].label,
                  icon: items[i].icon,
                  selectedIcon: items[i].selectedIcon,
                  selected: i == index,
                  onTap: () => onItemSelected(i),
                ),
            ],
          ),
        ),
        const Spacer(),
        if (trailing != null)
          Padding(padding: const EdgeInsets.all(12), child: trailing!),
      ]),
    );
  }
}

class SidebarItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  SidebarItem(
      {required this.label, required this.icon, required this.selectedIcon});
}
