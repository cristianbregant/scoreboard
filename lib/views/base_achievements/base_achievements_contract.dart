import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_contract.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

abstract class BaseAchievementsViewContract
    extends SendAchievementViewContract {
  Future<AchievementTemplateDraft?> askNewTemplate();
  Future<bool> confirmDeleteTemplate(AchievementTemplate template);
}

abstract class BaseAchievementsViewModelContract extends BaseViewModelContract<
    BaseAchievementsState,
    BaseAchievementsViewContract> implements SendAchievementActions {
  void loadTemplates();
  void onTapCreateTemplate();
  void onTapDeleteTemplate(AchievementTemplate template);
}

class BaseAchievementsState extends BaseVMState {
  String? currentUserId;
  List<AchievementTemplate> templates = [];

  /// Achievements the current user sent, newest first.
  List<Achievement> sent = [];

  /// Recipients of [sent], by id.
  Map<String, UserProfile> colleagues = {};

  bool isOwn(AchievementTemplate template) =>
      template.createdById == currentUserId;
}
