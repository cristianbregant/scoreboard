import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/api/api_client.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/interactors.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/services/rest_scoreboard_repository.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:scoreboard/services/sso_service_io.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/matchers.dart';
import '../helpers/test_app.dart';

const _texts = (done: 'done', failed: 'failed');

/// Plays the browser: once the backend is done, it goes to [back] built
/// from the redirect address and state the service chose.
PlatformSsoService _browser(Map<String, String> Function(String state) back) =>
    PlatformSsoService(openBrowser: (url) async {
      final redirect = Uri.parse(url.queryParameters['redirect_uri']!);
      final state = url.queryParameters['state']!;
      Future(() async {
        final client = HttpClient();
        final request =
            await client.getUrl(redirect.replace(queryParameters: back(state)));
        await (await request.close()).drain<void>();
        client.close();
      });
      return true;
    });

Uri _start(Uri redirectUri, String state) => Uri.https(
    'backend.test',
    '/auth/sso/microsoft/start',
    {'redirect_uri': redirectUri.toString(), 'state': state});

void main() {
  group('desktop browser sign-in', () {
    test('returns the code the backend sends back to the loopback address',
        () async {
      Uri? redirect;
      final sso = PlatformSsoService(openBrowser: (url) async {
        redirect = Uri.parse(url.queryParameters['redirect_uri']!);
        return _browser((state) => {'code': 'one-time', 'state': state})
            .openBrowser(url);
      });
      expect(await sso.authorize(_start, texts: _texts), 'one-time');
      expect(redirect!.host, '127.0.0.1');
      expect(redirect!.path, '/sso');
    });

    test('ignores codes that don\'t carry its state', () async {
      final sso = _browser((_) => {'code': 'stolen', 'state': 'guess'});
      await expectLater(sso.authorize(_start, texts: _texts),
          throwsAuthError(AuthError.ssoFailed));
    });

    test('turns the backend\'s reason into the error to show', () async {
      final sso =
          _browser((state) => {'error': 'ssoNoAccount', 'state': state});
      await expectLater(sso.authorize(_start, texts: _texts),
          throwsAuthError(AuthError.ssoNoAccount));
    });
  });

  test('the backend builds the start address and trades the code', () async {
    SharedPreferences.setMockInitialValues({});
    final preferences = SharedPreference(await SharedPreferences.getInstance());
    final requests = <RequestOptions>[];
    final client = ApiClient(
        baseUrl: 'https://api.example', token: () => preferences.sessionToken)
      ..clientAdapter = _Backend(requests);
    final repository = RestScoreboardRepository(client, preferences);

    final start = repository.ssoStartUrl('google',
        redirectUri: Uri.parse('http://127.0.0.1:5000/sso'), state: 'xyz');
    expect(start.toString(),
        'https://api.example/auth/sso/google/start?redirect_uri=http%3A%2F%2F127.0.0.1%3A5000%2Fsso&state=xyz');

    final user = await repository.completeSso('one-time');
    expect(requests.last.path, '/auth/sso/exchange');
    expect(requests.last.data, {'code': 'one-time'});
    expect(user.id, 'u_me');
    expect(preferences.sessionToken, 'session');
  });

  group('company settings', () {
    setUp(setUpApp);

    test('admins set the tenant and domain, checked before saving', () async {
      final settings = getIt<CompanySettingsInteractor>();
      await expectLater(settings.setSso(tenant: 'not-a-guid', domain: ''),
          throwsAdminError(AdminError.invalidSsoTenant));
      await expectLater(settings.setSso(tenant: '', domain: 'no domain'),
          throwsAdminError(AdminError.invalidSsoDomain));

      await settings.setSso(
          tenant: ' 6F1B2C3D-4E5F-4A6B-8C7D-9E0F1A2B3C4D ',
          domain: 'Northwind.dev');
      var saved = (await settings.currentSettings())!;
      expect(saved.ssoMicrosoftTenant, '6f1b2c3d-4e5f-4a6b-8c7d-9e0f1a2b3c4d');
      expect(saved.ssoGoogleDomain, 'northwind.dev');

      await settings.setSso(tenant: '', domain: 'northwind.dev');
      saved = (await settings.currentSettings())!;
      expect(saved.ssoMicrosoftTenant, isNull);
      expect(saved.ssoGoogleDomain, 'northwind.dev');
    });

    test('without a backend there is nothing to offer', () async {
      expect(await getIt<AuthInteractor>().ssoProviders(), isEmpty);
    });
  });
}

class _Backend implements HttpClientAdapter {
  final List<RequestOptions> requests;

  _Backend(this.requests);

  @override
  Future<ResponseBody> fetch(RequestOptions options, Stream<List<int>>? body,
      Future<void>? cancel) async {
    requests.add(options);
    return ResponseBody.fromString(
        '{"token":"session","user":{"id":"u_me","name":"Mario Rossi",'
        '"role":"Dev","email":"mario.rossi@northwind.dev",'
        '"company_id":"c_northwind","joined_at":"2021-03-15T00:00:00.000"}}',
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType]
        });
  }

  @override
  void close({bool force = false}) {}
}
