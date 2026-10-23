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

  static String m1(maxPoints) =>
      "Base achievements are sent between colleagues and are worth up to ${maxPoints} XP. Verified achievements are issued only by your company. You can send each base achievement to the same colleague once.";

  static String m2(name) => "From ${name}";

  static String m3(date) => "Issued on ${date}";

  static String m4(date) => "Received on ${date}";

  static String m5(year) => "Since ${year}";

  static String m6(name) => "By ${name}";

  static String m7(name) => "Delete “${name}”?";

  static String m8(email, password) => "Demo account: ${email} / ${password}";

  static String m9(id) => "ID ${id}";

  static String m10(template, colleague) =>
      "You already sent “${template}” to ${colleague}.";

  static String m11(values) => "Base achievements can be worth ${values} XP.";

  static String m12(min) => "The password must be at least ${min} characters.";

  static String m13(count) => "All · ${count}";

  static String m14(tier, count) => "${tier} · ${count}";

  static String m15(level, points) => "Level ${level} · ${points} XP";

  static String m16(level) => "Level ${level}";

  static String m17(count) => "Library · ${count}";

  static String m18(date) => "Member since ${date}";

  static String m19(count) =>
      "${Intl.plural(count, one: '1 member', other: '${count} members')}";

  static String m20(min) => "At least ${min} characters";

  static String m21(rank) => "#${rank}";

  static String m22(role, company) => "${role} at ${company}";

  static String m23(name) => "Achievement sent to ${name}";

  static String m24(count) => "Sent by you · ${count}";

  static String m25(company) =>
      "Adds it to Licenses & certifications, with ${company} as the issuer.";

  static String m26(company) => "Issued by ${company}";

  static String m27(sender, name, description) =>
      "🤝 ${sender} recognized me with the “${name}” achievement.\n\n${description}\n\n#Scoreboard";

  static String m28(name, company, description) =>
      "🏆 I just earned the “${name}” achievement, issued by ${company}.\n\n${description}\n\n#Scoreboard";

  static String m29(name) => "“${name}” added to the library";

  static String m30(name) => "“${name}” deleted";

  static String m31(count) => "${count} verified";

  static String m32(version) => "Version ${version}";

  static String m33(points, level) => "${points} XP to level ${level}";

  static String m34(points) => "${points} XP";

  static String m35(name) => "${name} (you)";

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
        "achievementsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Every milestone you unlocked along the way",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage(
          "Your achievements",
        ),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Already sent to this colleague",
        ),
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Choose how Scoreboard looks",
        ),
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
        "baseExplanation": m1,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Create achievements and send them to your colleagues",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "A line about you and what you do",
        ),
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Base achievement",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Flip card"),
        "cardFrom": m2,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("ISSUED BY"),
        "cardIssuedOn": m3,
        "cardReceivedOn": m4,
        "cardSentBy": MessageLookupByLibrary.simpleMessage("SENT BY"),
        "cardVerifiedAchievement": MessageLookupByLibrary.simpleMessage(
          "Verified achievement",
        ),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "chooseCompany": MessageLookupByLibrary.simpleMessage(
          "Choose your company",
        ),
        "commonBack": MessageLookupByLibrary.simpleMessage("Back"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "commonClose": MessageLookupByLibrary.simpleMessage("Close"),
        "commonCreate": MessageLookupByLibrary.simpleMessage("Create"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "commonPreview": MessageLookupByLibrary.simpleMessage("PREVIEW"),
        "commonRemove": MessageLookupByLibrary.simpleMessage("Remove"),
        "commonRetry": MessageLookupByLibrary.simpleMessage("Retry"),
        "commonSave": MessageLookupByLibrary.simpleMessage("Save"),
        "commonSend": MessageLookupByLibrary.simpleMessage("Send"),
        "communityCompanies": MessageLookupByLibrary.simpleMessage("Companies"),
        "communityPeople": MessageLookupByLibrary.simpleMessage("People"),
        "communitySubtitle": MessageLookupByLibrary.simpleMessage(
          "See how you rank against everyone else",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Community"),
        "companySince": m5,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Confirm new password",
        ),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Anyone in your company can send it to a colleague.",
        ),
        "createdBy": m6,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Created by you"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Enter your current password",
        ),
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "It will be removed from the library. Colleagues who already received it keep their achievement.",
        ),
        "deleteTemplateTitle": m7,
        "demoAccount": m8,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "What does someone do to deserve it?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Add a short description",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Company"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Earned on"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Experience"),
        "detailId": m9,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Sent by"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Tier"),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save your email. Try again.",
        ),
        "emailUpdated": MessageLookupByLibrary.simpleMessage("Email updated"),
        "errorAlreadySent": m10,
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "An account with this email already exists.",
        ),
        "errorInvalidPoints": m11,
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Enter your email and password.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Enter your name and role.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "You can only send achievements to colleagues of your company.",
        ),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "You are not signed in.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "You can only delete base achievements you created.",
        ),
        "errorPasswordTooShort": m12,
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "This base achievement no longer exists.",
        ),
        "errorWrongCredentials": MessageLookupByLibrary.simpleMessage(
          "Wrong email or password.",
        ),
        "errorWrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
          "The current password is wrong.",
        ),
        "experienceNote": MessageLookupByLibrary.simpleMessage(
          "Base achievements are worth less than the verified ones issued by your company.",
        ),
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
        "filterAll": m13,
        "filterTier": m14,
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
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verified"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("System"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Language"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Leaderboard"),
        "levelAndXp": m15,
        "levelN": m16,
        "libraryCount": m17,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "No base achievements yet. Create the first!",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Something went wrong while loading data.",
        ),
        "memberSince": m18,
        "membersCount": m19,
        "menuLabel": MessageLookupByLibrary.simpleMessage("MENU"),
        "messageHint": MessageLookupByLibrary.simpleMessage(
          "Tell them why they deserve it",
        ),
        "nameHint": MessageLookupByLibrary.simpleMessage("e.g. Team Player"),
        "nameRequired": MessageLookupByLibrary.simpleMessage("Enter your name"),
        "navAchievements": MessageLookupByLibrary.simpleMessage("Achievements"),
        "navBaseAchievements": MessageLookupByLibrary.simpleMessage(
          "Base achievements",
        ),
        "navCommunity": MessageLookupByLibrary.simpleMessage("Community"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "navYourCompany": MessageLookupByLibrary.simpleMessage("Your company"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "New base achievement",
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
        "passwordChangeError": MessageLookupByLibrary.simpleMessage(
          "Could not change your password. Try again.",
        ),
        "passwordChanged":
            MessageLookupByLibrary.simpleMessage("Password changed"),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMinLength": m20,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Enter your password",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Passwords don\'t match",
        ),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save your profile. Try again.",
        ),
        "profileUpdated":
            MessageLookupByLibrary.simpleMessage("Profile updated"),
        "rankValue": m21,
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Recent achievements",
        ),
        "replaceImage": MessageLookupByLibrary.simpleMessage("Replace image"),
        "roleAtCompany": m22,
        "roleRequired": MessageLookupByLibrary.simpleMessage("Enter your role"),
        "saveProfile": MessageLookupByLibrary.simpleMessage("Save profile"),
        "searchCompaniesHint": MessageLookupByLibrary.simpleMessage(
          "Search by name or industry",
        ),
        "searchPeopleHint": MessageLookupByLibrary.simpleMessage(
          "Search by name, role or company",
        ),
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
        "sendSuccess": m23,
        "sentByYouCount": m24,
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
        "shareAddToProfileHint": m25,
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
        "shareImageIssuedBy": m26,
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
        "sharePostPeer": m27,
        "sharePostVerified": m28,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save the image. Try again.",
        ),
        "shareSaveImage": MessageLookupByLibrary.simpleMessage("Save image"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Text copied to the clipboard",
        ),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show password"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signOut": MessageLookupByLibrary.simpleMessage("Sign out"),
        "signOutDescription": MessageLookupByLibrary.simpleMessage(
          "Sign out of Scoreboard on this computer.",
        ),
        "signOutError": MessageLookupByLibrary.simpleMessage(
          "Could not sign out. Try again.",
        ),
        "statAchievements":
            MessageLookupByLibrary.simpleMessage("Achievements"),
        "statCompanyRank": MessageLookupByLibrary.simpleMessage("Company rank"),
        "statGlobalRank": MessageLookupByLibrary.simpleMessage("Global rank"),
        "statMembers": MessageLookupByLibrary.simpleMessage("Members"),
        "statTotalXp": MessageLookupByLibrary.simpleMessage("Total XP"),
        "statVerified": MessageLookupByLibrary.simpleMessage("Verified"),
        "statYourRank": MessageLookupByLibrary.simpleMessage("Your rank"),
        "teamLeaderboard":
            MessageLookupByLibrary.simpleMessage("Team leaderboard"),
        "templateAdded": m29,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Could not create the achievement. Try again.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Could not delete the achievement. Try again.",
        ),
        "templateDeleted": m30,
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
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("Top performers"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Upload image"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Upload photo"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Use it"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Verified by the company",
        ),
        "verifiedCount": m31,
        "versionLabel": m32,
        "workEmail": MessageLookupByLibrary.simpleMessage("Work email"),
        "xpToNextLevel": m33,
        "xpValue": m34,
        "youSuffix": m35,
      };
}
