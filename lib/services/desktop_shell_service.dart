import 'package:flutter/widgets.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/services/desktop_shell_service_io.dart'
    if (dart.library.js_interop) 'package:scoreboard/services/desktop_shell_service_web.dart';

export 'package:scoreboard/services/desktop_shell_service_io.dart'
    if (dart.library.js_interop) 'package:scoreboard/services/desktop_shell_service_web.dart';

/// Keeps the tray menu in the app's current language.
class DesktopShellMenu extends StatefulWidget {
  final DesktopShellService shell;
  final Widget child;

  const DesktopShellMenu({super.key, required this.shell, required this.child});

  @override
  State<DesktopShellMenu> createState() => _DesktopShellMenuState();
}

class _DesktopShellMenuState extends State<DesktopShellMenu> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.shell.updateMenu(AppLocalization.of(context));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
