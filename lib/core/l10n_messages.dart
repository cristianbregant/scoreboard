import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';

/// Localized text for values the domain layer exposes as codes.

extension AuthExceptionText on AuthException {
  String localized(AppLocalization l10n) => switch (error) {
        AuthError.notSignedIn => l10n.errorNotSignedIn,
        AuthError.wrongCredentials => l10n.errorWrongCredentials,
        AuthError.emailTaken => l10n.errorEmailTaken,
        AuthError.wrongCurrentPassword => l10n.errorWrongCurrentPassword,
        AuthError.missingCredentials => l10n.errorMissingCredentials,
        AuthError.missingNameOrRole => l10n.errorMissingNameOrRole,
        AuthError.invalidEmail => l10n.invalidEmail,
        AuthError.passwordTooShort =>
          l10n.errorPasswordTooShort(AuthInteractor.minPasswordLength),
      };
}

extension SendAchievementExceptionText on SendAchievementException {
  String localized(AppLocalization l10n) => switch (error) {
        SendAchievementError.invalidPoints => l10n
            .errorInvalidPoints(AchievementTemplate.allowedPoints.join(' / ')),
        SendAchievementError.notTemplateOwner => l10n.errorNotTemplateOwner,
        SendAchievementError.notAColleague => l10n.errorNotAColleague,
        SendAchievementError.templateNotFound => l10n.errorTemplateNotFound,
        SendAchievementError.alreadySent =>
          l10n.errorAlreadySent(templateName ?? '', colleagueName ?? ''),
      };
}

extension AchievementTierText on AchievementTier {
  String localized(AppLocalization l10n) => switch (this) {
        AchievementTier.peer => l10n.tierPeer,
        AchievementTier.bronze => l10n.tierBronze,
        AchievementTier.silver => l10n.tierSilver,
        AchievementTier.gold => l10n.tierGold,
        AchievementTier.platinum => l10n.tierPlatinum,
      };
}

/// Name of a profile cover preset, by key.
String bannerPresetLabel(AppLocalization l10n, String key) => switch (key) {
      'graphite_grid' => l10n.bannerGraphite,
      'gold_topography' => l10n.bannerGold,
      'forest_dots' => l10n.bannerForest,
      'ocean_waves' => l10n.bannerOcean,
      'clay_diagonal' => l10n.bannerClay,
      'sand_plain' => l10n.bannerSand,
      _ => key,
    };
