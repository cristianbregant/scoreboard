import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/views/_base/base_contract.dart';

abstract class FeedViewContract extends BaseViewContract {
  void showMessage(String message);
  void clearCommentField(String achievementId);
}

abstract class FeedViewModelContract
    extends BaseViewModelContract<FeedState, FeedViewContract> {
  void loadFeed();
  void onToggleReaction(FeedPost post, ReactionType type);
  void onToggleComments(String achievementId);
  void onSubmitComment(String achievementId, String text);
}

class FeedState extends BaseVMState {
  List<FeedPost> posts = [];

  /// Posts whose comments are open.
  Set<String> expandedComments = {};
}
