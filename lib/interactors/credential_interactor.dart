import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/issued_credential.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/share_service.dart';

/// Exports verified achievements as portable credentials.
class CredentialInteractor {
  final ShareService _service;
  final ScoreboardRepository _repository;

  CredentialInteractor(this._service, this._repository);

  /// The achievement signed by its issuer, with its public verification
  /// page; null for peer achievements and where nothing can sign (the mock).
  Future<IssuedCredential?> issued(Achievement achievement) async {
    final id = achievement.id;
    if (achievement.verified != true || id == null) return null;
    return _repository.getCredential(id);
  }

  /// An Open Badges 3.0 `OpenBadgeCredential`, unsigned: the fallback when
  /// no backend can sign it with the issuer's key (see [issued]).
  Map<String, dynamic> openBadge(
      Achievement achievement, UserProfile recipient) {
    final salt = _hex(sha256.convert(utf8.encode('salt:${achievement.id}')))
        .substring(0, 16);
    final emailHash = _hex(sha256
        .convert(utf8.encode(recipient.email.trim().toLowerCase() + salt)));
    return {
      '@context': [
        'https://www.w3.org/ns/credentials/v2',
        'https://purl.imsglobal.org/spec/ob/v3p0/context-3.0.3.json',
      ],
      'id': 'urn:uuid:${_uuid(achievement.id ?? '')}',
      'type': ['VerifiableCredential', 'OpenBadgeCredential'],
      'issuer': {
        'id': 'urn:scoreboard:company:${achievement.companyId}',
        'type': ['Profile'],
        'name': achievement.company,
      },
      'validFrom': achievement.date?.toUtc().toIso8601String(),
      'name': achievement.name,
      'credentialSubject': {
        'type': ['AchievementSubject'],
        // The recipient's email, salted and hashed as the spec allows.
        'identifier': [
          {
            'type': 'IdentityObject',
            'identityType': 'emailAddress',
            'hashed': true,
            'identityHash': 'sha256\$$emailHash',
            'salt': salt,
          }
        ],
        'achievement': {
          'id': 'urn:scoreboard:achievement:${achievement.catalogId}',
          'type': ['Achievement'],
          'achievementType': 'Badge',
          'name': achievement.name,
          'description': achievement.description,
          'criteria': {'narrative': achievement.description},
          'creator': {
            'id': 'urn:scoreboard:company:${achievement.companyId}',
            'type': ['Profile'],
            'name': achievement.company,
          },
        },
      },
    };
  }

  /// Saves the signed credential (a VC-JWT) when the backend issues one,
  /// otherwise the unsigned JSON.
  Future<String?> saveOpenBadge(
      Achievement achievement, UserProfile recipient) async {
    final signed = await issued(achievement);
    if (signed != null) {
      return _service.saveFile(Uint8List.fromList(utf8.encode(signed.jwt)),
          suggestedName: '${_slug(achievement)}.badge.jwt',
          type: ShareFileType.jwt);
    }
    final json = const JsonEncoder.withIndent('  ')
        .convert(openBadge(achievement, recipient));
    return _service.saveFile(Uint8List.fromList(utf8.encode(json)),
        suggestedName: '${_slug(achievement)}.badge.json',
        type: ShareFileType.json);
  }

  Future<String?> saveCertificate(Uint8List pdf, Achievement achievement) =>
      _service.saveFile(pdf,
          suggestedName: '${_slug(achievement)}-certificate.pdf',
          type: ShareFileType.pdf);

  static String _slug(Achievement achievement) =>
      'scoreboard-${(achievement.name ?? 'achievement').toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-|-$'), '')}';

  static String _hex(Digest digest) => digest.toString();

  /// A stable UUID (version 5 layout) derived from [seed].
  static String _uuid(String seed) {
    final bytes =
        sha256.convert(utf8.encode('scoreboard:$seed')).bytes.sublist(0, 16);
    bytes[6] = (bytes[6] & 0x0f) | 0x50;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
