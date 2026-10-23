import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/model/player_level.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/shared_preferences.dart';

/// Local stand-in for the backend. Data the user creates (accounts,
/// profiles, base achievements, sent achievements) is persisted in
/// [SharedPreference]; the seed data is rebuilt at every start.
class MockScoreboardRepository implements ScoreboardRepository {
  /// Seed account that can sign in, shown on the sign-in screen.
  static const String demoUserId = 'u_me';
  static const String demoEmail = 'mario.rossi@northwind.dev';
  static const String demoPassword = 'scoreboard';

  static const Duration _latency = Duration(milliseconds: 300);

  final SharedPreference _preferences;

  late final List<Company> _companies = _buildCompanies();
  late List<UserProfile> _users = _buildUsers();
  late final int _seedUserCount = _buildSeedUsers().length;
  late final Map<String, _Credential> _credentials = _loadCredentials();
  late final List<AchievementTemplate> _seedTemplates = _buildBaseTemplates();
  late final List<AchievementTemplate> _baseTemplates = [
    ..._seedTemplates,
    ..._preferences.customTemplates
        .map((json) => AchievementTemplate.fromJson(jsonDecode(json))),
  ];
  late final List<Achievement> _achievements = [
    ..._buildAchievements(),
    ..._preferences.sentAchievements
        .map((json) => Achievement.fromJson(jsonDecode(json))),
  ];

  /// Only what was created in the app is persisted; seed data is rebuilt.
  final Set<String> _seedAchievementIds = {};

  late final List<CatalogAchievement> _catalog =
      _load('catalog', CatalogAchievement.fromJson, _buildCatalog);
  late final List<VerificationRequest> _requests =
      _load('requests', VerificationRequest.fromJson, _buildRequests);
  late final List<FeedReaction> _reactions =
      _load('reactions', FeedReaction.fromJson, _buildReactions);
  late final List<FeedComment> _comments =
      _load('comments', FeedComment.fromJson, _buildComments);
  late final List<AppNotification> _notifications =
      _load('notifications', AppNotification.fromJson, _buildNotifications);

  /// Users whose profile differs from the seed and must be persisted.
  late final Set<String> _storedUserIds = _preferences.storedUsers
      .map((json) => jsonDecode(json)['id'] as String)
      .toSet();

  MockScoreboardRepository(this._preferences);

  @override
  String? get sessionUserId => _preferences.sessionUserId;

  @override
  Future<UserProfile> getCurrentUser() async {
    await Future.delayed(_latency);
    return _currentUser();
  }

  UserProfile _currentUser() {
    final user = _users.where((user) => user.id == sessionUserId).firstOrNull;
    if (user == null) throw const AuthException(AuthError.notSignedIn);
    return user;
  }

  @override
  Future<UserProfile> signIn(String email, String password) async {
    await Future.delayed(_latency);
    final credential = _credentials[_normalize(email)];
    if (credential == null ||
        credential.hash != _hash(password, credential.salt)) {
      throw const AuthException(AuthError.wrongCredentials);
    }
    await _preferences.setSessionUserId(credential.userId);
    return _currentUser();
  }

  @override
  Future<UserProfile> register(RegistrationDraft draft) async {
    await Future.delayed(_latency);
    final email = _normalize(draft.email);
    if (_isEmailTaken(email)) {
      throw const AuthException(AuthError.emailTaken);
    }
    final user = UserProfile(
      id: 'u_${DateTime.now().microsecondsSinceEpoch}',
      name: draft.name.trim(),
      role: draft.role.trim(),
      email: email,
      companyId: draft.companyId,
      joinedAt: DateTime.now(),
    );
    _users = [..._users, user];
    _storedUserIds.add(user.id);
    _credentials[email] = _Credential.create(user.id, draft.password);
    await _persistUsers();
    await _persistCredentials();
    await _preferences.setSessionUserId(user.id);
    return user;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(_latency);
    await _preferences.setSessionUserId(null);
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    await Future.delayed(_latency);
    final user = _currentUser();
    final email = _normalize(user.email);
    final credential = _credentials[email];
    if (credential == null ||
        credential.hash != _hash(currentPassword, credential.salt)) {
      throw const AuthException(AuthError.wrongCurrentPassword);
    }
    _credentials[email] = _Credential.create(user.id, newPassword);
    await _persistCredentials();
  }

