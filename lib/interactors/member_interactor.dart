import 'package:scoreboard/interactors/activity_interactor.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// Who belongs to the company and who manages it: invitations to join it
/// and the admin role. Admins only.
class MemberInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;
  final ActivityInteractor _activity;

  MemberInteractor(this._repository, this._scoreboard, this._activity);

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
