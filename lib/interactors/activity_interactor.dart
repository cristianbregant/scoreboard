import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/services/scoreboard_repository.dart';

/// The company's activity log: what admins and managers did.
///
/// Written by the other interactors here; a backend should write it itself
/// next to each action, where it can't be skipped.
class ActivityInteractor {
  final ScoreboardRepository _repository;
  final ScoreboardInteractor _scoreboard;

  ActivityInteractor(this._repository, this._scoreboard);

  Future<void> log(ActivityType type,
      {String? subject, String? target, int? count}) async {
    final actor = await _scoreboard.getCurrentUser();
    final now = DateTime.now();
    await _repository.addActivity(ActivityEntry(
      id: 'act_${now.microsecondsSinceEpoch}',
      companyId: actor.companyId,
      actorId: actor.id,
      actorName: actor.name,
      type: type,
      createdAt: now,
      subject: subject,
      target: target,
      count: count,
    ));
  }

  /// Newest first; admins only.
  Future<List<ActivityEntry>> getActivity() async {
    final user = await _scoreboard.getCurrentUser();
    if (!user.isCompanyAdmin) throw const AdminException(AdminError.notAdmin);
    return _repository.getActivity(user.companyId);
  }
}
