import Cocoa
import FlutterMacOS
import multiview_desktop

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    // multiview_desktop needs to set up the engine before the view
    // controller exists: every OS window becomes a view of this engine.
    let engine = FlutterEngine(name: "main_flutter_engine", project: nil, allowHeadlessExecution: true)
    MultiviewDesktopPlugin.prepareEngine(engine, window: self)

    let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
    // The content draws under the hidden title bar.
    flutterViewController.backgroundColor = .clear
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: false)

    RegisterGeneratedPlugins(registry: flutterViewController)
    registerHaptics(messenger: engine.binaryMessenger)
    registerWindowChannel(messenger: engine.binaryMessenger)

    super.awakeFromNib()
  }

  /// Moving and zooming the window from Flutter's drag areas
  /// (lib/core/window_chrome.dart), where the title bar is hidden.
  ///
  /// The drag starts asynchronously on the main queue, after Flutter has
  /// handled the event: `performDrag` runs a tracking loop until the mouse
  /// is released, and started synchronously from inside Flutter's gesture
  /// handling it would freeze the app and swallow the mouse-up.
  private func registerWindowChannel(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "scoreboard/window", binaryMessenger: messenger)
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else {
        result(nil)
        return
      }
      switch call.method {
      case "startDragging":
        DispatchQueue.main.async {
          if let event = self.currentEvent {
            self.performDrag(with: event)
          }
        }
        result(nil)
      case "zoom":
        // Like double-clicking a regular title bar.
        self.zoom(nil)
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  /// Force Touch trackpad feedback for lib/core/haptics.dart, which
  /// Flutter doesn't provide on macOS. The trackpad plays it only during
  /// a press that is still held: the instant of a click is taken by the
  /// click's own feedback, and after release nothing is felt.
  private func registerHaptics(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "scoreboard/haptics", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      guard call.method == "perform" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let pattern: NSHapticFeedbackManager.FeedbackPattern
      switch call.arguments as? String {
      case "alignment": pattern = .alignment
      case "levelChange": pattern = .levelChange
      default: pattern = .generic
      }
      NSHapticFeedbackManager.defaultPerformer.perform(pattern, performanceTime: .now)
      result(nil)
    }
  }
}
