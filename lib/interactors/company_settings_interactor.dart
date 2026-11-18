import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/image_storage_service.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// The company's look in the app and its work anniversaries. Everyone reads
/// them (the app takes the company's colors); only admins change them.
class CompanySettingsInteractor {
  /// Accents admins can pick: each stays readable in both themes once the
  /// app adjusts it (see `AppTheme.branded`).
  static const List<int> accentPresets = [
    0xFF0EA5E9, // sky
    0xFF2563EB, // blue
    0xFF7C3AED, // violet
    0xFFDB2777, // pink
    0xFFDC2626, // red
    0xFFEA580C, // orange
    0xFF16A34A, // green
    0xFF0D9488, // teal
  ];

  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ImageStorageService _imageStorage;
  final ActivityInteractor _activity;

  CompanySettingsInteractor(
      this._repository, this._scoreboard, this._imageStorage, this._activity);

  /// The current user's company settings; defaults when signed out.
  Future<CompanySettings?> currentSettings() async {
    if (_repository.sessionUserId == null) return null;
    final user = await _scoreboard.getCurrentUser();
    return _repository.getCompanySettings(user.companyId);
  }

  /// Null goes back to Scoreboard's gold.
  Future<void> setAccent(int? color) async {
    final settings = await _adminSettings();
    await _repository.saveCompanySettings(color == null
        ? settings.copyWith(clearAccent: true)
        : settings.copyWith(accentColor: color));
    await _activity.log(ActivityType.brandUpdated);
    _scoreboard.dataChanged();
  }

  /// Copies the picked image into the app's storage; null removes the logo.
  Future<void> setLogo(String? sourcePath) async {
    final settings = await _adminSettings();
    await _imageStorage.delete(settings.logoPath);
    final stored = sourcePath == null
        ? null
        : await _imageStorage.store(sourcePath,
            name: '${settings.companyId}_logo');
    await _repository.saveCompanySettings(stored == null
        ? settings.copyWith(clearLogo: true)
        : settings.copyWith(logoPath: stored));
    await _activity.log(ActivityType.brandUpdated);
    _scoreboard.dataChanged();
  }

  Future<String?> pickLogo() => _scoreboard.pickImage();

  /// [years] must come from [CompanySettings.availableAnniversaryYears].
  Future<void> setAnniversaries(
      {required bool enabled, required List<int> years}) async {
    final settings = await _adminSettings();
    final valid = years
        .where(CompanySettings.availableAnniversaryYears.contains)
        .toSet()
        .toList()
      ..sort();
    if (enabled && valid.isEmpty) {
      throw const AdminException(AdminError.missingFields);
    }
    await _repository.saveCompanySettings(settings.copyWith(
        anniversariesEnabled: enabled, anniversaryYears: valid));
    await _activity.log(ActivityType.anniversariesUpdated);
    _scoreboard.dataChanged();
  }

  /// The privacy switches; see [CompanySettings.individualRankings] and
  /// [CompanySettings.recognitionGaps].
  Future<void> setPrivacy(
      {bool? individualRankings, bool? recognitionGaps}) async {
    final settings = await _adminSettings();
    await _repository.saveCompanySettings(settings.copyWith(
        individualRankings: individualRankings,
        recognitionGaps: recognitionGaps));
    await _activity.log(ActivityType.privacyUpdated);
    _scoreboard.dataChanged();
  }

  /// Single sign-on: which Entra tenant and Workspace domain may sign in to
  /// the company. Empty values turn a provider off. Throws
  /// [AdminError.invalidSsoTenant] or [AdminError.invalidSsoDomain] for
  /// values that can't be right, before asking the backend.
  Future<void> setSso({required String tenant, required String domain}) async {
    final settings = await _adminSettings();
    final t = tenant.trim().toLowerCase();
    final d = domain.trim().toLowerCase();
    if (t.isNotEmpty && !_tenant.hasMatch(t)) {
      throw const AdminException(AdminError.invalidSsoTenant);
    }
    if (d.isNotEmpty && !_domain.hasMatch(d)) {
      throw const AdminException(AdminError.invalidSsoDomain);
    }
    await _repository.saveCompanySettings(settings.copyWith(
        ssoMicrosoftTenant: t.isEmpty ? null : t,
        clearSsoMicrosoftTenant: t.isEmpty,
        ssoGoogleDomain: d.isEmpty ? null : d,
        clearSsoGoogleDomain: d.isEmpty));
    await _activity.log(ActivityType.ssoUpdated);
    _scoreboard.dataChanged();
  }

  static final _tenant =
      RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$');
  static final _domain =
      RegExp(r'^([a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,}$');

  Future<CompanySettings> _adminSettings() async {
    final UserProfile user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return _repository.getCompanySettings(user.companyId);
  }
}
