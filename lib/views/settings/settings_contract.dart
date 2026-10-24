import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class SettingsViewContract extends BaseViewContract {
  void fillAccountForm(UserProfile user);
  void clearPasswordForm();
  void showMessage(String message);
  void openSignIn();
  void showUpdateAvailable(ReleaseInfo release);
}

abstract class SettingsViewModelContract
    extends BaseViewModelContract<SettingsState, SettingsViewContract> {
  void onTapChangePage(int page);
  void loadAccount();
  void saveEmail(String email);
  void changePassword(String currentPassword, String newPassword);
  void signOut();
  void onToggleCommunityVisibility(bool visible);
  void onCheckForUpdates();
  void onToggleHaptics(bool enabled);
}

class SettingsState extends BaseVMState {
  int currentPage = 0;
  bool isSavingEmail = false;
  bool isChangingPassword = false;
  bool hiddenFromCommunity = false;
  bool isCheckingUpdates = false;
  bool hapticsEnabled = true;
  String appName = '';
  String appVersion = '';
}
