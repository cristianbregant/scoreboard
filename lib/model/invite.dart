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

  /// Applied when the person joins, e.g. from an HR import. A role typed at
  /// registration wins over [role].
  final String? role;
  final String? teamId;

  const Invite(
      {required this.id,
      required this.companyId,
      required this.email,
      required this.invitedById,
      required this.invitedByName,
      required this.createdAt,
      required this.expiresAt,
      this.code,
      this.role,
      this.teamId});

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
        role: json['role'],
        teamId: json['team_id'],
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
        'role': role,
        'team_id': teamId,
      };
}

/// Why a line of an import file is left out.
enum InviteProblem { invalidEmail, duplicate, alreadyMember, unknownTeam }

class InviteImportProblem {
  /// As numbered in the file, 1 being the first line.
  final int line;
  final InviteProblem type;

  /// The email or team name at fault.
  final String? value;

  const InviteImportProblem(
      {required this.line, required this.type, this.value});
}

/// An import file read and checked, before anyone is invited.
class InviteImport {
  final List<InviteDraft> drafts;
  final List<InviteImportProblem> problems;

  const InviteImport({required this.drafts, required this.problems});
}

/// Someone to invite in an import.
class InviteDraft {
  final String email;
  final String? role;
  final String? teamId;

  const InviteDraft({required this.email, this.role, this.teamId});

  Map<String, dynamic> toJson() => {
        'email': email,
        if (role != null) 'role': role,
        if (teamId != null) 'team_id': teamId,
      };
}

/// What an import did: who was invited, and who was left out and why
/// (`duplicate`, or an [AdminError] name such as `alreadyMember`).
class BulkInviteResult {
  final List<Invite> created;
  final List<({String email, String reason})> skipped;

  const BulkInviteResult({required this.created, required this.skipped});

  factory BulkInviteResult.fromJson(Map<String, dynamic> json) =>
      BulkInviteResult(
        created: [
          for (final invite in json['created'] as List) Invite.fromJson(invite)
        ],
        skipped: [
          for (final skip in json['skipped'] as List)
            (email: skip['email'] as String, reason: skip['reason'] as String)
        ],
      );
}
