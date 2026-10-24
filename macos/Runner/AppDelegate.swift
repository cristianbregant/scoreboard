import Cocoa
import FlutterMacOS
import multiview_desktop

@main
class AppDelegate: FlutterAppDelegate {
  // multiview_desktop decides, from the Dart close settings.
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return MultiviewDesktopPlugin.applicationShouldTerminateAfterLastWindowClosed()
  }

  // The window hides to the menu bar on close; clicking the Dock icon
  // brings it back.
  override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    if MultiviewDesktopPlugin.applicationShouldHandleReopen(sender, hasVisibleWindows: flag) {
      return true
    }
    return super.applicationShouldHandleReopen(sender, hasVisibleWindows: flag)
  }

  // ⌘Q and Quit: runs MacosPlatformParams.onTerminate in main.dart first.
  override func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
    return MultiviewDesktopPlugin.applicationShouldTerminate(sender)
  }

  override func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
    return MultiviewDesktopPlugin.applicationDockMenu(sender)
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
