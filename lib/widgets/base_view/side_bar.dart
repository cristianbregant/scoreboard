import 'package:scoreboard/core/theme.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final List<SidebarItem> items;
  final Function(int index) onItemSelected;
  final int index;
  final Widget? leading;
  final Widget? trailing;
  const Sidebar(
      {super.key,
      required this.items,
      required this.onItemSelected,
      required this.index,
      this.leading,
      this.trailing});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: WelcomeDeployerColors.sidebarBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(children: [
        const SizedBox(
          height: 16,
        ),
        Text("Scoreboard",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 16,
        ),
        if (widget.leading != null) widget.leading!,
        Column(
          children: [
            ...widget.items.map((item) {
              bool isSelected = widget.items.indexOf(item) == widget.index;
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                child: Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 2.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    selectedColor: Colors.white,
                    iconColor: isSelected
                        ? WelcomeDeployerColors.tertiaryColor
                        : WelcomeDeployerColors.primaryColor,
                    selectedTileColor: WelcomeDeployerColors.primaryColor,
                    selected: isSelected,
                    onTap: () =>
                        widget.onItemSelected(widget.items.indexOf(item)),
                    leading:
                        isSelected ? Icon(item.selectedIcon) : Icon(item.icon),
                    title: Text(item.label),
                  ),
                ),
              );
            })
          ],
        ),
        if (widget.trailing != null) widget.trailing!,
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
