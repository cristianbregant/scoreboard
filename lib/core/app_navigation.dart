import 'package:flutter/foundation.dart';

/// Pages of the main window, in sidebar order.
enum AppPage {
  achievements,
  baseAchievements,
  feed,
  yourCompany,

  /// Team managers only.
  team,
  community,
  profile,

  /// Company admins only, in admin mode.
  console,
  settings,
}

/// Sections of the admin console, listed in the sidebar in admin mode, in
/// this order.
enum ConsoleSection {
  catalog,
  assign,
  requests,
  teams,
  seasons,
  insights,
  reports,
  activity,
  company,
}

enum NavigationRequest { openPage, quickSend, openNotifications }

/// Lets parts of the app outside the main window's view model (other pages,
/// keyboard shortcuts, the tray menu) ask it to navigate.
class AppNavigation extends ChangeNotifier {
  NavigationRequest? _request;
  AppPage? _page;

  /// Console section picked in the sidebar; the console page follows it.
  final ValueNotifier<ConsoleSection> consoleSection =
      ValueNotifier(ConsoleSection.catalog);

  /// Read once by the main window; returns null when nothing is pending.
  (NavigationRequest, AppPage?)? takeRequest() {
    final request = _request;
    if (request == null) return null;
    final page = _page;
    _request = null;
    _page = null;
    return (request, page);
  }

  void openPage(AppPage page) => _send(NavigationRequest.openPage, page);

  /// Opens the "send an achievement" dialog over the current page.
  void quickSend() => _send(NavigationRequest.quickSend);

  void openNotifications() => _send(NavigationRequest.openNotifications);

  void _send(NavigationRequest request, [AppPage? page]) {
    _request = request;
    _page = page;
    notifyListeners();
  }
}
