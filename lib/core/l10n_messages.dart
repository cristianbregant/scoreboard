import 'package:scoreboard/model/activity.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/admin.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/feed.dart';
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
        SendAchievementError.budgetExhausted =>
          l10n.errorBudgetExhausted(SendAchievementOptions.monthlyBudget),
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

extension AdminExceptionText on AdminException {
  String localized(AppLocalization l10n) => switch (error) {
        AdminError.notAdmin => l10n.errorNotAdmin,
        AdminError.missingFields => l10n.errorMissingFields,
        AdminError.invalidPoints => l10n.errorCatalogPoints(
            CatalogAchievement.minPoints, CatalogAchievement.maxPoints),
        AdminError.alreadyOwned => l10n.errorAlreadyOwned,
        AdminError.requestPending => l10n.errorRequestPending,
        AdminError.invalidUrl => l10n.invalidUrl,
        AdminError.notFound => l10n.errorNotFound,
        AdminError.invalidDates => l10n.errorInvalidDates,
        AdminError.seasonOverlap => l10n.errorSeasonOverlap,
        AdminError.notManager => l10n.errorNotManager,
        AdminError.notInTeam => l10n.errorNotInTeam,
      };
}

extension AppNotificationText on AppNotification {
  String title(AppLocalization l10n) => switch (type) {
        NotificationType.peerAchievementReceived => l10n.notifPeerTitle,
        NotificationType.verifiedAchievementReceived => l10n.notifVerifiedTitle,
        NotificationType.levelUp => l10n.notifLevelUpTitle,
        NotificationType.requestApproved => l10n.notifApprovedTitle,
        NotificationType.requestRejected => l10n.notifRejectedTitle,
        NotificationType.newRequest => l10n.notifNewRequestTitle,
        NotificationType.newNomination => l10n.notifNominationTitle,
        NotificationType.feedReaction => l10n.notifReactionTitle,
        NotificationType.feedComment => l10n.notifCommentTitle,
        NotificationType.weeklyRecap => l10n.notifRecapTitle,
      };

  String body(AppLocalization l10n) {
    final actor = actorName ?? '';
    final name = achievementName ?? '';
    return switch (type) {
      NotificationType.peerAchievementReceived =>
        l10n.notifPeerBody(actor, name),
      NotificationType.verifiedAchievementReceived =>
        l10n.notifVerifiedBody(actor, name),
      NotificationType.levelUp => l10n.notifLevelUpBody(number ?? 0),
      NotificationType.requestApproved => l10n.notifApprovedBody(name),
      NotificationType.requestRejected => text == null
          ? l10n.notifRejectedBody(name)
          : l10n.notifRejectedBodyReason(name, text!),
      NotificationType.newRequest => l10n.notifNewRequestBody(actor, name),
      NotificationType.newNomination =>
        l10n.notifNominationBody(actor, name, text ?? ''),
      NotificationType.feedReaction => l10n.notifReactionBody(actor, name),
      NotificationType.feedComment =>
        l10n.notifCommentBody(actor, name, text ?? ''),
      NotificationType.weeklyRecap =>
        l10n.notifRecapBody(number ?? 0, secondNumber ?? 0),
    };
  }
}

/// "Just now", "5 min ago", "3 h ago", "Yesterday", then a date.
String timeAgo(AppLocalization l10n, DateTime time) {
  final elapsed = DateTime.now().difference(time);
  if (elapsed.inMinutes < 1) return l10n.timeJustNow;
  if (elapsed.inHours < 1) return l10n.timeMinutes(elapsed.inMinutes);
  if (elapsed.inDays < 1) return l10n.timeHours(elapsed.inHours);
  if (elapsed.inDays < 7) return l10n.timeDays(elapsed.inDays);
  return formatDate(time);
}

extension ReactionTypeText on ReactionType {
  String localized(AppLocalization l10n) => switch (this) {
        ReactionType.like => l10n.reactionLike,
        ReactionType.celebrate => l10n.reactionCelebrate,
        ReactionType.love => l10n.reactionLove,
        ReactionType.insightful => l10n.reactionInsightful,
      };
}

extension ActivityEntryText on ActivityEntry {
  /// What the actor did, to show after their name: "approved “X” for Y".
  String describe(AppLocalization l10n) {
    final subject = this.subject ?? '';
    final target = this.target ?? '';
    return switch (type) {
      ActivityType.catalogCreated => l10n.activityCatalogCreated(subject),
      ActivityType.catalogUpdated => l10n.activityCatalogUpdated(subject),
      ActivityType.catalogArchived => l10n.activityCatalogArchived(subject),
      ActivityType.catalogRestored => l10n.activityCatalogRestored(subject),
      ActivityType.achievementsIssued =>
        l10n.activityAchievementsIssued(count ?? 0, subject),
      ActivityType.requestApproved =>
        l10n.activityRequestApproved(subject, target),
      ActivityType.requestRejected =>
        l10n.activityRequestRejected(subject, target),
      ActivityType.nominationSubmitted =>
        l10n.activityNominationSubmitted(subject, target),
      ActivityType.teamCreated => l10n.activityTeamCreated(subject),
      ActivityType.teamUpdated => l10n.activityTeamUpdated(subject),
      ActivityType.teamDeleted => l10n.activityTeamDeleted(subject),
      ActivityType.memberMoved => this.target == null
          ? l10n.activityMemberRemoved(subject)
          : l10n.activityMemberMoved(subject, target),
      ActivityType.seasonCreated => l10n.activitySeasonCreated(subject),
      ActivityType.seasonUpdated => l10n.activitySeasonUpdated(subject),
      ActivityType.seasonDeleted => l10n.activitySeasonDeleted(subject),
      ActivityType.brandUpdated => l10n.activityBrandUpdated,
      ActivityType.anniversariesUpdated => l10n.activityAnniversariesUpdated,
      ActivityType.reportExported => subject == 'people'
          ? l10n.activityReportPeople(target)
          : l10n.activityReportAchievements(target),
      ActivityType.personalDataExported =>
        l10n.activityPersonalDataExported(target),
    };
  }
}