  @override
  Future<UserProfile> saveCurrentUser(UserProfile profile) async {
    await Future.delayed(_latency);
    final current = _currentUser();
    final oldEmail = _normalize(current.email);
    final newEmail = _normalize(profile.email);
    if (newEmail != oldEmail) {
      if (_isEmailTaken(newEmail)) {
        throw const AuthException(AuthError.emailTaken);
      }
      final credential = _credentials.remove(oldEmail);
      if (credential != null) _credentials[newEmail] = credential;
      await _persistCredentials();
    }

    final saved = profile.copyWith(email: newEmail);
    _users = [for (final user in _users) user.id == current.id ? saved : user];
    _storedUserIds.add(current.id);
    await _persistUsers();
    return saved;
  }

  bool _isEmailTaken(String email) =>
      _credentials.containsKey(email) ||
      _users.any((user) => _normalize(user.email) == email);

  static String _normalize(String email) => email.trim().toLowerCase();

  static String _hash(String password, String salt) =>
      sha256.convert(utf8.encode('$salt:$password')).toString();

  Map<String, _Credential> _loadCredentials() {
    final stored = _preferences.credentials;
    final credentials = <String, _Credential>{
      if (stored != null)
        for (final entry in (jsonDecode(stored) as Map).entries)
          entry.key as String: _Credential.fromJson(entry.value),
    };
    // The demo account can always sign in, with its current email.
    if (!credentials.values.any((c) => c.userId == demoUserId)) {
      final demo = _users.firstWhere((u) => u.id == demoUserId);
      credentials[_normalize(demo.email)] =
          _Credential.create(demoUserId, demoPassword);
    }
    return credentials;
  }

  Future<void> _persistCredentials() => _preferences.setCredentials(
      jsonEncode(_credentials.map((k, v) => MapEntry(k, v.toJson()))));

  Future<void> _persistUsers() => _preferences.setStoredUsers(_users
      .where((user) => _storedUserIds.contains(user.id))
      .map((user) => jsonEncode(user.toJson()))
      .toList());

