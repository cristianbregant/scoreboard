import 'package:scoreboard/core/constants.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/services/package_info_service.dart';
import 'package:scoreboard/services/shared_preferences.dart';
import 'package:scoreboard/services/update_service.dart';

class UpdateInteractor {
  final UpdateService _service;
  final PackageInfoService _packageInfo;
  final SharedPreference _preferences;

  UpdateInteractor(this._service, this._packageInfo, this._preferences);

  /// The latest release when it's newer than this build, null otherwise.
  /// Throws when GitHub can't be reached.
  Future<ReleaseInfo?> checkForUpdate() async {
    final latest = await _service.latestRelease(Constants.githubRepository);
    if (latest == null || !isNewer(latest.version, _packageInfo.version)) {
      return null;
    }
    return latest;
  }

  /// Like [checkForUpdate], at most once a day and never throwing: meant
  /// for the automatic check at startup.
  Future<ReleaseInfo?> checkDaily() async {
    final last = _preferences.lastUpdateCheck;
    final now = DateTime.now();
    if (last != null && now.difference(last).inHours < 24) return null;
    await _preferences.setLastUpdateCheck(now);
    try {
      return await checkForUpdate();
    } catch (_) {
      return null;
    }
  }

  /// Compares dotted versions numerically: 0.10.0 is newer than 0.9.0.
  static bool isNewer(String candidate, String current) {
    List<int> parts(String version) => version
        .split(RegExp(r'[.+-]'))
        .map((part) => int.tryParse(part) ?? 0)
        .toList();
    final a = parts(candidate);
    final b = parts(current);
    for (var i = 0; i < 3; i++) {
      final x = i < a.length ? a[i] : 0;
      final y = i < b.length ? b[i] : 0;
      if (x != y) return x > y;
    }
    return false;
  }
}
