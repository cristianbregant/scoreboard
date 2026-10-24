import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/api/api_client.dart';
import 'package:scoreboard/api/error/api_error.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/services/rest_scoreboard_repository.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/matchers.dart';

/// Answers every request with [respond] and records what was sent.
class _FakeBackend implements HttpClientAdapter {
  final List<RequestOptions> requests = [];
  (int, Object?) Function(RequestOptions request) respond =
      (_) => (200, const {});

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future<void>? cancelFuture) async {
    requests.add(options);
    final (status, body) = respond(options);
    return ResponseBody.fromString(body == null ? '' : jsonEncode(body), status,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        });
  }

  @override
  void close({bool force = false}) {}
}

Map<String, Object> _error(String type, String code,
        [Map<String, Object>? extra]) =>
    {
      'error': {'type': type, 'code': code, ...?extra}
    };

const _user = {
  'id': 'u_me',
  'name': 'Mario Rossi',
  'role': 'Mobile Developer',
  'email': 'mario.rossi@northwind.dev',
  'company_id': 'c_northwind',
  'joined_at': '2021-03-15T00:00:00.000',
};

void main() {
  late _FakeBackend backend;
  late SharedPreference preferences;
  late RestScoreboardRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = SharedPreference(await SharedPreferences.getInstance());
    backend = _FakeBackend();
    final client = ApiClient(
        baseUrl: 'http://backend.test', token: () => preferences.sessionToken)
      ..clientAdapter = backend;
    repository = RestScoreboardRepository(client, preferences);
  });

  test('signing in keeps the session and sends its token', () async {
    backend.respond = (_) => (200, {'token': 'secret', 'user': _user});
    final user = await repository.signIn('mario.rossi@northwind.dev', 'pw');
    expect(user.id, 'u_me');
    expect(repository.sessionUserId, 'u_me');

    backend.respond = (_) => (200, _user);
    await repository.getCurrentUser();
    expect(backend.requests.last.path, '/me');
    expect(backend.requests.last.headers['Authorization'], 'Bearer secret');
  });

  test('server error codes become the app exceptions', () async {
    backend.respond = (_) => (401, _error('auth', 'wrongCredentials'));
    await expectLater(repository.signIn('a@b.co', 'pw'),
        throwsAuthError(AuthError.wrongCredentials));

    backend.respond = (_) => (400, _error('admin', 'seasonOverlap'));
    await expectLater(repository.deleteSeason('s_1'),
        throwsAdminError(AdminError.seasonOverlap));

    backend.respond = (_) => (
          400,
          _error('send', 'alreadySent',
              {'template_name': 'Team Player', 'colleague_name': 'Luca'})
        );
    await expectLater(
        repository.deleteTemplate('tpl'),
        throwsA(isA<SendAchievementException>()
            .having((e) => e.error, 'error', SendAchievementError.alreadySent)
            .having((e) => e.templateName, 'templateName', 'Team Player')
            .having((e) => e.colleagueName, 'colleagueName', 'Luca')));
  });

  test('unknown errors stay API errors', () async {
    backend.respond = (_) => (500, _error('http', 'internal'));
    await expectLater(repository.getUsers(), throwsA(isA<ApiError>()));
  });

  test('an expired session signs the user out', () async {
    await preferences.setSessionToken('old');
    await preferences.setSessionUserId('u_me');
    backend.respond = (_) => (401, _error('auth', 'notSignedIn'));

    await expectLater(
        repository.getUsers(), throwsAuthError(AuthError.notSignedIn));
    expect(repository.sessionUserId, isNull);
    expect(preferences.sessionToken, isNull);
  });

  test('signing out works even when the server is unreachable', () async {
    await preferences.setSessionToken('token');
    await preferences.setSessionUserId('u_me');
    backend.respond = (_) => (503, null);

    await expectLater(repository.signOut(), throwsA(isA<ApiError>()));
    expect(repository.sessionUserId, isNull);
  });

  test('sends reactions and notification changes in the server format',
      () async {
    await repository.setReaction('ach_1', 'u_me', ReactionType.celebrate);
    expect(backend.requests.last.method, 'PUT');
    expect(backend.requests.last.path, '/achievements/ach_1/reaction');
    expect(backend.requests.last.data, {'type': 'celebrate'});

    await repository.setReaction('ach_1', 'u_me', null);
    expect(backend.requests.last.data, {'type': null});
  });
}
