import 'package:flutter/material.dart';

/// Navigation entry used by the sidebar and the settings menu.
class NavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool selected;
  final VoidCallback onTap;

  /// A count at the end, e.g. pending requests; hidden when 0.
  final int badge;

  const NavButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.selectedIcon,
      required this.selected,
      required this.onTap,
      this.badge = 0});

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool isHovering = false;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final highlighted = isHovering || isFocused;
    final foreground = widget.selected
        ? colorScheme.primary
        : highlighted
            ? colorScheme.onSurface
            : colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      // Reachable with Tab and activated with Enter or Space, like a
      // button; screen readers announce it as one, selected or not.
      child: Semantics(
        button: true,
        selected: widget.selected,
        child: FocusableActionDetector(
          mouseCursor: SystemMouseCursors.click,
          onShowHoverHighlight: (value) => setState(() => isHovering = value),
          onShowFocusHighlight: (value) => setState(() => isFocused = value),
          actions: {
            ActivateIntent:
                CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onTap()),
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              // 2px less than the look aims for: the focus border fills it.
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.selected
                    ? colorScheme.primary.withValues(alpha: 0.14)
                    : highlighted
                        ? colorScheme.onSurface.withValues(alpha: 0.05)
                        : Colors.transparent,
                border: Border.all(
                    color: isFocused ? colorScheme.primary : Colors.transparent,
                    width: 2),
              ),
              child: Row(
                children: [
                  Icon(widget.selected ? widget.selectedIcon : widget.icon,
                      size: 18, color: foreground),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13.5,
                            letterSpacing: -0.1,
                            color: foreground,
                            fontWeight: widget.selected
                                ? FontWeight.w600
                                : FontWeight.w500)),
                  ),
                  if (widget.badge > 0)
                    Container(
                      constraints: const BoxConstraints(minWidth: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('${widget.badge}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary)),
                    )
                  else if (widget.selected)
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
      ),
    );
  }
}
