import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/profile/profile_contract.dart';

class ProfileViewModel extends BaseViewModel<ProfileViewContract, ProfileState>
    implements ProfileViewModelContract {
  final ScoreboardInteractor _interactor;

  ProfileViewModel(this._interactor);

  @override
  void onInitState() {
    _interactor.addListener(loadProfile);
    loadProfile();
  }

  @override
  void onDispose() => _interactor.removeListener(loadProfile);

  @override
  Future<void> loadProfile() async {
    vmState.hasError = false;
    startLoadingState();
    try {
      final user = await _interactor.getCurrentUser();
      vmState.user = user;
      vmState.company = await _interactor.getCompany(user.companyId);
      vmState.achievements = await _interactor.getAchievementsOf(user.id);

      final global = await _interactor.getUserLeaderboard();
      vmState.globalRank =
          global.where((e) => e.user.id == user.id).firstOrNull?.rank;
      final company =
          await _interactor.getUserLeaderboard(companyId: user.companyId);
      vmState.companyRank =
          company.where((e) => e.user.id == user.id).firstOrNull?.rank;
    } catch (_) {
      vmState.hasError = true;
    }
    stopLoadingState();
  }

  @override
  void onTapAchievement(Achievement achievement) {
    sourceView.onTapAchievement(achievement);
  }

  @override
  Future<void> onTapEditProfile() async {
    final user = vmState.user;
    if (user == null) return;
    final draft = await sourceView.askEditProfile(user);
    if (draft == null) return;
    try {
      await _interactor.updateProfile(draft);
      sourceView.showMessage("Profile updated");
    } on AuthException catch (e) {
      sourceView.showMessage(e.message);
    } catch (_) {
      sourceView.showMessage("Could not save your profile. Try again.");
    }
  }

  @override
  Future<String?> pickImage() => _interactor.pickImage();
}
