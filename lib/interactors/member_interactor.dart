import 'package:scoreboard/core/invite_csv.dart';
import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';
import 'package:scoreboard/services/share_service.dart';

/// Who belongs to the company and who manages it: invitations to join it
/// and the admin role. Admins only.
class MemberInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ActivityInteractor _activity;
  final ShareService _files;

  MemberInteractor(
      this._repository, this._scoreboard, this._activity, this._files);

  /// The text of the CSV file the admin picks; null if cancelled.
  Future<String?> pickImportFile() => _files.openTextFile(ShareFileType.csv);

  /// The company's people, by name.
  Future<List<UserProfile>> getMembers() async {
    final admin = await _requireAdmin();
    return (await _repository.getUsers())
        .where((u) => u.companyId == admin.companyId)
        .toList()
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }

  /// Not used yet, expired ones included, newest first.
  Future<List<Invite>> getInvites() async {
    final admin = await _requireAdmin();
    return _repository.getInvites(admin.companyId);
  }

  /// Emails [email] a code to join the company, in [languageCode]. Inviting
  /// the same email again sends a new code, and the old one stops working.
  Future<Invite> invite(String email, {required String languageCode}) async {
    await _requireAdmin();
    final normalized = email.trim().toLowerCase();
    if (!AuthInteractor.isValidEmail(normalized)) {
      throw const AdminException(AdminError.invalidEmail);
    }
    if ((await _repository.getUsers())
        .any((u) => u.email.toLowerCase() == normalized)) {
      throw const AdminException(AdminError.alreadyMember);
    }
    final invite =
        await _repository.createInvite(normalized, languageCode: languageCode);
    await _activity.log(ActivityType.memberInvited, subject: normalized);
    _scoreboard.dataChanged();
    return invite;
  }

  /// Reads an HR export ([csv]) into people to invite, matching teams by
  /// name, and lists the lines left out and why.
  Future<InviteImport> readImport(String csv) async {
    final admin = await _requireAdmin();
    final teams = await _repository.getTeams(admin.companyId);
    final taken = {
      for (final user in await _repository.getUsers()) user.email.toLowerCase()
    };
    final drafts = <InviteDraft>[];
    final problems = <InviteImportProblem>[];
    final seen = <String>{};
    for (final row in InviteCsv.parse(csv)) {
      InviteImportProblem problem(InviteProblem type, [String? value]) =>
          InviteImportProblem(line: row.line, type: type, value: value);
      final team = row.team == null
          ? null
          : teams
              .where((t) => t.name.toLowerCase() == row.team!.toLowerCase())
              .firstOrNull;
      if (!AuthInteractor.isValidEmail(row.email)) {
        problems.add(problem(InviteProblem.invalidEmail, row.email));
      } else if (!seen.add(row.email)) {
        problems.add(problem(InviteProblem.duplicate, row.email));
      } else if (taken.contains(row.email)) {
        problems.add(problem(InviteProblem.alreadyMember, row.email));
      } else if (row.team != null && team == null) {
        problems.add(problem(InviteProblem.unknownTeam, row.team));
      } else {
        drafts.add(
            InviteDraft(email: row.email, role: row.role, teamId: team?.id));
      }
    }
    return InviteImport(drafts: drafts, problems: problems);
  }

  /// Emails a code to each of [drafts], in [languageCode]. Throws
  /// [AdminError.missingFields] for none and [AdminError.tooManyInvites]
  /// beyond [ScoreboardRepository.maxBulkInvites].
  Future<BulkInviteResult> importInvites(List<InviteDraft> drafts,
      {required String languageCode}) async {
    await _requireAdmin();
    if (drafts.isEmpty) throw const AdminException(AdminError.missingFields);
    if (drafts.length > ScoreboardRepository.maxBulkInvites) {
      throw const AdminException(AdminError.tooManyInvites);
    }
    final result =
        await _repository.createInvites(drafts, languageCode: languageCode);
    if (result.created.isNotEmpty) {
      await _activity.log(ActivityType.membersImported,
          count: result.created.length);
    }
    _scoreboard.dataChanged();
    return result;
  }

  /// The code stops working.
  Future<void> revokeInvite(Invite invite) async {
    await _requireAdmin();
    await _repository.revokeInvite(invite.id);
    await _activity.log(ActivityType.inviteRevoked, subject: invite.email);
    _scoreboard.dataChanged();
  }

  /// A company always keeps at least one admin. Revoking one's own role is
  /// allowed while another admin remains.
  Future<void> setAdmin(UserProfile member, bool isAdmin) async {
    final admin = await _requireAdmin();
    if (member.companyId != admin.companyId) {
      throw const AdminException(AdminError.notFound);
    }
    if (member.isCompanyAdmin == isAdmin) return;
    if (!isAdmin &&
        (await getMembers()).where((u) => u.isCompanyAdmin).length == 1) {
      throw const AdminException(AdminError.lastAdmin);
    }
    await _repository.setCompanyAdmin(member.id, isAdmin);
    await _activity.log(
        isAdmin ? ActivityType.adminGranted : ActivityType.adminRevoked,
        subject: member.name);
    _scoreboard.dataChanged();
  }

  Future<UserProfile> _requireAdmin() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return user;
  }
}
