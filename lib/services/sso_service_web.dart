import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math';

import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/services/sso_service.dart';
import 'package:url_launcher/url_launcher.dart';

@JS('sessionStorage.getItem')
external String? _getItem(String key);

@JS('sessionStorage.setItem')
external void _setItem(String key, String value);

@JS('sessionStorage.removeItem')
external void _removeItem(String key);

@JS('history.replaceState')
external void _replaceState(JSAny? data, String title, String url);

const _stateKey = 'scoreboard.sso_state';

/// Web: the whole page goes to the provider and comes back to the app's
/// address with the backend's one-time code, which [consumeRedirect] reads
/// at startup.
class PlatformSsoService implements SsoService {
  @override
  Future<String> authorize(Uri Function(Uri redirectUri, String state) startUrl,
      {required SsoPageTexts texts}) async {
    final random = Random.secure();
    final state = base64Url
        .encode(List.generate(24, (_) => random.nextInt(256)))
        .replaceAll('=', '');
    _setItem(_stateKey, state);
    final here = Uri.base.replace(query: '', fragment: '');
    final redirect = Uri.parse(here.toString().replaceAll(RegExp(r'\?$'), ''));
    if (!await launchUrl(startUrl(redirect, state),
        webOnlyWindowName: '_self')) {
      throw const AuthException(AuthError.ssoFailed);
    }
    // The page is leaving: the sign-in finishes when it comes back.
    return Completer<String>().future;
  }
}

/// The outcome of a sign-in the page just came back from, read once: the
/// code, or the reason it failed. Null when the page wasn't opened by one.
({String? code, AuthError? error})? consumeRedirect() {
  final query = Uri.base.queryParameters;
  final state = query['state'];
  if (state == null ||
      (!query.containsKey('code') && !query.containsKey('error'))) {
    return null;
  }
  final expected = _getItem(_stateKey);
  _removeItem(_stateKey);
  // Drop the code from the address bar and the history.
  _replaceState(null, '',
      Uri.base.replace(query: '').toString().replaceAll(RegExp(r'\?$'), ''));
  // Another page can't hand us a code: it doesn't know the state.
  if (expected == null || expected != state) {
    return (code: null, error: AuthError.ssoFailed);
  }
  final code = query['code'];
  if (code != null) return (code: code, error: null);
  return (
    code: null,
    error: AuthError.values.asNameMap()[query['error']] ?? AuthError.ssoFailed
  );
}
