import 'package:scoreboard/core/certificate_pdf.dart';
import 'package:scoreboard/interactors/credential_interactor.dart';
import 'package:scoreboard/interactors/scoreboard_interactor.dart';
import 'dart:typed_data';

import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/share_interactor.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/views/_base/base_view_model.dart';
import 'package:scoreboard/views/achievement/achievement_contract.dart';

class AchievementViewModel
    extends BaseViewModel<AchievementViewContract, AchievementState>
    implements AchievementViewModelContract {
  final ShareInteractor _shareInteractor;
  final CredentialInteractor _credentials;
  final ScoreboardInteractor _scoreboard;

  AchievementViewModel(
      this._shareInteractor, this._credentials, this._scoreboard);

  @override
  void onTapChangePage(int page) {
    vmState.currentPage = page;
    notifyListeners();
  }

  @override
  void onTapShare(Achievement achievement) {
    sourceView.openShareDialog(achievement, _postText(achievement),
        canAddToProfile:
            _shareInteractor.linkedInCertificationUri(achievement) != null);
  }

  String _postText(Achievement achievement) {
    final name = achievement.name ?? '';
    final description = achievement.description ?? '';
    final sender = achievement.awardedByName;
    if (achievement.verified != true && sender != null) {
      return l10n.sharePostPeer(sender, name, description);
    }
    return l10n.sharePostVerified(name, achievement.company ?? '', description);
  }

  /// The composer's prefill isn't guaranteed by LinkedIn, so the text is
  /// also copied for the user to paste.
  @override
  Future<void> onPostOnLinkedIn(String text) async {
    await _shareInteractor.copyText(text);
    final opened = await sourceView
        .openExternalLink(_shareInteractor.linkedInPostUri(text).toString());
    sourceView.showMessage(opened ? l10n.shareOpened : l10n.shareOpenError);
  }

  @override
  Future<void> onAddToLinkedInProfile(Achievement achievement) async {
    final uri = _shareInteractor.linkedInCertificationUri(achievement);
    if (uri == null) return;
    if (!await sourceView.openExternalLink(uri.toString())) {
      sourceView.showMessage(l10n.shareOpenError);
    }
  }

  @override
  Future<void> onCopyPostText(String text) async {
    await _shareInteractor.copyText(text);
    sourceView.showMessage(l10n.shareTextCopied);
  }

  @override
  Future<void> onSaveShareImage(Uint8List png, Achievement achievement) async {
    try {
      final path = await _shareInteractor.saveImage(png, achievement);
      if (path != null) sourceView.showMessage(l10n.shareImageSaved);
    } catch (_) {
      sourceView.showMessage(l10n.shareSaveError);
    }
  }

  @override
  Future<void> onExportPdf(Achievement achievement) => _export(() async {
        final user = await _scoreboard.getCurrentUser();
        final pdf = await buildCertificatePdf(l10n,
            achievement: achievement, recipientName: user.name);
        return _credentials.saveCertificate(pdf, achievement);
      });

  @override
  Future<void> onExportOpenBadge(Achievement achievement) =>
      _export(() async => _credentials.saveOpenBadge(
          achievement, await _scoreboard.getCurrentUser()));

  Future<void> _export(Future<String?> Function() save) async {
    try {
      if (await save() != null) sourceView.showMessage(l10n.exportSaved);
    } catch (_) {
      sourceView.showMessage(l10n.exportError);
    }
  }
}
