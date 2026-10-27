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

  static String m1(count, subject) =>
      "${Intl.plural(count, one: 'issued “${subject}” to 1 person', other: 'issued “${subject}” to ${count} people')}";

  static String m2(subject) => "made ${subject} an admin";

  static String m3(subject) => "removed ${subject}\'s admin rights";

  static String m4(subject) => "archived “${subject}”";

  static String m5(subject) => "added “${subject}” to the catalog";

  static String m6(subject) => "restored “${subject}”";

  static String m7(subject) => "edited “${subject}”";

  static String m8(subject) => "revoked the invitation for ${subject}";

  static String m9(subject) => "invited ${subject}";

  static String m10(subject, target) => "moved ${subject} to ${target}";

  static String m11(subject) => "took ${subject} out of their team";

  static String m12(subject, target) => "proposed “${subject}” for ${target}";

  static String m13(target) => "exported the personal data of ${target}";

  static String m14(target) => "exported the achievements report (${target})";

  static String m15(target) => "exported the people report (${target})";

  static String m16(subject, target) => "approved “${subject}” for ${target}";

  static String m17(subject, target) => "rejected “${subject}” for ${target}";

  static String m18(subject) => "created the season ${subject}";

  static String m19(subject) => "deleted the season ${subject}";

  static String m20(subject) => "edited the season ${subject}";

  static String m21(subject) => "created the team ${subject}";

  static String m22(subject) => "deleted the team ${subject}";

  static String m23(subject) => "edited the team ${subject}";

  static String m24(company) => "Admin · ${company}";

  static String m25(name) => "${name} is now an admin";

  static String m26(name) => "${name} is no longer an admin";

  static String m27(points) => "${points} XP";

  static String m28(years) =>
      "${Intl.plural(years, one: '1 year', other: '${years} years')}";

  static String m29(count) =>
      "${Intl.plural(count, zero: 'Assign', one: 'Assign to 1 person', other: 'Assign to ${count} people')}";

  static String m30(maxPoints) =>
      "Base achievements are sent between colleagues and are worth up to ${maxPoints} XP. Verified achievements are issued only by your company. You can send each base achievement to the same colleague once.";

  static String m31(company) =>
      "Your color and logo replace Scoreboard\'s gold for everyone at ${company}. The color is adjusted so text stays readable.";

  static String m32(remaining, budget) =>
      "${remaining} of ${budget} sends left this month";

  static String m33(name) => "From ${name}";

  static String m34(date) => "Issued on ${date}";

  static String m35(date) => "Received on ${date}";

  static String m36(id) => "Credential ID: ${id}";

  static String m37(company, date) => "Issued by ${company} on ${date}";

  static String m38(count) =>
      "${Intl.plural(count, zero: 'Comment', one: '1 comment', other: '${count} comments')}";

  static String m39(year) => "Since ${year}";

  static String m40(company) =>
      "The verified achievements ${company} can issue. Click a card to edit it.";

  static String m41(company) =>
      "How ${company} looks and celebrates in Scoreboard";

  static String m42(company) =>
      "How recognition flows at ${company}, and where it gets stuck.";

  static String m43(count) => "Requests · ${count}";

  static String m44(name) => "By ${name}";

  static String m45(name) => "Delete ${name}?";

  static String m46(name) => "Delete ${name}?";

  static String m47(name) => "Delete “${name}”?";

  static String m48(email, password) => "Demo account: ${email} / ${password}";

  static String m49(id) => "ID ${id}";

  static String m50(template, colleague) =>
      "You already sent “${template}” to ${colleague}.";

  static String m51(budget) =>
      "You\'ve sent all ${budget} achievements for this month. The budget resets on the 1st.";

  static String m52(min, max) =>
      "The value must be between ${min} and ${max} XP.";

  static String m53(values) => "Base achievements can be worth ${values} XP.";

  static String m54(min) => "The password must be at least ${min} characters.";

  static String m55(count) => "All · ${count}";

  static String m56(tier, count) => "${tier} · ${count}";

  static String m57(code) => "Code ${code}";

  static String m58(name, date) => "Invited by ${name} · expires ${date}";

  static String m59(company) =>
      "They\'ll get a code by email to join ${company}. The code is valid for 7 days.";

  static String m60(email) => "Revoke the invitation for ${email}?";

  static String m61(email) => "Invitation sent to ${email}";

  static String m62(email, code) =>
      "Demo mode, no email sent: give ${email} the code ${code}";

  static String m63(count) =>
      "${Intl.plural(count, one: 'Issued to 1 person', other: 'Issued to ${count} people')}";

  static String m64(count) =>
      "${Intl.plural(count, one: 'once', other: '${count} times')}";

  static String m65(level, points) => "Level ${level} · ${points} XP";

  static String m66(level) => "Level ${level}";

  static String m67(count) => "Library · ${count}";

  static String m68(date) => "Member since ${date}";

  static String m69(name) => "Team of ${name}";

  static String m70(count) =>
      "${Intl.plural(count, one: '1 member', other: '${count} members')}";

  static String m71(name) => "For ${name}. An admin will review your proposal.";

  static String m72(achievement) =>
      "“${achievement}” was approved and is now in your achievements";

  static String m73(actor, achievement, text) =>
      "${actor} commented on “${achievement}”: ${text}";

  static String m74(level) => "You reached level ${level}";

  static String m75(actor, achievement) =>
      "${actor} requested “${achievement}”";

  static String m76(actor, achievement, member) =>
      "${actor} proposed “${achievement}” for ${member}";

  static String m77(actor, achievement) => "${actor} sent you “${achievement}”";

  static String m78(actor, achievement) =>
      "${actor} reacted to “${achievement}”";

  static String m79(xp, rank) => "This week: +${xp} XP · rank #${rank}";

  static String m80(achievement) => "“${achievement}” wasn\'t approved";

  static String m81(achievement, reason) =>
      "“${achievement}” wasn\'t approved: ${reason}";

  static String m82(company, achievement) =>
      "${company} issued you “${achievement}”";

  static String m83(count) =>
      "${Intl.plural(count, zero: 'No unread notifications', one: '1 unread notification', other: '${count} unread notifications')}";

  static String m84(shortcut) =>
      "Press ${shortcut} to send an achievement from anywhere, or use the menu bar icon.";

  static String m85(budget) =>
      "Verified achievements come from your company: you can ask for them from the catalog. Base achievements are exchanged between colleagues, up to ${budget} a month.";

  static String m86(min) => "At least ${min} characters";

  static String m87(percent) => "${percent}%";

  static String m88(rank) => "#${rank}";

  static String m89(reason) => "Reason: ${reason}";

  static String m90(company) =>
      "An admin at ${company} will review your request.";

  static String m91(name) => "Proposed by ${name}";

  static String m92(role, company) => "${role} at ${company}";

  static String m93(days) =>
      "${Intl.plural(days, one: '1 day left', other: '${days} days left')}";

  static String m94(start, end) => "${start} – ${end}";

  static String m95(rank, points) => "You\'re #${rank} with ${points} XP";

  static String m96(name) => "Achievement sent to ${name}";

  static String m97(count) => "Sent by you · ${count}";

  static String m98(count) => "${count} sent";

  static String m99(company) =>
      "Adds it to Licenses & certifications, with ${company} as the issuer.";

  static String m100(company) => "Issued by ${company}";

  static String m101(sender, name, description) =>
      "🤝 ${sender} recognized me with the “${name}” achievement.\n\n${description}\n\n#Scoreboard";

  static String m102(name, company, description) =>
      "🏆 I just earned the “${name}” achievement, issued by ${company}.\n\n${description}\n\n#Scoreboard";

  static String m103(time) => "Last recognized ${time}";

  static String m104(received, sent) =>
      "${received} received · ${sent} sent in 90 days";

  static String m105(name) => "“${name}” added to the library";

  static String m106(name) => "“${name}” deleted";

  static String m107(count) =>
      "${Intl.plural(count, one: 'Yesterday', other: '${count} days ago')}";

  static String m108(count) => "${count} h ago";

  static String m109(count) => "${count} min ago";

  static String m110(version) => "Version ${version} is available";

  static String m111(count) => "${count} verified";

  static String m112(version) => "Version ${version}";

  static String m113(points, level) => "${points} XP to level ${level}";

  static String m114(points) => "${points} XP";

  static String m115(name) => "${name} (you)";

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
          "The receipts for all that hard work",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage(
          "Your achievements",
        ),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "That didn\'t work. Try again.",
        ),
        "activityAchievementsIssued": m1,
        "activityAdminGranted": m2,
        "activityAdminRevoked": m3,
        "activityAnniversariesUpdated": MessageLookupByLibrary.simpleMessage(
          "changed the work anniversaries",
        ),
        "activityBrandUpdated": MessageLookupByLibrary.simpleMessage(
          "changed the company\'s color or logo",
        ),
        "activityCatalogArchived": m4,
        "activityCatalogCreated": m5,
        "activityCatalogRestored": m6,
        "activityCatalogUpdated": m7,
        "activityEmpty": MessageLookupByLibrary.simpleMessage(
          "Nothing recorded yet.",
        ),
        "activityHint": MessageLookupByLibrary.simpleMessage(
          "What admins and managers did, newest first. It can\'t be edited.",
        ),
        "activityInviteRevoked": m8,
        "activityMemberInvited": m9,
        "activityMemberMoved": m10,
        "activityMemberRemoved": m11,
        "activityNominationSubmitted": m12,
        "activityPersonalDataExported": m13,
        "activityReportAchievements": m14,
        "activityReportPeople": m15,
        "activityRequestApproved": m16,
        "activityRequestRejected": m17,
        "activitySeasonCreated": m18,
        "activitySeasonDeleted": m19,
        "activitySeasonUpdated": m20,
        "activityTeamCreated": m21,
        "activityTeamDeleted": m22,
        "activityTeamUpdated": m23,
        "adminBadge": m24,
        "adminGrantedMessage": m25,
        "adminGroupCompany": MessageLookupByLibrary.simpleMessage("COMPANY"),
        "adminGroupData": MessageLookupByLibrary.simpleMessage("DATA"),
        "adminGroupPeople": MessageLookupByLibrary.simpleMessage("PEOPLE"),
        "adminGroupRecognition": MessageLookupByLibrary.simpleMessage(
          "RECOGNITION",
        ),
        "adminMode": MessageLookupByLibrary.simpleMessage("Admin mode"),
        "adminModeHint": MessageLookupByLibrary.simpleMessage(
          "Manage your company\'s verified achievements",
        ),
        "adminRevokeSelfAction":
            MessageLookupByLibrary.simpleMessage("Give up"),
        "adminRevokeSelfBody": MessageLookupByLibrary.simpleMessage(
          "You\'ll leave the console and won\'t be able to manage the company. Another admin can give you these rights back.",
        ),
        "adminRevokeSelfTitle": MessageLookupByLibrary.simpleMessage(
          "Give up your admin rights?",
        ),
        "adminRevokedMessage": m26,
        "adminRole": MessageLookupByLibrary.simpleMessage("Admin"),
        "adminRoleTooltip": MessageLookupByLibrary.simpleMessage(
          "Can use the console and manage the company",
        ),
        "alreadyHasIt": MessageLookupByLibrary.simpleMessage("Already has it"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Already sent to this colleague",
        ),
        "anniversariesBody": MessageLookupByLibrary.simpleMessage(
          "A verified achievement on each work anniversary you celebrate, issued automatically.",
        ),
        "anniversariesEnabled": MessageLookupByLibrary.simpleMessage(
          "Celebrate work anniversaries",
        ),
        "anniversariesTitle": MessageLookupByLibrary.simpleMessage(
          "Work anniversaries",
        ),
        "anniversaryXp": m27,
        "anniversaryYears": m28,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Choose how Scoreboard looks",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Approve"),
        "archive": MessageLookupByLibrary.simpleMessage("Archive"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archived"),
        "assignButton": m29,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "A message for the recipients",
        ),
        "assignNoteLabel":
            MessageLookupByLibrary.simpleMessage("Note (optional)"),
        "authCreateCompanySubtitle": MessageLookupByLibrary.simpleMessage(
          "Set up Scoreboard for your company. You\'ll be its admin.",
        ),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Join your company\'s scoreboard.",
        ),
        "authCreateTitle": MessageLookupByLibrary.simpleMessage(
          "Create your account",
        ),
        "authJoinSubtitle": MessageLookupByLibrary.simpleMessage(
          "Use the invitation code you received by email.",
        ),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Collect the achievements your company issues, and recognize the colleagues who make a difference.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Your trophies missed you.",
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
        "baseExplanation": m30,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Small thank-yous, with XP attached",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "A line about you and what you do",
        ),
        "brandBody": m31,
        "brandColor": MessageLookupByLibrary.simpleMessage("Color"),
        "brandDefault": MessageLookupByLibrary.simpleMessage("Scoreboard gold"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Preview"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Brand"),
        "budgetRemaining": m32,
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Base achievement",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Flip card"),
        "cardFrom": m33,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("ISSUED BY"),
        "cardIssuedOn": m34,
        "cardReceivedOn": m35,
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
        "certCredentialId": m36,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "has earned the achievement",
        ),
        "certIssuedBy": m37,
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
        "commentHint": MessageLookupByLibrary.simpleMessage("Write a comment…"),
        "commentsCount": m38,
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
          "Everyone, everywhere, ranked. No pressure.",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Community"),
        "companyCatalog":
            MessageLookupByLibrary.simpleMessage("Company catalog"),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "The verified achievements you can earn. If you think you deserve one, ask for it.",
        ),
        "companyIndustryLabel": MessageLookupByLibrary.simpleMessage(
          "Industry (optional)",
        ),
        "companyLocationLabel": MessageLookupByLibrary.simpleMessage(
          "City (optional)",
        ),
        "companyNameLabel":
            MessageLookupByLibrary.simpleMessage("Company name"),
        "companyNameRequired": MessageLookupByLibrary.simpleMessage(
          "Enter the company\'s name",
        ),
        "companySince": m39,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Confirm new password",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage("Activity log"),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Assign"),
        "consoleAssignSubtitle": MessageLookupByLibrary.simpleMessage(
          "Pick an achievement, pick the people, make their day.",
        ),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catalog"),
        "consoleCatalogSubtitle": m40,
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Company"),
        "consoleCompanySubtitle": m41,
        "consoleInsightsSubtitle": m42,
        "consoleMembers": MessageLookupByLibrary.simpleMessage("Members"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Reports"),
        "consoleRequests": m43,
        "consoleRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
          "People asking for credit they believe they\'ve earned. You decide.",
        ),
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Seasons"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Insights"),
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Teams"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create account"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Anyone in your company can send it to a colleague.",
        ),
        "createdBy": m44,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Created by you"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Enter your current password",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Decided"),
        "deleteSeasonBody": MessageLookupByLibrary.simpleMessage(
          "Its leaderboard disappears. The achievements are kept.",
        ),
        "deleteSeasonTitle": m45,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "Its members will be left without a team. Their achievements are kept.",
        ),
        "deleteTeamTitle": m46,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "It will be removed from the library. Colleagues who already received it keep their achievement.",
        ),
        "deleteTemplateTitle": m47,
        "demoAccount": m48,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "What does someone do to deserve it?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Add a short description",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Company"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Earned on"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Experience"),
        "detailId": m49,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Sent by"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Tier"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Earned"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Edit achievement",
        ),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
        "editSeason": MessageLookupByLibrary.simpleMessage("Edit season"),
        "editTeam": MessageLookupByLibrary.simpleMessage("Edit team"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save your email. Try again.",
        ),
        "emailUpdated": MessageLookupByLibrary.simpleMessage("Email updated"),
        "emptyOpenCatalog": MessageLookupByLibrary.simpleMessage(
          "Open the catalog",
        ),
        "errorAlreadyMember": MessageLookupByLibrary.simpleMessage(
          "This person already has a Scoreboard account.",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "You already have this achievement.",
        ),
        "errorAlreadySent": m50,
        "errorBudgetExhausted": m51,
        "errorCatalogPoints": m52,
        "errorCompanyNameTaken": MessageLookupByLibrary.simpleMessage(
          "A company with this name is already on Scoreboard. Ask one of its admins to invite you.",
        ),
        "errorEmailNotSent": MessageLookupByLibrary.simpleMessage(
          "The invitation email couldn\'t be sent. Try again later.",
        ),
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "An account with this email already exists.",
        ),
        "errorInvalidDates": MessageLookupByLibrary.simpleMessage(
          "The end date can\'t come before the start date.",
        ),
        "errorInvalidInviteCode": MessageLookupByLibrary.simpleMessage(
          "This code isn\'t valid for this email, or it has expired. Ask an admin for a new invitation.",
        ),
        "errorInvalidPoints": m53,
        "errorLastAdmin": MessageLookupByLibrary.simpleMessage(
          "The company needs at least one admin.",
        ),
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
        "errorNotInTeam": MessageLookupByLibrary.simpleMessage(
          "This person isn\'t in your team.",
        ),
        "errorNotManager": MessageLookupByLibrary.simpleMessage(
          "Only team managers can do that.",
        ),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "You are not signed in.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "You can only delete base achievements you created.",
        ),
        "errorPasswordTooShort": m54,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "You already have a pending request for this achievement.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "These dates overlap another season.",
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
        "exportCsv": MessageLookupByLibrary.simpleMessage("Export CSV"),
        "exportError": MessageLookupByLibrary.simpleMessage(
          "Could not save the file. Try again.",
        ),
        "exportJson": MessageLookupByLibrary.simpleMessage("Export JSON"),
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
          "Quiet in here. The next achievement anyone receives will break the silence.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "Your colleagues\' wins as they happen. Applause encouraged.",
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
        "filterAll": m55,
        "filterTier": m56,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Click the card to flip it",
        ),
        "fromAColleague":
            MessageLookupByLibrary.simpleMessage("From a colleague"),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Something went wrong. Try again.",
        ),
        "hapticsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Hold a card to flip it, and feel it snap into place on the Force Touch trackpad.",
        ),
        "hapticsTitle": MessageLookupByLibrary.simpleMessage("Haptic feedback"),
        "hidePassword": MessageLookupByLibrary.simpleMessage("Hide password"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Enter a valid email address",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Enter a valid http(s) link",
        ),
        "inviteCodeChip": m57,
        "inviteCodeLabel":
            MessageLookupByLibrary.simpleMessage("Invitation code"),
        "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
          "Enter the code you received",
        ),
        "inviteDetails": m58,
        "inviteDialogBody": m59,
        "inviteDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Invite a colleague",
        ),
        "inviteEmailHint": MessageLookupByLibrary.simpleMessage(
          "The email the invitation was sent to",
        ),
        "inviteExpired": MessageLookupByLibrary.simpleMessage("Expired"),
        "inviteMember": MessageLookupByLibrary.simpleMessage("Invite"),
        "inviteResend": MessageLookupByLibrary.simpleMessage("Send again"),
        "inviteRevoke": MessageLookupByLibrary.simpleMessage("Revoke"),
        "inviteRevokeBody": MessageLookupByLibrary.simpleMessage(
          "The code will stop working. You can invite them again later.",
        ),
        "inviteRevokeTitle": m60,
        "inviteRevoked":
            MessageLookupByLibrary.simpleMessage("Invitation revoked"),
        "inviteSend": MessageLookupByLibrary.simpleMessage("Send invitation"),
        "inviteSent": m61,
        "inviteSentDemo": m62,
        "invitesEmpty": MessageLookupByLibrary.simpleMessage(
          "No pending invitations.",
        ),
        "issuedCount": m63,
        "issuedTimes": m64,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verified"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("System"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Language"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Leaderboard"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Peer"),
        "levelAndXp": m65,
        "levelN": m66,
        "libraryCount": m67,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "The library is empty. Someone has to go first; it might as well be you.",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Something went wrong while loading data.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
        "memberSince": m68,
        "memberTeamLabel": m69,
        "membersCount": m70,
        "membersHint": MessageLookupByLibrary.simpleMessage(
          "Invite people to the company and choose who can manage it.",
        ),
        "membersWithoutTeam": MessageLookupByLibrary.simpleMessage(
          "Without a team",
        ),
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
        "navRequests": MessageLookupByLibrary.simpleMessage("Requests"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "navTeam": MessageLookupByLibrary.simpleMessage("My team"),
        "navYourCompany": MessageLookupByLibrary.simpleMessage("Your company"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "New base achievement",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "New verified achievement",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
        "newSeason": MessageLookupByLibrary.simpleMessage("New season"),
        "newTeam": MessageLookupByLibrary.simpleMessage("New team"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "Nothing in this tier yet. Give it time.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "No achievements yet.",
        ),
        "noManager": MessageLookupByLibrary.simpleMessage("No manager"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Nothing matches that. Try fewer letters, or a different hunch.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("No team"),
        "nominateDialogSubtitle": m71,
        "nominateDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Propose a verified achievement",
        ),
        "nominateMessageHint": MessageLookupByLibrary.simpleMessage(
          "Why do they deserve it?",
        ),
        "nominateSent": MessageLookupByLibrary.simpleMessage(
          "Proposal sent to the admins",
        ),
        "noteAuthorFallback":
            MessageLookupByLibrary.simpleMessage("A colleague"),
        "notifApprovedBody": m72,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Request approved",
        ),
        "notifCommentBody": m73,
        "notifCommentTitle":
            MessageLookupByLibrary.simpleMessage("New comment"),
        "notifLevelUpBody": m74,
        "notifLevelUpTitle": MessageLookupByLibrary.simpleMessage("Level up!"),
        "notifNewRequestBody": m75,
        "notifNewRequestTitle":
            MessageLookupByLibrary.simpleMessage("New request"),
        "notifNominationBody": m76,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "New proposal",
        ),
        "notifPeerBody": m77,
        "notifPeerTitle":
            MessageLookupByLibrary.simpleMessage("New achievement"),
        "notifReactionBody": m78,
        "notifReactionTitle":
            MessageLookupByLibrary.simpleMessage("New reaction"),
        "notifRecapBody": m79,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Your weekly recap",
        ),
        "notifRejectedBody": m80,
        "notifRejectedBodyReason": m81,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Request rejected",
        ),
        "notifVerifiedBody": m82,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Verified achievement",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "All caught up. Nothing needs you right now.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Open notifications",
        ),
        "notificationsTitle":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "notificationsUnread": m83,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Get started"),
        "onboardingFastBody": m84,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Move fast"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "The feed shows your colleagues\' achievements, so you can react and comment. Notifications tell you when something involves you.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Celebrate together",
        ),
        "onboardingKindsBody": m85,
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
        "passwordMinLength": m86,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Enter your password",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Passwords don\'t match",
        ),
        "pendingInvites": MessageLookupByLibrary.simpleMessage(
          "Pending invitations",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("Pending"),
        "percentValue": m87,
        "periodAll": MessageLookupByLibrary.simpleMessage("All time"),
        "periodLast30": MessageLookupByLibrary.simpleMessage("Last 30 days"),
        "periodQuarter": MessageLookupByLibrary.simpleMessage("This quarter"),
        "periodYear": MessageLookupByLibrary.simpleMessage("This year"),
        "personalDataBody": MessageLookupByLibrary.simpleMessage(
          "Everything Scoreboard holds about one person, as JSON, for data protection requests.",
        ),
        "personalDataPerson": MessageLookupByLibrary.simpleMessage("Person"),
        "personalDataTitle":
            MessageLookupByLibrary.simpleMessage("Personal data"),
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Pick an achievement from the catalog.",
        ),
        "pickDates": MessageLookupByLibrary.simpleMessage("Pick the dates"),
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
        "rankValue": m88,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Celebrate"),
        "reactionInsightful":
            MessageLookupByLibrary.simpleMessage("Insightful"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Like"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Love"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Recent achievements",
        ),
        "registerCreateCompany": MessageLookupByLibrary.simpleMessage(
          "Create a company",
        ),
        "registerJoin": MessageLookupByLibrary.simpleMessage("Join a company"),
        "reject": MessageLookupByLibrary.simpleMessage("Reject"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Reject the request?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Reason (optional)",
        ),
        "rejectionReason": m89,
        "replaceImage": MessageLookupByLibrary.simpleMessage("Replace image"),
        "reportAchievementsBody": MessageLookupByLibrary.simpleMessage(
          "One row per achievement received: date, person, team, kind, XP and who gave it.",
        ),
        "reportAchievementsTitle": MessageLookupByLibrary.simpleMessage(
          "Achievements",
        ),
        "reportPeopleBody": MessageLookupByLibrary.simpleMessage(
          "One row per person: achievements received and sent, XP and last recognition.",
        ),
        "reportPeopleTitle": MessageLookupByLibrary.simpleMessage("People"),
        "reportPeriod": MessageLookupByLibrary.simpleMessage("Period"),
        "reportSaved": MessageLookupByLibrary.simpleMessage("Report saved"),
        "reportsHint": MessageLookupByLibrary.simpleMessage(
          "For performance reviews and HR systems. Every export is written to the activity log.",
        ),
        "requestAction": MessageLookupByLibrary.simpleMessage("Request"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Request approved",
        ),
        "requestDialogSubtitle": m90,
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
        "requestNominatedBy": m91,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Request rejected",
        ),
        "requestSent": MessageLookupByLibrary.simpleMessage("Request sent"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage(
          "No requests. Everyone\'s either thriving or being modest.",
        ),
        "restore": MessageLookupByLibrary.simpleMessage("Restore"),
        "roleAtCompany": m92,
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
        "seasonActive": MessageLookupByLibrary.simpleMessage("In progress"),
        "seasonCurrent": MessageLookupByLibrary.simpleMessage("Current season"),
        "seasonDates": MessageLookupByLibrary.simpleMessage("Dates"),
        "seasonDaysLeft": m93,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Season deleted",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Ended"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Name"),
        "seasonNameHint":
            MessageLookupByLibrary.simpleMessage("e.g. Autumn 2026"),
        "seasonRange": m94,
        "seasonSaved": MessageLookupByLibrary.simpleMessage("Season saved"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
        "seasonYourRank": m95,
        "seasonsEmpty": MessageLookupByLibrary.simpleMessage("No seasons yet."),
        "seasonsHint": MessageLookupByLibrary.simpleMessage(
          "Each season has its own leaderboard, counting the XP earned between its dates. Seasons can\'t overlap.",
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
          "Pick an achievement and its card shows up here, ready to go.",
        ),
        "sendSuccess": m96,
        "sentByYouCount": m97,
        "sentCount": m98,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "You haven\'t sent any achievement yet. Pick one from the library and make a colleague\'s day.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("to"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Session"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("About"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
        "settingsAppearance":
            MessageLookupByLibrary.simpleMessage("Appearance"),
        "settingsSavedMessage": MessageLookupByLibrary.simpleMessage(
          "Settings saved",
        ),
        "shareAddToProfile":
            MessageLookupByLibrary.simpleMessage("Add to profile"),
        "shareAddToProfileHint": m99,
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
        "shareImageIssuedBy": m100,
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
        "sharePostPeer": m101,
        "sharePostVerified": m102,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Could not save the image. Try again.",
        ),
        "shareSaveImage": MessageLookupByLibrary.simpleMessage("Save image"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Text copied to the clipboard",
        ),
        "shortcutFlipCard": MessageLookupByLibrary.simpleMessage(
          "Flip the focused card",
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
        "teamDeletedMessage":
            MessageLookupByLibrary.simpleMessage("Team deleted"),
        "teamEmpty": MessageLookupByLibrary.simpleMessage(
          "Nobody in your team yet.",
        ),
        "teamLastRecognized": m103,
        "teamLeaderboard":
            MessageLookupByLibrary.simpleMessage("Team leaderboard"),
        "teamManager": MessageLookupByLibrary.simpleMessage("Manager"),
        "teamMemberActivity": m104,
        "teamName": MessageLookupByLibrary.simpleMessage("Team name"),
        "teamNeverRecognized": MessageLookupByLibrary.simpleMessage(
          "Never recognized yet",
        ),
        "teamNoRecent":
            MessageLookupByLibrary.simpleMessage("Nothing in 30+ days"),
        "teamNominate": MessageLookupByLibrary.simpleMessage("Propose"),
        "teamNominateTooltip": MessageLookupByLibrary.simpleMessage(
          "Propose a verified achievement",
        ),
        "teamSaved": MessageLookupByLibrary.simpleMessage("Team saved"),
        "teamStatNeedAttention": MessageLookupByLibrary.simpleMessage(
          "Need attention",
        ),
        "teamStatReceived30": MessageLookupByLibrary.simpleMessage(
          "Received in 30 days",
        ),
        "teamSubtitle": MessageLookupByLibrary.simpleMessage(
          "Who\'s getting the credit, and who deserves more",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "No teams yet. Create the first one.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Each team has a manager, who sees how its members are recognized and can propose verified achievements for them.",
        ),
        "templateAdded": m105,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Could not create the achievement. Try again.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Could not delete the achievement. Try again.",
        ),
        "templateDeleted": m106,
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
        "timeDays": m107,
        "timeHours": m108,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Just now"),
        "timeMinutes": m109,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("Top performers"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Open Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Quit Scoreboard"),
        "upToDate": MessageLookupByLibrary.simpleMessage("You\'re up to date."),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Download it from the release page on GitHub.",
        ),
        "updateAvailableTitle": m110,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "Couldn\'t check for updates.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Download"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Later"),
        "updatesSection": MessageLookupByLibrary.simpleMessage("Updates"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Upload image"),
        "uploadLogo": MessageLookupByLibrary.simpleMessage("Upload logo"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Upload photo"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Use it"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Verified by the company",
        ),
        "verifiedCount": m111,
        "versionLabel": m112,
        "workEmail": MessageLookupByLibrary.simpleMessage("Work email"),
        "xpToNextLevel": m113,
        "xpValue": m114,
        "youLabel": MessageLookupByLibrary.simpleMessage("(you)"),
        "youSuffix": m115,
      };
}
