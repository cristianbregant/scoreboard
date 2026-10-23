import 'package:flutter/material.dart';

/// Navigation entry used by the sidebar and the settings menu.
class NavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool selected;
  final VoidCallback onTap;

  const NavButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.selectedIcon,
      required this.selected,
      required this.onTap});

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = widget.selected
        ? colorScheme.primary
        : isHovering
            ? colorScheme.onSurface
            : colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovering = true),
        onExit: (_) => setState(() => isHovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.selected
                  ? colorScheme.primary.withValues(alpha: 0.14)
                  : isHovering
                      ? colorScheme.onSurface.withValues(alpha: 0.05)
                      : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(widget.selected ? widget.selectedIcon : widget.icon,
                    size: 20, color: foreground),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(widget.label,
                      style: TextStyle(
                          fontSize: 14,
                          color: foreground,
                          fontWeight: widget.selected
                              ? FontWeight.w600
                              : FontWeight.w500)),
                ),
                if (widget.selected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        color: colorScheme.primary, shape: BoxShape.circle),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
