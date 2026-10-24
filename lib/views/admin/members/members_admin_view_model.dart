import 'package:intl/intl.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/member_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/members/members_admin_contract.dart';

class MembersAdminViewModel
    extends BaseViewModel<MembersAdminViewContract, MembersAdminState>
    with AdminScreenFlow<MembersAdminViewContract, MembersAdminState>
    implements MembersAdminViewModelContract {
  final MemberInteractor _members;
  @override
  final ScoreboardInteractor scoreboard;

  MembersAdminViewModel(this._members, this.scoreboard);

  @override
  Future<void> fetch() async {
    final user = await scoreboard.getCurrentUser();
    vmState.currentUserId = user.id;
    vmState.companyName = (await scoreboard.getCompany(user.companyId)).name;
    vmState.members = await _members.getMembers();
    vmState.invites = await _members.getInvites();
  }

  @override
  Future<void> onTapInvite() async {
    final email = await sourceView.askInviteEmail(vmState.companyName);
    if (email != null) await _invite(email);
  }

  @override
  Future<void> onResendInvite(Invite invite) => _invite(invite.email);

  /// The email is written in the admin's language, the best guess for a
  /// colleague's.
  Future<void> _invite(String email) async {
    Invite? sent;
    final done = await runAction(() async => sent = await _members.invite(email,
        languageCode: Intl.getCurrentLocale().split(RegExp('[_-]')).first));
    final invite = sent;
    if (!done || invite == null) return;
    // The local mock can't send emails, so the admin passes the code on.
    final code = invite.code;
    sourceView.showMessage(code == null
        ? l10n.inviteSent(invite.email)
        : l10n.inviteSentDemo(invite.email, code));
  }

  @override
  Future<void> onTapRevokeInvite(Invite invite) async {
    final confirmed = await sourceView.confirm(
        title: l10n.inviteRevokeTitle(invite.email),
        body: l10n.inviteRevokeBody,
        action: l10n.inviteRevoke);
    if (!confirmed) return;
    await runAction(() => _members.revokeInvite(invite),
        success: l10n.inviteRevoked);
  }

  @override
  Future<void> onToggleAdmin(UserProfile member, bool isAdmin) async {
    if (!isAdmin && member.id == vmState.currentUserId) {
      final confirmed = await sourceView.confirm(
          title: l10n.adminRevokeSelfTitle,
          body: l10n.adminRevokeSelfBody,
          action: l10n.adminRevokeSelfAction);
      if (!confirmed) return;
    }
    await runAction(() => _members.setAdmin(member, isAdmin),
        success: isAdmin
            ? l10n.adminGrantedMessage(member.name)
            : l10n.adminRevokedMessage(member.name));
  }
}
