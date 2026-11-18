import 'dart:typed_data';

import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class AchievementViewContract extends BaseViewContract {
  void openShareDialog(Achievement achievement, String postText,
      {required bool canAddToProfile});
  void showMessage(String message);
}

abstract class AchievementViewModelContract
    extends BaseViewModelContract<AchievementState, AchievementViewContract> {
  void loadCredential(Achievement achievement);
  void onTapChangePage(int page);
  void onTapShare(Achievement achievement);
  void onPostOnLinkedIn(String text);
  void onAddToLinkedInProfile(Achievement achievement);
  void onCopyPostText(String text);
  void onSaveShareImage(Uint8List png, Achievement achievement);
  void onExportPdf(Achievement achievement);
  void onExportOpenBadge(Achievement achievement);
  void onCopyVerifyLink();
}

class AchievementState extends BaseVMState {
  int currentPage = 0;

  /// Public page of the signed credential; null for peer achievements and
  /// without a backend.
  Uri? verifyUrl;
}
