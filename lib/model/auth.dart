class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}

class RegistrationDraft {
  final String name;
  final String role;
  final String companyId;
  final String email;
  final String password;

  const RegistrationDraft(
      {required this.name,
      required this.role,
      required this.companyId,
      required this.email,
      required this.password});
}

/// Changes to the public profile. Image fields hold the path of a newly
/// picked file; the remove flags clear the current image.
class ProfileDraft {
  final String name;
  final String role;
  final String bio;
  final String bannerPreset;
  final String? newAvatarSource;
  final bool removeAvatar;
  final String? newBannerSource;
  final bool removeBanner;

  const ProfileDraft(
      {required this.name,
      required this.role,
      required this.bio,
      required this.bannerPreset,
      this.newAvatarSource,
      this.removeAvatar = false,
      this.newBannerSource,
      this.removeBanner = false});
}
