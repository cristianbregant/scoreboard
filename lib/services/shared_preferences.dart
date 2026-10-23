import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String _darkThemeKey = 'dark_theme';
  static const String _languageCodeKey = 'language_code';
  static const String _sessionUserIdKey = 'session_user_id';
  static const String _storedUsersKey = 'stored_users';
  static const String _credentialsKey = 'credentials';
  static const String _customTemplatesKey = 'custom_templates';
  static const String _sentAchievementsKey = 'sent_achievements';

  final SharedPreferences _preferences;

  SharedPreference(this._preferences);

  bool? get darkTheme => _preferences.getBool(_darkThemeKey);
  Future<void> setDarkTheme(bool value) =>
      _preferences.setBool(_darkThemeKey, value);

  /// Chosen language, null to follow the system.
  String? get languageCode => _preferences.getString(_languageCodeKey);
  Future<void> setLanguageCode(String? value) => value == null
      ? _preferences.remove(_languageCodeKey)
      : _preferences.setString(_languageCodeKey, value);

  /// Whether [userId] has seen the introduction on this device.
  bool onboardingDone(String userId) =>
      _preferences.getBool('onboarding_done_$userId') ?? false;
  Future<void> setOnboardingDone(String userId) =>
      _preferences.setBool('onboarding_done_$userId', true);

  /// Last automatic update check, to run it at most once a day.
  DateTime? get lastUpdateCheck {
    final millis = _preferences.getInt('last_update_check');
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  Future<void> setLastUpdateCheck(DateTime value) =>
      _preferences.setInt('last_update_check', value.millisecondsSinceEpoch);

  /// Id of the signed-in user, null when signed out.
  String? get sessionUserId => _preferences.getString(_sessionUserIdKey);
  Future<void> setSessionUserId(String? value) => value == null
      ? _preferences.remove(_sessionUserIdKey)
      : _preferences.setString(_sessionUserIdKey, value);

  /// JSON-encoded profiles that were registered or edited in the app.
  List<String> get storedUsers =>
      _preferences.getStringList(_storedUsersKey) ?? [];
  Future<void> setStoredUsers(List<String> value) =>
      _preferences.setStringList(_storedUsersKey, value);

  /// JSON-encoded map of credentials by email.
  String? get credentials => _preferences.getString(_credentialsKey);
  Future<void> setCredentials(String value) =>
      _preferences.setString(_credentialsKey, value);

  /// JSON-encoded records of a collection (catalog, requests, feed,
  /// notifications), null until the collection is first saved.
  List<String>? getRecords(String collection) =>
      _preferences.getStringList('records_$collection');
  Future<void> setRecords(String collection, List<String> value) =>
      _preferences.setStringList('records_$collection', value);

  /// JSON-encoded base achievements created in the app.
  List<String> get customTemplates =>
      _preferences.getStringList(_customTemplatesKey) ?? [];
  Future<void> setCustomTemplates(List<String> value) =>
      _preferences.setStringList(_customTemplatesKey, value);

  /// JSON-encoded achievements sent to colleagues from the app.
  List<String> get sentAchievements =>
      _preferences.getStringList(_sentAchievementsKey) ?? [];
  Future<void> setSentAchievements(List<String> value) =>
      _preferences.setStringList(_sentAchievementsKey, value);
}
