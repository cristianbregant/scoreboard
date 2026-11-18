import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/services/sso_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// Desktop: the sign-in happens in the system browser, which comes back to
/// a one-off server on a loopback port (RFC 8252), never seen by others.
class PlatformSsoService implements SsoService {
  /// How long the browser has to come back.
  static const Duration timeout = Duration(minutes: 5);

  /// Opens a URL in the system browser; tests replace it.
  final Future<bool> Function(Uri url) openBrowser;

  PlatformSsoService({Future<bool> Function(Uri url)? openBrowser})
      : openBrowser = openBrowser ??
            ((url) => launchUrl(url, mode: LaunchMode.externalApplication));

  @override
  Future<String> authorize(Uri Function(Uri redirectUri, String state) startUrl,
      {required SsoPageTexts texts}) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final random = Random.secure();
    final state = base64Url
        .encode(List.generate(24, (_) => random.nextInt(256)))
        .replaceAll('=', '');
    final redirect = Uri.parse('http://127.0.0.1:${server.port}/sso');
    try {
      final opened = await openBrowser(startUrl(redirect, state));
      if (!opened) throw const AuthException(AuthError.ssoFailed);

      await for (final request in server.timeout(timeout)) {
        if (request.uri.path != '/sso') {
          request.response.statusCode = HttpStatus.notFound;
          await request.response.close();
          continue;
        }
        final query = request.uri.queryParameters;
        final code = query['code'];
        // Another page can't hand us a code: it doesn't know the state.
        final ok = query['state'] == state && code != null;
        request.response.headers.contentType = ContentType.html;
        request.response.write(_page(ok ? texts.done : texts.failed));
        await request.response.close();
        if (query['state'] != state) {
          throw const AuthException(AuthError.ssoFailed);
        }
        if (code == null) {
          throw AuthException(AuthError.values.asNameMap()[query['error']] ??
              AuthError.ssoFailed);
        }
        return code;
      }
      throw const AuthException(AuthError.ssoCancelled);
    } on TimeoutException {
      throw const AuthException(AuthError.ssoCancelled);
    } finally {
      await server.close(force: true);
    }
  }

  static String _page(String message) => '<!doctype html><html><head>'
      '<meta charset="utf-8"><title>Scoreboard</title></head>'
      '<body style="font:16px/1.5 system-ui,sans-serif;max-width:440px;'
      'margin:20vh auto;padding:0 16px;text-align:center">'
      '<p>${const HtmlEscape().convert(message)}</p></body></html>';
}
