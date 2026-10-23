import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/feed_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/feed/feed_contract.dart';

class FeedViewModel extends BaseViewModel<FeedViewContract, FeedState>
    implements FeedViewModelContract {
  final FeedInteractor _interactor;
  final ScoreboardInteractor _scoreboard;

  FeedViewModel(this._interactor, this._scoreboard);

  @override
  void onInitState() {
    _scoreboard.addListener(_reloadSilently);
    loadFeed();
  }

  @override
  void onDispose() => _scoreboard.removeListener(_reloadSilently);

  @override
  Future<void> loadFeed() async {
    vmState.hasError = false;
    startLoadingState();
    await _fetch();
    stopLoadingState();
  }

  /// Refreshes without the loading spinner, e.g. after a reaction.
  Future<void> _reloadSilently() async {
    await _fetch();
    notifyListeners();
  }

  Future<void> _fetch() async {
    try {
      vmState.posts = await _interactor.getFeed();
    } catch (_) {
      vmState.hasError = true;
    }
  }

  @override
  Future<void> onToggleReaction(FeedPost post, ReactionType type) async {
    try {
      await _interactor.toggleReaction(post, type);
    } catch (_) {
      sourceView.showMessage(l10n.actionError);
    }
  }

  @override
  void onToggleComments(String achievementId) {
    final expanded = vmState.expandedComments;
    expanded.contains(achievementId)
        ? expanded.remove(achievementId)
        : expanded.add(achievementId);
    notifyListeners();
  }

  @override
  Future<void> onSubmitComment(String achievementId, String text) async {
    try {
      if (await _interactor.comment(achievementId, text)) {
        sourceView.clearCommentField(achievementId);
      }
    } catch (_) {
      sourceView.showMessage(l10n.actionError);
    }
  }
}
