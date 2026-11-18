import 'package:scoreboard/services/sso_service_io.dart'
    if (dart.library.js_interop) 'package:scoreboard/services/sso_service_web.dart'
    as platform;

/// Texts of the page the browser shows when it hands the sign-in back.
typedef SsoPageTexts = ({String done, String failed});

/// The browser part of single sign-on: opens the provider's page and waits
/// for the backend to send back a one-time code.
abstract class SsoService {
  factory SsoService() = platform.PlatformSsoService;

  /// Opens [startUrl] (built for the redirect address and state this
  /// service picks) and returns the code the backend sends back. Throws an
  /// `AuthException` when the sign-in fails or is abandoned.
  Future<String> authorize(Uri Function(Uri redirectUri, String state) startUrl,
      {required SsoPageTexts texts});
}
