enum AuthError {
  notSignedIn,
  wrongCredentials,
  emailTaken,
  wrongCurrentPassword,
  missingCredentials,
  missingNameOrRole,
  invalidEmail,
  passwordTooShort,

  /// The invitation code is wrong, expired or for another email.
  invalidInviteCode,
  missingCompanyName,

  /// A company with that name exists: join it with an invitation instead.
  companyNameTaken,
}

/// Carries an [AuthError] code; the UI turns it into localized text.
class AuthException implements Exception {
  final AuthError error;

  const AuthException(this.error);

  @override
  String toString() => 'AuthException($error)';
}

/// A new account, which either joins an existing company with the code of
/// an invitation ([inviteCode]) or creates a company ([newCompany]) and
/// becomes its first admin.
class RegistrationDraft {
  final String name;
  final String role;
  final String email;
  final String password;
  final String? inviteCode;
  final CompanyDraft? newCompany;

  const RegistrationDraft.join(
      {required this.name,
      required this.role,
      required this.email,
      required this.password,
      required String this.inviteCode})
      : newCompany = null;

  const RegistrationDraft.createCompany(
      {required this.name,
      required this.role,
      required this.email,
      required this.password,
      required CompanyDraft this.newCompany})
      : inviteCode = null;
}

/// A company created at registration. Industry and location may be empty.
class CompanyDraft {
  final String name;
  final String industry;
  final String location;

  const CompanyDraft(
      {required this.name, this.industry = '', this.location = ''});
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
