// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 achievement', other: '${count} achievements')}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'Assign', one: 'Assign to 1 person', other: 'Assign to ${count} people')}";

  static String m2(maxPoints) =>
      "Base achievements are sent between colleagues and are worth up to ${maxPoints} XP. Verified achievements are issued only by your company. You can send each base achievement to the same colleague once.";

  static String m3(remaining, budget) =>
      "${remaining} of ${budget} sends left this month";

  static String m4(name) => "From ${name}";

  static String m5(date) => "Issued on ${date}";

  static String m6(date) => "Received on ${date}";

  static String m7(id) => "Credential ID: ${id}";

  static String m8(company, date) => "Issued by ${company} on ${date}";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'Comment', one: '1 comment', other: '${count} comments')}";

  static String m10(year) => "Since ${year}";

  static String m11(count) => "Requests · ${count}";

  static String m12(company) => "Manage ${company}\'s verified achievements";

  static String m13(name) => "By ${name}";

  static String m14(name) => "Delete “${name}”?";

  static String m15(email, password) => "Demo account: ${email} / ${password}";

  static String m16(id) => "ID ${id}";

  static String m17(template, colleague) =>
      "You already sent “${template}” to ${colleague}.";

  static String m18(budget) =>
      "You\'ve sent all ${budget} achievements for this month. The budget resets on the 1st.";

  static String m19(min, max) =>
      "The value must be between ${min} and ${max} XP.";

  static String m20(values) => "Base achievements can be worth ${values} XP.";

  static String m21(min) => "The password must be at least ${min} characters.";

  static String m22(count) => "All · ${count}";

  static String m23(tier, count) => "${tier} · ${count}";

  static String m24(count) =>
      "${Intl.plural(count, one: 'Issued to 1 person', other: 'Issued to ${count} people')}";

  static String m25(count) =>
      "${Intl.plural(count, one: 'once', other: '${count} times')}";

  static String m26(level, points) => "Level ${level} · ${points} XP";

  static String m27(level) => "Level ${level}";

  static String m28(count) => "Library · ${count}";

  static String m29(date) => "Member since ${date}";

  static String m30(count) =>
      "${Intl.plural(count, one: '1 member', other: '${count} members')}";

  static String m31(achievement) =>
      "“${achievement}” was approved and is now in your achievements";

  static String m32(actor, achievement, text) =>
      "${actor} commented on “${achievement}”: ${text}";

  static String m33(level) => "You reached level ${level}";

  static String m34(actor, achievement) =>
      "${actor} requested “${achievement}”";

  static String m35(actor, achievement) => "${actor} sent you “${achievement}”";

  static String m36(actor, achievement) =>
      "${actor} reacted to “${achievement}”";

  static String m37(xp, rank) => "This week: +${xp} XP · rank #${rank}";

  static String m38(achievement) => "“${achievement}” wasn\'t approved";

  static String m39(achievement, reason) =>
      "“${achievement}” wasn\'t approved: ${reason}";

  static String m40(company, achievement) =>
      "${company} issued you “${achievement}”";

  static String m41(shortcut) =>
      "Press ${shortcut} to send an achievement from anywhere, or use the menu bar icon.";

  static String m42(budget) =>
      "Verified achievements come from your company: you can ask for them from the catalog. Base achievements are exchanged between colleagues, up to ${budget} a month.";

  static String m43(min) => "At least ${min} characters";

  static String m44(percent) => "${percent}%";

  static String m45(rank) => "#${rank}";

  static String m46(reason) => "Reason: ${reason}";

  static String m47(company) =>
      "An admin at ${company} will review your request.";

  static String m48(role, company) => "${role} at ${company}";

  static String m49(name) => "Achievement sent to ${name}";

  static String m50(count) => "Sent by you · ${count}";

  static String m51(count) => "${count} sent";

  static String m52(company) =>
      "Adds it to Licenses & certifications, with ${company} as the issuer.";

  static String m53(company) => "Issued by ${company}";

  static String m54(sender, name, description) =>
      "🤝 ${sender} recognized me with the “${name}” achievement.\n\n${description}\n\n#Scoreboard";

  static String m55(name, company, description) =>
      "🏆 I just earned the “${name}” achievement, issued by ${company}.\n\n${description}\n\n#Scoreboard";

  static String m56(name) => "“${name}” added to the library";

  static String m57(name) => "“${name}” deleted";

  static String m58(count) =>
      "${Intl.plural(count, one: 'Yesterday', other: '${count} days ago')}";

  static String m59(count) => "${count} h ago";

  static String m60(count) => "${count} min ago";

  static String m61(version) => "Version ${version} is available";

  static String m62(count) => "${count} verified";

  static String m63(version) => "Version ${version}";

  static String m64(points, level) => "${points} XP to level ${level}";

  static String m65(points) => "${points} XP";

  static String m66(name) => "${name} (you)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountSubtitle": MessageLookupByLibrary.simpleMessage(
          "Sign-in details. Your name, photo and cover are in Profile.",
        ),
        "achievementDetailTitle": MessageLookupByLibrary.simpleMessage(
          "Achievement",
        ),
        "achievementNamePlaceholder": MessageLookupByLibrary.simpleMessage(
          "Achievement name",
        ),
        "achievementsCount": m0,
        "achievementsEmptyBody": MessageLookupByLibrary.simpleMessage(
          "Ask for a verified achievement from your company\'s catalog, or recognize a colleague\'s work: it\'s often the best way to start.",
        ),
        "achievementsEmptyTitle": MessageLookupByLibrary.simpleMessage(
          "Your first achievement is waiting",
        ),
        "achievementsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Every milestone you unlocked along the way",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage(
          "Your achievements",
        ),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "That didn\'t work. Try again.",
        ),
        "alreadyHasIt": MessageLookupByLibrary.simpleMessage("Already has it"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Already sent to this colleague",
        ),
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Choose how Scoreboard looks",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Approve"),
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archived"),
        "assignButton": m1,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "A message for the recipients",
        ),
        "assignNoteLabel":
            MessageLookupByLibrary.simpleMessage("Note (optional)"),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Join your company\'s scoreboard.",
        ),
        "authCreateTitle": MessageLookupByLibrary.simpleMessage(
          "Create your account",
        ),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Collect the achievements your company issues, and recognize the colleagues who make a difference.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Sign in to see your achievements.",
        ),
        "authTagline": MessageLookupByLibrary.simpleMessage(
          "Every win,\non the record.",
        ),
        "authWelcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back"),
        "bannerClay": MessageLookupByLibrary.simpleMessage("Clay"),
        "bannerForest": MessageLookupByLibrary.simpleMessage("Forest"),
        "bannerGold": MessageLookupByLibrary.simpleMessage("Gold"),
        "bannerGraphite": MessageLookupByLibrary.simpleMessage("Graphite"),
        "bannerOcean": MessageLookupByLibrary.simpleMessage("Ocean"),
        "bannerSand": MessageLookupByLibrary.simpleMessage("Sand"),
        "baseExplanation": m2,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Create achievements and send them to your colleagues",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "A line about you and what you do",
        ),
        "budgetRemaining": m3,
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Base achievement",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Flip card"),
        "cardFrom": m4,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("ISSUED BY"),
        "cardIssuedOn": m5,
        "cardReceivedOn": m6,
        "cardSentBy": MessageLookupByLibrary.simpleMessage("SENT BY"),
        "cardVerifiedAchievement": MessageLookupByLibrary.simpleMessage(
          "Verified achievement",
        ),
        "catalogDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Only admins can issue it, and it shows as verified to whoever receives it.",
        ),
        "catalogEmpty": MessageLookupByLibrary.simpleMessage(
          "The catalog is empty. Create the first achievement.",
        ),
        "catalogPointsHint": MessageLookupByLibrary.simpleMessage(
          "The value sets the tier: Bronze below 100 XP, Silver from 100, Gold from 120, Platinum from 140.",
        ),
        "catalogSaved": MessageLookupByLibrary.simpleMessage("Catalog updated"),
        "certCredentialId": m7,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "has earned the achievement",
        ),
        "certIssuedBy": m8,
        "certPresentedTo": MessageLookupByLibrary.simpleMessage(
          "This certifies that",
        ),
        "certTitle": MessageLookupByLibrary.simpleMessage(
          "CERTIFICATE OF ACHIEVEMENT",
        ),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Check for updates",
        ),
        "chooseCompany": MessageLookupByLibrary.simpleMessage(
          "Choose your company",
        ),
        "commentHint": MessageLookupByLibrary.simpleMessage("Write a comment…"),
        "commentsCount": m9,
        "commonBack": MessageLookupByLibrary.simpleMessage("Back"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "commonClose": MessageLookupByLibrary.simpleMessage("Close"),
        "commonCreate": MessageLookupByLibrary.simpleMessage("Create"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "commonPreview": MessageLookupByLibrary.simpleMessage("PREVIEW"),
        "commonRemove": MessageLookupByLibrary.simpleMessage("Remove"),
        "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
        "commonSave": MessageLookupByLibrary.simpleMessage("Save"),
        "commonSend": MessageLookupByLibrary.simpleMessage("Send"),
        "communityCompanies": MessageLookupByLibrary.simpleMessage("Companies"),
        "communityHiddenNotice": MessageLookupByLibrary.simpleMessage(
          "You don\'t appear in this leaderboard. You can change that in Settings → Account.",
        ),
        "communityPeople": MessageLookupByLibrary.simpleMessage("People"),
        "communitySubtitle": MessageLookupByLibrary.simpleMessage(
          "See how you rank against everyone else",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Community"),
        "companyCatalog":
            MessageLookupByLibrary.simpleMessage("Company catalog"),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "The verified achievements you can earn. If you think you deserve one, ask for it.",
        ),
        "companySince": m10,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Confirm new password",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Assign"),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catalog"),
        "consoleRequests": m11,
        "consoleStats": MessageLookupByLibrary.simpleMessage("Insights"),
        "consoleSubtitle": m12,
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Anyone in your company can send it to a colleague.",
        ),
        "createdBy": m13,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Created by you"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Enter your current password",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Decided"),
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "It will be removed from the library. Colleagues who already received it keep their achievement.",
        ),
        "deleteTemplateTitle": m14,
        "demoAccount": m15,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "What does someone do to deserve it?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Add a short description",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Company"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Earned on"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Experience"),
        "detailId": m16,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Sent by"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Tier"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Earned"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Edit achievement",
        ),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save your email. Try again.",
        ),
        "emailUpdated": MessageLookupByLibrary.simpleMessage("Email updated"),
        "emptyOpenCatalog": MessageLookupByLibrary.simpleMessage(
          "Open the catalog",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "You already have this achievement.",
        ),
        "errorAlreadySent": m17,
        "errorBudgetExhausted": m18,
        "errorCatalogPoints": m19,
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "An account with this email already exists.",
        ),
        "errorInvalidPoints": m20,
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Enter your email and password.",
        ),
        "errorMissingFields": MessageLookupByLibrary.simpleMessage(
          "Fill in all the required fields.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Enter your name and role.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "You can only send achievements to colleagues of your company.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Only company admins can do that.",
        ),
        "errorNotFound": MessageLookupByLibrary.simpleMessage("Not found."),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "You are not signed in.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "You can only delete base achievements you created.",
        ),
        "errorPasswordTooShort": m21,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "You already have a pending request for this achievement.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "This base achievement no longer exists.",
        ),
        "errorWrongCredentials": MessageLookupByLibrary.simpleMessage(
          "Wrong email or password.",
        ),
        "errorWrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
          "The current password is wrong.",
        ),
        "evidenceLink": MessageLookupByLibrary.simpleMessage("Open evidence"),
        "evidenceUrlLabel": MessageLookupByLibrary.simpleMessage(
          "Link to evidence (optional)",
        ),
        "experienceNote": MessageLookupByLibrary.simpleMessage(
          "Base achievements are worth less than the verified ones issued by your company.",
        ),
        "exportError": MessageLookupByLibrary.simpleMessage(
          "Could not save the file. Try again.",
        ),
        "exportMenu": MessageLookupByLibrary.simpleMessage("Export"),
        "exportOpenBadge": MessageLookupByLibrary.simpleMessage(
          "Open Badge (JSON)",
        ),
        "exportOpenBadgeHint": MessageLookupByLibrary.simpleMessage(
          "Open Badges 3.0 credential. The digital signature will come with the backend.",
        ),
        "exportPdf": MessageLookupByLibrary.simpleMessage("PDF certificate"),
        "exportSaved": MessageLookupByLibrary.simpleMessage("File saved"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("earned"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Nothing on the feed yet.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "Your colleagues\' achievements, celebrated together",
        ),
        "feedTitle": MessageLookupByLibrary.simpleMessage("Company feed"),
        "fieldAchievement": MessageLookupByLibrary.simpleMessage("Achievement"),
        "fieldBio": MessageLookupByLibrary.simpleMessage("Bio"),
        "fieldColleague": MessageLookupByLibrary.simpleMessage("Colleague"),
        "fieldCover": MessageLookupByLibrary.simpleMessage("Cover"),
        "fieldDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "fieldEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "fieldExperience": MessageLookupByLibrary.simpleMessage("Experience"),
        "fieldFullName": MessageLookupByLibrary.simpleMessage("Full name"),
        "fieldIcon": MessageLookupByLibrary.simpleMessage("Icon"),
        "fieldMessageOptional": MessageLookupByLibrary.simpleMessage(
          "Message (optional)",
        ),
        "fieldName": MessageLookupByLibrary.simpleMessage("Name"),
        "fieldPhoto": MessageLookupByLibrary.simpleMessage("Photo"),
        "fieldRole": MessageLookupByLibrary.simpleMessage("Role"),
        "filterAll": m22,
        "filterTier": m23,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Click the card to flip it",
        ),
        "fromAColleague":
            MessageLookupByLibrary.simpleMessage("From a colleague"),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Something went wrong. Try again.",
        ),
        "hidePassword": MessageLookupByLibrary.simpleMessage("Hide password"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Enter a valid email address",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Enter a valid http(s) link",
        ),
        "issuedCount": m24,
        "issuedTimes": m25,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verified"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("System"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Language"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Leaderboard"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Peer"),
        "levelAndXp": m26,
        "levelN": m27,
        "libraryCount": m28,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "No base achievements yet. Create the first!",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Something went wrong while loading data.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
        "memberSince": m29,
        "membersCount": m30,
        "menuLabel": MessageLookupByLibrary.simpleMessage("MENU"),
        "messageHint": MessageLookupByLibrary.simpleMessage(
          "Tell them why they deserve it",
        ),
        "myRequests": MessageLookupByLibrary.simpleMessage("Your requests"),
        "nameHint": MessageLookupByLibrary.simpleMessage("e.g. Team Player"),
        "nameRequired": MessageLookupByLibrary.simpleMessage("Enter your name"),
        "navAchievements": MessageLookupByLibrary.simpleMessage("Achievements"),
        "navBaseAchievements": MessageLookupByLibrary.simpleMessage(
          "Base achievements",
        ),
        "navCommunity": MessageLookupByLibrary.simpleMessage("Community"),
        "navConsole": MessageLookupByLibrary.simpleMessage("Company console"),
        "navFeed": MessageLookupByLibrary.simpleMessage("Feed"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "navYourCompany": MessageLookupByLibrary.simpleMessage("Your company"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "New base achievement",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "New verified achievement",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "No achievements in this tier yet.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "No achievements yet.",
        ),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "No results match your search.",
        ),
        "noteAuthorFallback":
            MessageLookupByLibrary.simpleMessage("A colleague"),
        "notifApprovedBody": m31,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Request approved",
        ),
        "notifCommentBody": m32,
        "notifCommentTitle":
            MessageLookupByLibrary.simpleMessage("New comment"),
        "notifLevelUpBody": m33,
        "notifLevelUpTitle": MessageLookupByLibrary.simpleMessage("Level up!"),
        "notifNewRequestBody": m34,
        "notifNewRequestTitle":
            MessageLookupByLibrary.simpleMessage("New request"),
        "notifPeerBody": m35,
        "notifPeerTitle":
            MessageLookupByLibrary.simpleMessage("New achievement"),
        "notifReactionBody": m36,
        "notifReactionTitle":
            MessageLookupByLibrary.simpleMessage("New reaction"),
        "notifRecapBody": m37,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Your weekly recap",
        ),
        "notifRejectedBody": m38,
        "notifRejectedBodyReason": m39,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Request rejected",
        ),
        "notifVerifiedBody": m40,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Verified achievement",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "No notifications yet.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Open notifications",
        ),
        "notificationsTitle":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Get started"),
        "onboardingFastBody": m41,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Move fast"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "The feed shows your colleagues\' achievements, so you can react and comment. Notifications tell you when something involves you.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Celebrate together",
        ),
        "onboardingKindsBody": m42,
        "onboardingKindsTitle": MessageLookupByLibrary.simpleMessage(
          "Verified and peer achievements",
        ),
        "onboardingNext": MessageLookupByLibrary.simpleMessage("Next"),
        "onboardingReplay": MessageLookupByLibrary.simpleMessage(
          "Replay the introduction",
        ),
        "onboardingSkip": MessageLookupByLibrary.simpleMessage("Skip"),
        "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
          "Here you collect the achievements you earn at work, as cards. Hover over them, and flip them to see who issued them.",
        ),
        "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
          "Welcome to Scoreboard",
        ),
        "passwordChangeError": MessageLookupByLibrary.simpleMessage(
          "Could not change your password. Try again.",
        ),
        "passwordChanged":
            MessageLookupByLibrary.simpleMessage("Password changed"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMinLength": m43,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Enter your password",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Passwords don\'t match",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("Pending"),
        "percentValue": m44,
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Pick an achievement from the catalog.",
        ),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Your colleagues still see you in the team leaderboard.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "Show me in the Community leaderboard",
        ),
        "privacySection": MessageLookupByLibrary.simpleMessage("Privacy"),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save your profile. Try again.",
        ),
        "profileUpdated":
            MessageLookupByLibrary.simpleMessage("Profile updated"),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Hidden"),
        "rankValue": m45,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Celebrate"),
        "reactionInsightful":
            MessageLookupByLibrary.simpleMessage("Insightful"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Like"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Love"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Recent achievements",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Reject"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Reject the request?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Reason (optional)",
        ),
        "rejectionReason": m46,
        "replaceImage": MessageLookupByLibrary.simpleMessage("Replace image"),
        "requestAction": MessageLookupByLibrary.simpleMessage("Request"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Request approved",
        ),
        "requestDialogSubtitle": m47,
        "requestDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Request an achievement",
        ),
        "requestMessage": MessageLookupByLibrary.simpleMessage("Message"),
        "requestMessageHint": MessageLookupByLibrary.simpleMessage(
          "What did you do to deserve it?",
        ),
        "requestMessageRequired": MessageLookupByLibrary.simpleMessage(
          "Write a message",
        ),
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Request rejected",
        ),
        "requestSent": MessageLookupByLibrary.simpleMessage("Request sent"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage("No requests."),
        "restore": MessageLookupByLibrary.simpleMessage("Restore"),
        "roleAtCompany": m48,
        "roleRequired": MessageLookupByLibrary.simpleMessage("Enter your role"),
        "saveProfile": MessageLookupByLibrary.simpleMessage("Save profile"),
        "searchAchievementsHint": MessageLookupByLibrary.simpleMessage(
          "Search your achievements",
        ),
        "searchCompaniesHint": MessageLookupByLibrary.simpleMessage(
          "Search by name or industry",
        ),
        "searchPeopleHint": MessageLookupByLibrary.simpleMessage(
          "Search by name, role or company",
        ),
        "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
        "sendAchievement":
            MessageLookupByLibrary.simpleMessage("Send achievement"),
        "sendAnAchievement": MessageLookupByLibrary.simpleMessage(
          "Send an achievement",
        ),
        "sendDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Recognize a colleague with one of your base achievements.",
        ),
        "sendError": MessageLookupByLibrary.simpleMessage(
          "Could not send the achievement. Try again.",
        ),
        "sendLoadError": MessageLookupByLibrary.simpleMessage(
          "Could not load your colleagues. Try again.",
        ),
        "sendNoColleagues": MessageLookupByLibrary.simpleMessage(
          "There are no colleagues in your company yet.",
        ),
        "sendNoTemplates": MessageLookupByLibrary.simpleMessage(
          "Create a base achievement first.",
        ),
        "sendPreviewHint": MessageLookupByLibrary.simpleMessage(
          "Pick an achievement to see how it will look.",
        ),
        "sendSuccess": m49,
        "sentByYouCount": m50,
        "sentCount": m51,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "You haven\'t sent any achievement yet. Pick one from the library and make a colleague\'s day.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("to"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Session"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("About"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
        "settingsAppearance":
            MessageLookupByLibrary.simpleMessage("Appearance"),
        "shareAddToProfile":
            MessageLookupByLibrary.simpleMessage("Add to profile"),
        "shareAddToProfileHint": m52,
        "shareCopyText": MessageLookupByLibrary.simpleMessage("Copy text"),
        "shareDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Post about it, or add it to your LinkedIn profile.",
        ),
        "shareImageHeadline": MessageLookupByLibrary.simpleMessage(
          "ACHIEVEMENT UNLOCKED",
        ),
        "shareImageHint": MessageLookupByLibrary.simpleMessage(
          "LinkedIn links can\'t attach images: save this one and add it to your post.",
        ),
        "shareImageIssuedBy": m53,
        "shareImageSaved": MessageLookupByLibrary.simpleMessage("Image saved"),
        "shareOnLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Share on LinkedIn",
        ),
        "shareOpenError": MessageLookupByLibrary.simpleMessage(
          "Could not open LinkedIn.",
        ),
        "shareOpenLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Post on LinkedIn",
        ),
        "shareOpened": MessageLookupByLibrary.simpleMessage(
          "Text copied: if LinkedIn doesn\'t fill it in, paste it into the post.",
        ),
        "sharePostLabel": MessageLookupByLibrary.simpleMessage("Post text"),
        "sharePostPeer": m54,
        "sharePostVerified": m55,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save the image. Try again.",
        ),
        "shareSaveImage": MessageLookupByLibrary.simpleMessage("Save image"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Text copied to the clipboard",
        ),
        "shortcutGoToPage":
            MessageLookupByLibrary.simpleMessage("Go to page 1–8"),
        "shortcutsSection": MessageLookupByLibrary.simpleMessage(
          "Keyboard shortcuts",
        ),
        "showArchived": MessageLookupByLibrary.simpleMessage("Show archived"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signOut": MessageLookupByLibrary.simpleMessage("Sign out"),
        "signOutDescription": MessageLookupByLibrary.simpleMessage(
          "Sign out of Scoreboard on this computer.",
        ),
        "signOutError": MessageLookupByLibrary.simpleMessage(
          "Could not sign out. Try again.",
        ),
        "sortLabel": MessageLookupByLibrary.simpleMessage("Sort"),
        "sortName": MessageLookupByLibrary.simpleMessage("Name (A–Z)"),
        "sortNewest": MessageLookupByLibrary.simpleMessage("Newest"),
        "sortOldest": MessageLookupByLibrary.simpleMessage("Oldest"),
        "sortPoints": MessageLookupByLibrary.simpleMessage("Most XP"),
        "statAchievements":
            MessageLookupByLibrary.simpleMessage("Achievements"),
        "statCompanyRank": MessageLookupByLibrary.simpleMessage("Company rank"),
        "statGlobalRank": MessageLookupByLibrary.simpleMessage("Global rank"),
        "statMembers": MessageLookupByLibrary.simpleMessage("Members"),
        "statTotalXp": MessageLookupByLibrary.simpleMessage("Total XP"),
        "statVerified": MessageLookupByLibrary.simpleMessage("Verified"),
        "statYourRank": MessageLookupByLibrary.simpleMessage("Your rank"),
        "statsActiveSenders": MessageLookupByLibrary.simpleMessage(
          "People recognizing others",
        ),
        "statsCoverage": MessageLookupByLibrary.simpleMessage(
          "Recognized in the last 30 days",
        ),
        "statsIssuedThisMonth": MessageLookupByLibrary.simpleMessage(
          "Verified this month",
        ),
        "statsMonthlyChart": MessageLookupByLibrary.simpleMessage(
          "Achievements in the last 6 months",
        ),
        "statsNoData": MessageLookupByLibrary.simpleMessage("No data yet."),
        "statsPeerThisMonth": MessageLookupByLibrary.simpleMessage(
          "Peer this month",
        ),
        "statsTopCatalog": MessageLookupByLibrary.simpleMessage("Most issued"),
        "statsTopSenders":
            MessageLookupByLibrary.simpleMessage("Top recognizers"),
        "statsTopSendersHint": MessageLookupByLibrary.simpleMessage(
          "Base achievements sent in the last 90 days.",
        ),
        "statsUnderRecognized": MessageLookupByLibrary.simpleMessage(
          "Could use some recognition",
        ),
        "statsUnderRecognizedHint": MessageLookupByLibrary.simpleMessage(
          "Who received the fewest achievements in the last 90 days.",
        ),
        "statusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
        "statusPending": MessageLookupByLibrary.simpleMessage("Pending"),
        "statusRejected": MessageLookupByLibrary.simpleMessage("Rejected"),
        "submitRequest": MessageLookupByLibrary.simpleMessage("Send request"),
        "teamLeaderboard":
            MessageLookupByLibrary.simpleMessage("Team leaderboard"),
        "templateAdded": m56,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Could not create the achievement. Try again.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Could not delete the achievement. Try again.",
        ),
        "templateDeleted": m57,
        "templateNameRequired": MessageLookupByLibrary.simpleMessage(
          "Give it a name",
        ),
        "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
        "themeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
        "tierBronze": MessageLookupByLibrary.simpleMessage("Bronze"),
        "tierGold": MessageLookupByLibrary.simpleMessage("Gold"),
        "tierPeer": MessageLookupByLibrary.simpleMessage("Peer"),
        "tierPlatinum": MessageLookupByLibrary.simpleMessage("Platinum"),
        "tierSilver": MessageLookupByLibrary.simpleMessage("Silver"),
        "timeDays": m58,
        "timeHours": m59,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Just now"),
        "timeMinutes": m60,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("Top performers"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Open Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Quit Scoreboard"),
        "upToDate": MessageLookupByLibrary.simpleMessage("You\'re up to date."),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Download it from the release page on GitHub.",
        ),
        "updateAvailableTitle": m61,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "Couldn\'t check for updates.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Download"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Later"),
        "updatesSection": MessageLookupByLibrary.simpleMessage("Updates"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Upload image"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Upload photo"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Use it"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Verified by the company",
        ),
        "verifiedCount": m62,
        "versionLabel": m63,
        "workEmail": MessageLookupByLibrary.simpleMessage("Work email"),
        "xpToNextLevel": m64,
        "xpValue": m65,
        "youSuffix": m66,
      };
}
