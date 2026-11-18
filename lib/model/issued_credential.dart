/// A verified achievement as a credential signed by the backend: an Open
/// Badges 3.0 `OpenBadgeCredential` secured as a VC-JWT.
class IssuedCredential {
  /// The compact JWS to download or hand to a badge wallet.
  final String jwt;

  /// The credential the JWT carries, for display.
  final Map<String, dynamic> credential;

  /// Public page where anyone can check the credential.
  final Uri verifyUrl;

  const IssuedCredential(
      {required this.jwt, required this.credential, required this.verifyUrl});

  factory IssuedCredential.fromJson(Map<String, dynamic> json) =>
      IssuedCredential(
        jwt: json['jwt'],
        credential: json['credential'],
        verifyUrl: Uri.parse(json['verify_url']),
      );
}
