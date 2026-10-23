class UserProfile {
  static const String defaultBanner = 'graphite_grid';

  final String id;
  final String name;
  final String role;
  final String email;
  final String companyId;
  final DateTime joinedAt;
  final String bio;

  /// Local path of the profile photo; initials are shown when null.
  final String? avatarPath;

  /// Key of a preset cover, see `bannerPresets`.
  final String bannerPreset;

  /// Local path of a custom cover image; overrides [bannerPreset].
  final String? bannerImagePath;

  /// Can manage the company catalog and issue verified achievements.
  final bool isCompanyAdmin;

  /// Left out of the global (Community) leaderboard.
  final bool hiddenFromCommunity;

  const UserProfile(
      {required this.id,
      required this.name,
      required this.role,
      required this.email,
      required this.companyId,
      required this.joinedAt,
      this.bio = '',
      this.avatarPath,
      this.bannerPreset = defaultBanner,
      this.bannerImagePath,
      this.isCompanyAdmin = false,
      this.hiddenFromCommunity = false});

  String get initials => name
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();

  /// [avatarPath] and [bannerImagePath] are cleared by passing an empty
  /// string, since null means "unchanged".
  UserProfile copyWith(
      {String? name,
      String? role,
      String? email,
      String? bio,
      String? avatarPath,
      String? bannerPreset,
      String? bannerImagePath,
      bool? isCompanyAdmin,
      bool? hiddenFromCommunity}) {
    String? orClear(String? value, String? current) =>
        value == null ? current : (value.isEmpty ? null : value);

    return UserProfile(
      id: id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      companyId: companyId,
      joinedAt: joinedAt,
      bio: bio ?? this.bio,
      avatarPath: orClear(avatarPath, this.avatarPath),
      bannerPreset: bannerPreset ?? this.bannerPreset,
      bannerImagePath: orClear(bannerImagePath, this.bannerImagePath),
      isCompanyAdmin: isCompanyAdmin ?? this.isCompanyAdmin,
      hiddenFromCommunity: hiddenFromCommunity ?? this.hiddenFromCommunity,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      companyId: json['company_id'],
      joinedAt: DateTime.parse(json['joined_at']),
      bio: json['bio'] ?? '',
      avatarPath: json['avatar_path'],
      bannerPreset: json['banner_preset'] ?? defaultBanner,
      bannerImagePath: json['banner_image_path'],
      isCompanyAdmin: json['is_company_admin'] ?? false,
      hiddenFromCommunity: json['hidden_from_community'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'role': role,
        'email': email,
        'company_id': companyId,
        'joined_at': joinedAt.toIso8601String(),
        'bio': bio,
        'avatar_path': avatarPath,
        'banner_preset': bannerPreset,
        'banner_image_path': bannerImagePath,
        'is_company_admin': isCompanyAdmin,
        'hidden_from_community': hiddenFromCommunity,
      };
}
