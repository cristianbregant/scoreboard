import 'package:flutter_test/flutter_test.dart';
import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/interactors/credential_interactor.dart';
import 'package:scoreboard/interactors/share_interactor.dart';
import 'package:scoreboard/interactors/update_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/test_app.dart';

final _verified = Achievement(
  id: 'ach_u_me_7',
  name: 'Cloud Computing Expert',
  description: 'Designed and ran cloud infrastructure.',
  company: 'Northwind Labs',
  companyId: 'c_northwind',
  catalogId: 'cat_c_northwind_7',
  points: 140,
  verified: true,
  date: DateTime(2026, 8, 22),
);

final _recipient = UserProfile(
    id: demoUserId,
    name: 'Mario Rossi',
    role: 'Mobile Developer',
    email: demoEmail,
    companyId: 'c_northwind',
    joinedAt: DateTime(2021));

void main() {
  setUp(setUpApp);

  group('Open Badge', () {
    late Map<String, dynamic> badge;

    setUp(() =>
        badge = getIt<CredentialInteractor>().openBadge(_verified, _recipient));

    test('is an Open Badges 3.0 credential', () {
      expect(badge['type'], ['VerifiableCredential', 'OpenBadgeCredential']);
      expect(badge['@context'], hasLength(2));
      expect(badge['name'], 'Cloud Computing Expert');
      expect(badge['issuer']['name'], 'Northwind Labs');
      expect(badge['validFrom'], startsWith('2026-08-2'));
      expect(badge['credentialSubject']['achievement']['id'],
          'urn:scoreboard:achievement:cat_c_northwind_7');
    });

    test('has a stable UUID id', () {
      final id = badge['id'] as String;
      expect(
          id,
          matches(RegExp(
              r'^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')));
      expect(
          getIt<CredentialInteractor>().openBadge(_verified, _recipient)['id'],
          id);
    });

    test('hashes the email instead of exposing it', () {
      final identity = badge['credentialSubject']['identifier'].single as Map;
      expect(identity['hashed'], isTrue);
      expect(
          identity['identityHash'], matches(RegExp(r'^sha256\$[0-9a-f]{64}$')));
      expect(badge.toString(), isNot(contains(demoEmail)));
    });
  });

  group('LinkedIn', () {
    late ShareInteractor share;

    setUp(() => share = getIt<ShareInteractor>());

    test('the post link carries the text', () {
      final uri = share.linkedInPostUri('I earned a badge! #scoreboard');
      expect(uri.host, 'www.linkedin.com');
      expect(uri.queryParameters['text'], 'I earned a badge! #scoreboard');
    });

    test('only verified achievements can become certifications', () {
      final uri = share.linkedInCertificationUri(_verified)!;
      expect(uri.path, '/profile/add');
      expect(
          uri.queryParameters, containsPair('name', 'Cloud Computing Expert'));
      expect(uri.queryParameters,
          containsPair('organizationName', 'Northwind Labs'));
      expect(uri.queryParameters, containsPair('issueYear', '2026'));
      expect(uri.queryParameters, containsPair('issueMonth', '8'));

      expect(
          share.linkedInCertificationUri(Achievement(
              name: 'Great Idea', verified: false, date: DateTime(2026))),
          isNull);
    });
  });

  group('updates', () {
    test('versions compare numerically', () {
      expect(UpdateInteractor.isNewer('0.10.0', '0.9.0'), isTrue);
      expect(UpdateInteractor.isNewer('1.0.1', '1.0.0'), isTrue);
      expect(UpdateInteractor.isNewer('1.0', '1.0.0'), isFalse);
      expect(UpdateInteractor.isNewer('1.0.0+5', '1.0.0+1'), isFalse);
      expect(UpdateInteractor.isNewer('0.9.9', '1.0.0'), isFalse);
    });

    test('offers only newer releases', () async {
      final updates = getIt<UpdateInteractor>();
      updateService.release =
          ReleaseInfo(version: '1.0.0', url: Uri.parse('https://x.dev'));
      expect(await updates.checkForUpdate(), isNull);
      updateService.release =
          ReleaseInfo(version: '1.2.0', url: Uri.parse('https://x.dev'));
      expect((await updates.checkForUpdate())?.version, '1.2.0');
    });

    test('the daily check runs once a day and never throws', () async {
      final updates = getIt<UpdateInteractor>();
      updateService.error = Exception('offline');
      expect(await updates.checkDaily(), isNull);
      expect(updateService.calls, 1);

      updateService
        ..error = null
        ..release =
            ReleaseInfo(version: '2.0.0', url: Uri.parse('https://x.dev'));
      expect(await updates.checkDaily(), isNull);
      expect(updateService.calls, 1);

      // A day later it asks again.
      final preferences = await SharedPreferences.getInstance();
      await preferences.setInt(
          'last_update_check',
          DateTime.now()
              .subtract(const Duration(hours: 25))
              .millisecondsSinceEpoch);
      expect((await updates.checkDaily())?.version, '2.0.0');
      expect(updateService.calls, 2);
    });
  });
}