  @override
  Future<List<UserProfile>> getUsers() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_users);
  }

  @override
  Future<List<Company>> getCompanies() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_companies);
  }

  @override
  Future<List<Achievement>> getAchievements() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_achievements);
  }

  @override
  Future<void> addAchievement(Achievement achievement,
      {bool notifyRecipient = true}) async {
    await Future.delayed(_latency);
    final recipientId = achievement.userId!;
    final levelBefore = PlayerLevel(_pointsOf(recipientId)).level;
    _achievements.add(achievement);
    await _preferences.setSentAchievements(_achievements
        .where((a) => !_seedAchievementIds.contains(a.id))
        .map((a) => jsonEncode(a.toJson()))
        .toList());

    if (notifyRecipient) {
      final verified = achievement.verified == true;
      _notify(
          recipientId,
          verified
              ? NotificationType.verifiedAchievementReceived
              : NotificationType.peerAchievementReceived,
          actorName: verified ? achievement.company : achievement.awardedByName,
          achievementId: achievement.id,
          achievementName: achievement.name);
    }
    final levelAfter = PlayerLevel(_pointsOf(recipientId)).level;
    if (levelAfter > levelBefore) {
      _notify(recipientId, NotificationType.levelUp, number: levelAfter);
    }
    await _persistNotifications();
  }

  int _pointsOf(String userId) => _achievements
      .where((a) => a.userId == userId)
      .fold(0, (sum, a) => sum + (a.points ?? 0));

  @override
  Future<List<AchievementTemplate>> getTemplates() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_baseTemplates);
  }

  @override
  Future<void> addTemplate(AchievementTemplate template) async {
    await Future.delayed(_latency);
    _baseTemplates.add(template);
    await _persistTemplates();
  }

  @override
  Future<void> deleteTemplate(String templateId) async {
    await Future.delayed(_latency);
    _baseTemplates.removeWhere((t) => t.id == templateId);
    await _persistTemplates();
  }

  Future<void> _persistTemplates() =>
      _preferences.setCustomTemplates(_baseTemplates
          .where((t) => !_seedTemplates.contains(t))
          .map((t) => jsonEncode(t.toJson()))
          .toList());

  @override
  Future<List<CatalogAchievement>> getCatalog(String companyId) async {
    await Future.delayed(_latency);
    return _catalog.where((item) => item.companyId == companyId).toList();
  }

  @override
  Future<void> saveCatalogAchievement(CatalogAchievement achievement) async {
    await Future.delayed(_latency);
    _upsert(_catalog, achievement, (item) => item.id == achievement.id);
    await _save('catalog', _catalog, (item) => item.toJson());
  }

  @override
  Future<List<VerificationRequest>> getRequests(String companyId) async {
    await Future.delayed(_latency);
    return _requests.where((r) => r.companyId == companyId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> saveRequest(VerificationRequest request) async {
    await Future.delayed(_latency);
    final isNew = !_requests.any((r) => r.id == request.id);
    _upsert(_requests, request, (r) => r.id == request.id);
    await _save('requests', _requests, (r) => r.toJson());

    final catalogName =
        _catalog.where((c) => c.id == request.catalogId).firstOrNull?.name;
    if (isNew) {
      for (final admin in _users.where((u) =>
          u.isCompanyAdmin &&
          u.companyId == request.companyId &&
          u.id != request.userId)) {
        _notify(admin.id, NotificationType.newRequest,
            actorName: _userName(request.userId), achievementName: catalogName);
      }
    } else if (request.status != RequestStatus.pending) {
      _notify(
          request.userId,
          request.status == RequestStatus.approved
              ? NotificationType.requestApproved
              : NotificationType.requestRejected,
          actorName: _userName(request.decidedById),
          achievementName: catalogName,
          text: request.rejectionReason);
    }
    await _persistNotifications();
  }

  @override
  Future<List<FeedReaction>> getReactions() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_reactions);
  }

  @override
  Future<void> setReaction(
      String achievementId, String userId, ReactionType? type) async {
    await Future.delayed(_latency);
    _reactions.removeWhere(
        (r) => r.achievementId == achievementId && r.userId == userId);
    if (type != null) {
      _reactions.add(FeedReaction(
          achievementId: achievementId, userId: userId, type: type));
      _notifyOwner(achievementId, userId, NotificationType.feedReaction);
      await _persistNotifications();
    }
    await _save('reactions', _reactions, (r) => r.toJson());
  }

  @override
  Future<List<FeedComment>> getComments() async {
    await Future.delayed(_latency);
    return List.unmodifiable(_comments);
  }

  @override
  Future<void> addComment(FeedComment comment) async {
    await Future.delayed(_latency);
    _comments.add(comment);
    await _save('comments', _comments, (c) => c.toJson());
    _notifyOwner(
        comment.achievementId, comment.userId, NotificationType.feedComment,
        text: comment.text);
    await _persistNotifications();
  }

  @override
  Future<List<AppNotification>> getNotifications(String userId) async {
    await Future.delayed(_latency);
    _addWeeklyRecapIfDue(userId);
    return _notifications.where((n) => n.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> updateNotifications(List<AppNotification> notifications) async {
    await Future.delayed(_latency);
    for (final notification in notifications) {
      _upsert(_notifications, notification, (n) => n.id == notification.id);
    }
    await _persistNotifications();
  }

  /// Plays the role of a weekly server job: at most one recap every 7 days.
  void _addWeeklyRecapIfDue(String userId) {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    final hasRecent = _notifications.any((n) =>
        n.userId == userId &&
        n.type == NotificationType.weeklyRecap &&
        n.createdAt.isAfter(weekAgo));
    if (hasRecent) return;

    final weekPoints = _achievements
        .where((a) =>
            a.userId == userId && a.date != null && a.date!.isAfter(weekAgo))
        .fold(0, (sum, a) => sum + (a.points ?? 0));
    // A recap of an empty week would only be noise.
    if (weekPoints == 0) return;
    final ranking = _users.map((u) => u.id).toList()
      ..sort((a, b) => _pointsOf(b).compareTo(_pointsOf(a)));
    _notify(userId, NotificationType.weeklyRecap,
        number: weekPoints, secondNumber: ranking.indexOf(userId) + 1);
    _persistNotifications();
  }

  void _notifyOwner(String achievementId, String actorId, NotificationType type,
      {String? text}) {
    final achievement =
        _achievements.where((a) => a.id == achievementId).firstOrNull;
    if (achievement == null || achievement.userId == actorId) return;
    _notify(achievement.userId!, type,
        actorName: _userName(actorId),
        achievementId: achievementId,
        achievementName: achievement.name,
        text: text);
  }

  void _notify(String userId, NotificationType type,
      {String? actorName,
      String? achievementId,
      String? achievementName,
      int? number,
      int? secondNumber,
      String? text}) {
    _notifications.add(AppNotification(
      id: 'n_${DateTime.now().microsecondsSinceEpoch}_${_notifications.length}',
      userId: userId,
      type: type,
      createdAt: DateTime.now(),
      actorName: actorName,
      achievementId: achievementId,
      achievementName: achievementName,
      number: number,
      secondNumber: secondNumber,
      text: text,
    ));
  }

  String? _userName(String? userId) =>
      _users.where((u) => u.id == userId).firstOrNull?.name;

  Future<void> _persistNotifications() =>
      _save('notifications', _notifications, (n) => n.toJson());

  /// Stored records of a collection, or its seed until it's first saved.
  List<T> _load<T>(String collection, T Function(Map<String, dynamic>) fromJson,
      List<T> Function() seed) {
    final stored = _preferences.getRecords(collection);
    if (stored == null) return seed();
    return stored.map((json) => fromJson(jsonDecode(json))).toList();
  }

  Future<void> _save<T>(String collection, List<T> records,
          Map<String, dynamic> Function(T) toJson) =>
      _preferences.setRecords(
          collection, records.map((r) => jsonEncode(toJson(r))).toList());

  static void _upsert<T>(List<T> list, T item, bool Function(T) matches) {
    final index = list.indexWhere(matches);
    index == -1 ? list.add(item) : list[index] = item;
  }

  List<CatalogAchievement> _buildCatalog() => [
        for (final company in _companies)
          for (var j = 0; j < _templates.length; j++)
            CatalogAchievement(
              id: 'cat_${company.id}_$j',
              companyId: company.id,
              name: _templates[j].$1,
              description: _templates[j].$2,
              icon: _templates[j].$3,
              points: _templates[j].$4,
              createdAt: DateTime(2024, 1, 10),
            ),
      ];

  List<VerificationRequest> _buildRequests() {
    final now = DateTime.now();
    return [
      VerificationRequest(
        id: 'req_seed_1',
        userId: 'u_02',
        companyId: 'c_northwind',
        catalogId: 'cat_c_northwind_3',
        message: 'I maintain two libraries we use in production.',
        evidenceUrl: 'https://github.com/northwind-labs',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      VerificationRequest(
        id: 'req_seed_2',
        userId: 'u_03',
        companyId: 'c_northwind',
        catalogId: 'cat_c_northwind_1',
        message: 'Found and fixed the payment rounding bug before release.',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      VerificationRequest(
        id: 'req_seed_3',
        userId: 'u_01',
        companyId: 'c_northwind',
        catalogId: 'cat_c_northwind_4',
        message: 'Built the analytics dashboard for Q3.',
        status: RequestStatus.approved,
        createdAt: now.subtract(const Duration(days: 9)),
        decidedAt: now.subtract(const Duration(days: 8)),
        decidedById: demoUserId,
      ),
    ];
  }

  /// Colleagues react to a deterministic subset of each other's
  /// achievements so the feed starts with some activity.
  List<FeedReaction> _buildReactions() {
    final reactions = <FeedReaction>[];
    for (final achievement in _buildAchievementsSnapshot()) {
      final colleagues = _users
          .where((u) =>
              u.companyId == achievement.companyId &&
              u.id != achievement.userId)
          .toList();
      for (var i = 0; i < colleagues.length; i++) {
        final seed = achievement.id.hashCode.abs() + i;
        if (seed % 3 == 0) continue;
        reactions.add(FeedReaction(
          achievementId: achievement.id!,
          userId: colleagues[i].id,
          type: ReactionType.values[seed % ReactionType.values.length],
        ));
      }
    }
    return reactions;
  }

  List<FeedComment> _buildComments() {
    final now = DateTime.now();
    FeedComment comment(String id, String achievementId, String userId,
            String text, Duration ago) =>
        FeedComment(
            id: id,
            achievementId: achievementId,
            userId: userId,
            text: text,
            createdAt: now.subtract(ago));
    return [
      comment('c_seed_1', 'ach_u_me_7', 'u_02',
          'Congrats Mario, well deserved!', const Duration(days: 1)),
      comment(
          'c_seed_2',
          'ach_u_me_7',
          'u_01',
          'The migration went smoothly thanks to you.',
          const Duration(hours: 20)),
      comment('c_seed_3', 'ach_u_me_p8', 'u_03', 'Loved that idea 💡',
          const Duration(days: 2)),
    ];
  }

  List<AppNotification> _buildNotifications() {
    final now = DateTime.now();
    AppNotification seed(String id, NotificationType type, Duration ago,
            {bool read = false,
            String? actor,
            String? achievementId,
            String? achievementName,
            int? number,
            String? text}) =>
        AppNotification(
          id: id,
          userId: demoUserId,
          type: type,
          createdAt: now.subtract(ago),
          read: read,
          // Seed notifications never pop up as system notifications.
          delivered: true,
          actorName: actor,
          achievementId: achievementId,
          achievementName: achievementName,
          number: number,
          text: text,
        );
    return [
      seed('n_seed_1', NotificationType.newRequest, const Duration(hours: 3),
          actor: 'Luca Ferrari', achievementName: 'Open Source Contributor'),
      seed('n_seed_2', NotificationType.feedComment, const Duration(hours: 20),
          actor: 'Giulia Bianchi',
          achievementId: 'ach_u_me_7',
          achievementName: 'Cloud Computing Expert',
          text: 'The migration went smoothly thanks to you.'),
      seed('n_seed_3', NotificationType.peerAchievementReceived,
          const Duration(days: 2),
          actor: 'Giulia Bianchi',
          achievementId: 'ach_u_me_p8',
          achievementName: 'Great Idea'),
      seed('n_seed_4', NotificationType.verifiedAchievementReceived,
          const Duration(days: 5),
          read: true,
          actor: 'Northwind Labs',
          achievementId: 'ach_u_me_6',
          achievementName: 'Cybersecurity Defender'),
      seed('n_seed_5', NotificationType.levelUp, const Duration(days: 5),
          read: true, number: 4),
    ];
  }

  /// Seed achievements, for seeding other collections before
  /// [_achievements] is first read.
  List<Achievement> _buildAchievementsSnapshot() =>
      _achievements.where((a) => _seedAchievementIds.contains(a.id)).toList();

  List<Company> _buildCompanies() => const [
        Company(
            id: 'c_northwind',
            name: 'Northwind Labs',
            description:
                'Product studio building developer tools and internal platforms.',
            industry: 'Software',
            location: 'Trieste, IT',
            foundedYear: 2014,
            brand: CompanyBrand(symbol: 'air', color: 0xFF0EA5E9)),
        Company(
            id: 'c_bluepeak',
            name: 'Bluepeak Software',
            description: 'Cloud-native consultancy focused on fintech.',
            industry: 'Consulting',
            location: 'Milano, IT',
            foundedYear: 2011,
            brand: CompanyBrand(symbol: 'terrain', color: 0xFF2563EB)),
        Company(
            id: 'c_orbit',
            name: 'Orbit Systems',
            description: 'Embedded and IoT solutions for manufacturing.',
            industry: 'Hardware',
            location: 'Torino, IT',
            foundedYear: 2008,
            brand: CompanyBrand(symbol: 'orbit', color: 0xFFF97316)),
        Company(
            id: 'c_lumen',
            name: 'Lumen Digital',
            description: 'Design-led agency for web and mobile products.',
            industry: 'Agency',
            location: 'Bologna, IT',
            foundedYear: 2017,
            brand: CompanyBrand(symbol: 'lumen', color: 0xFFEAB308)),
      ];

  /// Seed users, with the stored edits applied, followed by the users
  /// registered in the app.
  List<UserProfile> _buildUsers() {
    final stored = {
      for (final json in _preferences.storedUsers)
        (jsonDecode(json)['id'] as String):
            UserProfile.fromJson(jsonDecode(json)),
    };
    final seed = _buildSeedUsers();
    final seedIds = seed.map((user) => user.id).toSet();
    return [
      // The role is managed by the company, not by the profile edits.
      for (final user in seed)
        stored[user.id]?.copyWith(isCompanyAdmin: user.isCompanyAdmin) ?? user,
      ...stored.values.where((user) => !seedIds.contains(user.id)),
    ];
  }

  /// One admin per company; the demo user manages Northwind Labs.
  static const Set<String> _seedAdminIds = {'u_me', 'u_04', 'u_07', 'u_11'};

  List<UserProfile> _buildSeedUsers() => [
        UserProfile(
            id: demoUserId,
            name: 'Mario Rossi',
            role: 'Mobile Developer',
            email: demoEmail,
            companyId: 'c_northwind',
            joinedAt: DateTime(2021, 3, 15),
            bio: 'Building the Scoreboard app. Coffee first, then code.',
            bannerPreset: 'gold_topography'),
        _user('u_01', 'Giulia Bianchi', 'Tech Lead', 'c_northwind', 2019),
        _user('u_02', 'Luca Ferrari', 'Backend Developer', 'c_northwind', 2022),
        _user('u_03', 'Sara Romano', 'QA Engineer', 'c_northwind', 2023),
        _user('u_04', 'Marco Colombo', 'DevOps Engineer', 'c_bluepeak', 2018),
        _user('u_05', 'Elena Ricci', 'Data Scientist', 'c_bluepeak', 2020),
        _user(
            'u_06', 'Davide Marino', 'Frontend Developer', 'c_bluepeak', 2021),
        _user('u_07', 'Chiara Greco', 'Firmware Engineer', 'c_orbit', 2016),
        _user('u_08', 'Paolo Bruno', 'Solutions Architect', 'c_orbit', 2019),
        _user('u_09', 'Anna Gallo', 'Product Designer', 'c_lumen', 2020),
        _user('u_10', 'Matteo Conti', 'iOS Developer', 'c_lumen', 2022),
        _user(
            'u_11', 'Francesca Costa', 'Engineering Manager', 'c_lumen', 2017),
      ]
          .map((user) => _seedAdminIds.contains(user.id)
              ? user.copyWith(isCompanyAdmin: true)
              : user)
          .toList();

  UserProfile _user(
      String id, String name, String role, String companyId, int year) {
    final email =
        '${name.toLowerCase().replaceAll(' ', '.')}@${companyId.substring(2)}.dev';
    return UserProfile(
        id: id,
        name: name,
        role: role,
        email: email,
        companyId: companyId,
        joinedAt: DateTime(year, 1 + id.hashCode % 12, 1));
  }

  static const List<(String, String, String, int)> _templates = [
    (
      'Code Ninja',
      'Mastered multiple programming languages.',
      'code_icon.png',
      100
    ),
    ('Bug Hunter', 'Identified and resolved complex bugs.', 'bug_icon.png', 80),
    (
      'Tech Innovator',
      'Introduced innovative solutions to improve efficiency.',
      'innovation_icon.png',
      120
    ),
    (
      'Open Source Contributor',
      'Contributed code to open-source projects.',
      'opensource_icon.png',
      150
    ),
    (
      'Data Wizard',
      'Excelled in data analysis and manipulation.',
      'data_icon.png',
      90
    ),
    (
      'Agile Guru',
      'Mastered Agile methodologies and practices.',
      'agile_icon.png',
      110
    ),
    (
      'Cybersecurity Defender',
      'Implemented robust cybersecurity measures.',
      'cybersecurity_icon.png',
      130
    ),
    (
      'Cloud Computing Expert',
      'Demonstrated expertise in cloud computing technologies.',
      'cloud_icon.png',
      140
    ),
    (
      'Tech Mentor',
      'Guided and mentored junior team members.',
      'mentor_icon.png',
      100
    ),
    (
      'Continuous Integration Champion',
      'Implemented and managed CI/CD pipelines.',
      'ci_icon.png',
      120
    ),
  ];

  List<AchievementTemplate> _buildBaseTemplates() {
    AchievementTemplate template(String id, String name, String description,
        String icon, int points, String createdById) {
      return AchievementTemplate(
        id: id,
        name: name,
        description: description,
        icon: icon,
        points: points,
        createdById: createdById,
        createdByName: _users.firstWhere((u) => u.id == createdById).name,
        createdAt: DateTime(2025, 11, 3),
      );
    }

    return [
      template(
          'tpl_team_player',
          'Team Player',
          'Always ready to give the team a hand.',
          'handshake_icon.png',
          25,
          'u_01'),
      template(
          'tpl_coffee_hero',
          'Coffee Hero',
          'Kept the team caffeinated and motivated.',
          'coffee_icon.png',
          10,
          'u_02'),
      template(
          'tpl_sharp_reviewer',
          'Sharp Reviewer',
          'Left thoughtful and helpful code reviews.',
          'review_icon.png',
          25,
          'u_02'),
      template(
          'tpl_great_idea',
          'Great Idea',
          'Proposed an idea that made a real difference.',
          'star_icon.png',
          50,
          'u_03'),
      template(
          'tpl_lifesaver',
          'Lifesaver',
          'Jumped in to unblock a colleague at the right time.',
          'support_icon.png',
          50,
          'u_01'),
    ];
  }

  /// Deterministic distribution so the leaderboards differ. Every fourth
  /// slot is a base achievement sent by a colleague of the same company;
  /// the others are verified achievements issued by the company.
  List<Achievement> _buildAchievements() {
    final achievements = <Achievement>[];
    final seedUsers = _users.take(_seedUserCount).toList();
    for (var i = 0; i < seedUsers.length; i++) {
      final user = seedUsers[i];
      final company = _companies.firstWhere((c) => c.id == user.companyId);
      final sender = seedUsers
          .firstWhere((u) => u.companyId == user.companyId && u.id != user.id);
      final count = i == 0 ? _templates.length : 2 + (i * 5) % 8;
      for (var k = 0; k < count; k++) {
        final date = DateTime(2026, 1 + (i + k) % 9, 1 + (i * 7 + k * 3) % 27);
        final Achievement achievement;
        if ((i + k) % 4 == 0) {
          final base = _seedTemplates[(i + k) % _seedTemplates.length];
          achievement = Achievement(
            id: 'ach_${user.id}_p$k',
            userId: user.id,
            name: base.name,
            description: base.description,
            icon: base.icon,
            points: base.points,
            company: company.name,
            companyId: company.id,
            date: date,
            verified: false,
            templateId: base.id,
            awardedById: sender.id,
            awardedByName: sender.name,
            note: k == 0 ? 'Thanks for the help this sprint!' : null,
          );
        } else {
          final j = (i * 3 + k) % _templates.length;
          final (name, description, icon, points) = _templates[j];
          achievement = Achievement(
            id: 'ach_${user.id}_$j',
            userId: user.id,
            name: name,
            description: description,
            icon: icon,
            points: points,
            company: company.name,
            companyId: company.id,
            companyBrand: company.brand,
            catalogId: 'cat_${company.id}_$j',
            date: date,
            verified: true,
          );
        }
        _seedAchievementIds.add(achievement.id!);
        achievements.add(achievement);
      }
    }
    return achievements;
  }
}

class _Credential {
  final String userId;
  final String salt;
  final String hash;

  const _Credential(this.userId, this.salt, this.hash);

  /// Salted SHA-256: enough for a local mock. A real backend should hash
  /// server-side with a slow algorithm such as bcrypt or Argon2.
  factory _Credential.create(String userId, String password) {
    final random = Random.secure();
    final salt =
        base64Url.encode(List.generate(16, (_) => random.nextInt(256)));
    return _Credential(
        userId, salt, MockScoreboardRepository._hash(password, salt));
  }

  factory _Credential.fromJson(Map<String, dynamic> json) =>
      _Credential(json['user_id'], json['salt'], json['hash']);

  Map<String, dynamic> toJson() =>
      {'user_id': userId, 'salt': salt, 'hash': hash};
}
