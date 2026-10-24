/// An invitation to join a company: the invited person registers with
/// [email] and the code they received by email.
class Invite {
  /// Invitations expire after a week.
  static const Duration validity = Duration(days: 7);

  final String id;
  final String companyId;
  final String email;
  final String invitedById;
  final String invitedByName;
  final DateTime createdAt;
  final DateTime expiresAt;

  /// Only the local mock knows it, since it can't send emails; the backend
  /// never shares it.
  final String? code;

  const Invite(
      {required this.id,
      required this.companyId,
      required this.email,
      required this.invitedById,
      required this.invitedByName,
      required this.createdAt,
      required this.expiresAt,
      this.code});

  bool isExpiredAt(DateTime now) => !now.isBefore(expiresAt);

  factory Invite.fromJson(Map<String, dynamic> json) => Invite(
        id: json['id'],
        companyId: json['company_id'],
        email: json['email'],
        invitedById: json['invited_by_id'],
        invitedByName: json['invited_by_name'],
        createdAt: DateTime.parse(json['created_at']),
        expiresAt: DateTime.parse(json['expires_at']),
        code: json['code'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'company_id': companyId,
        'email': email,
        'invited_by_id': invitedById,
        'invited_by_name': invitedByName,
        'created_at': createdAt.toIso8601String(),
        'expires_at': expiresAt.toIso8601String(),
        'code': code,
      };
}
