import 'package:scoreboard/model/invite.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';

abstract class MembersAdminViewContract extends AdminViewContract {
  /// Email address to invite to [companyName]; null if cancelled.
  Future<String?> askInviteEmail(String companyName);
}

abstract class MembersAdminViewModelContract
    extends BaseViewModelContract<MembersAdminState, MembersAdminViewContract> {
  void load();
  void onTapInvite();
  void onResendInvite(Invite invite);
  void onTapRevokeInvite(Invite invite);
  void onToggleAdmin(UserProfile member, bool isAdmin);
}

class MembersAdminState extends BaseVMState {
  String companyName = '';
  String? currentUserId;

  /// The company's people, by name.
  List<UserProfile> members = [];

  /// Not used yet, newest first.
  List<Invite> invites = [];
}
