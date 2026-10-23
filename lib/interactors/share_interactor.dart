import 'dart:typed_data';

import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/services/share_service.dart';

/// Sharing achievements on LinkedIn through its public URLs, which need no
/// API key or sign-in from the app.
class ShareInteractor {
  final ShareService _service;

  ShareInteractor(this._service);

  /// Opens the LinkedIn post composer with [text] filled in.
  Uri linkedInPostUri(String text) => Uri.https(
      'www.linkedin.com', '/feed/', {'shareActive': 'true', 'text': text});

  /// LinkedIn's "Add to profile" form for a license or certification.
  /// Only verified achievements qualify, since a company issued them.
  Uri? linkedInCertificationUri(Achievement achievement) {
    final date = achievement.date;
    if (achievement.verified != true || date == null) return null;
    return Uri.https('www.linkedin.com', '/profile/add', {
      'startTask': 'CERTIFICATION_NAME',
      'name': achievement.name ?? '',
      'organizationName': achievement.company ?? '',
      'issueYear': '${date.year}',
      'issueMonth': '${date.month}',
      if (achievement.id != null) 'certId': achievement.id!,
    });
  }

  Future<void> copyText(String text) => _service.copyText(text);

  /// Returns the saved path, or null if the user cancelled.
  Future<String?> saveImage(Uint8List png, Achievement achievement) {
    final slug = (achievement.name ?? 'achievement')
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return _service.saveImage(png, suggestedName: 'scoreboard-$slug.png');
  }
}
