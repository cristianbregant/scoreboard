// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 Erfolg', other: '${count} Erfolge')}";

  static String m1(count, subject) =>
      "${Intl.plural(count, one: 'hat „${subject}“ an 1 Person vergeben', other: 'hat „${subject}“ an ${count} Personen vergeben')}";

  static String m2(subject) => "hat ${subject} zum Administrator gemacht";

  static String m3(subject) =>
      "hat ${subject} die Administratorrechte entzogen";

  static String m4(subject) => "hat „${subject}“ archiviert";

  static String m5(subject) => "hat „${subject}“ zum Katalog hinzugefügt";

  static String m6(subject) => "hat „${subject}“ wiederhergestellt";

  static String m7(subject) => "hat „${subject}“ bearbeitet";

  static String m8(subject) => "hat die Einladung für ${subject} widerrufen";

  static String m9(subject) => "hat ${subject} eingeladen";

  static String m10(subject, target) =>
      "hat ${subject} nach ${target} verschoben";

  static String m11(subject) => "hat ${subject} aus dem Team genommen";

  static String m12(subject, target) =>
      "hat „${subject}“ für ${target} vorgeschlagen";

  static String m13(target) =>
      "hat die personenbezogenen Daten von ${target} exportiert";

  static String m14(target) => "hat den Erfolgsbericht exportiert (${target})";

  static String m15(target) => "hat den Personenbericht exportiert (${target})";

  static String m16(subject, target) =>
      "hat „${subject}“ für ${target} genehmigt";

  static String m17(subject, target) =>
      "hat „${subject}“ für ${target} abgelehnt";

  static String m18(subject) => "hat die Saison ${subject} erstellt";

  static String m19(subject) => "hat die Saison ${subject} gelöscht";

  static String m20(subject) => "hat die Saison ${subject} bearbeitet";

  static String m21(subject) => "hat das Team ${subject} erstellt";

  static String m22(subject) => "hat das Team ${subject} gelöscht";

  static String m23(subject) => "hat das Team ${subject} bearbeitet";

  static String m24(company) => "Admin · ${company}";

  static String m25(name) => "${name} ist jetzt Administrator";

  static String m26(name) => "${name} ist kein Administrator mehr";

  static String m27(points) => "${points} XP";

  static String m28(years) =>
      "${Intl.plural(years, one: '1 Jahr', other: '${years} Jahre')}";

  static String m29(count) =>
      "${Intl.plural(count, zero: 'Vergeben', one: 'An 1 Person vergeben', other: 'An ${count} Personen vergeben')}";

  static String m30(maxPoints) =>
      "Basis-Erfolge werden unter Kolleginnen und Kollegen gesendet und sind bis zu ${maxPoints} XP wert. Verifizierte Erfolge stellt nur dein Unternehmen aus. Du kannst jeden Basis-Erfolg derselben Person nur einmal senden.";

  static String m31(company) =>
      "Eure Farbe und euer Logo ersetzen das Gold von Scoreboard für alle bei ${company}. Die Farbe wird angepasst, damit Texte lesbar bleiben.";

  static String m32(remaining, budget) =>
      "Noch ${remaining} von ${budget} Sendungen in diesem Monat";

  static String m33(name) => "Von ${name}";

  static String m34(date) => "Ausgestellt am ${date}";

  static String m35(date) => "Erhalten am ${date}";

  static String m36(id) => "Nachweis-ID: ${id}";

  static String m37(company, date) => "Ausgestellt von ${company} am ${date}";

  static String m38(count) =>
      "${Intl.plural(count, zero: 'Kommentieren', one: '1 Kommentar', other: '${count} Kommentare')}";

  static String m39(year) => "Seit ${year}";

  static String m40(company) =>
      "Die verifizierten Erfolge, die ${company} vergeben kann. Klicke auf eine Karte, um sie zu bearbeiten.";

  static String m41(company) =>
      "Wie ${company} in Scoreboard aussieht und feiert";

  static String m42(company) =>
      "Wie Anerkennung bei ${company} fließt, und wo sie hängen bleibt.";

  static String m43(count) => "Anfragen · ${count}";

  static String m44(name) => "Von ${name}";

  static String m45(name) => "${name} löschen?";

  static String m46(name) => "${name} löschen?";

  static String m47(name) => "„${name}“ löschen?";

  static String m48(email, password) => "Demokonto: ${email} / ${password}";

  static String m49(id) => "ID ${id}";

  static String m50(template, colleague) =>
      "Du hast „${template}“ bereits an ${colleague} gesendet.";

  static String m51(budget) =>
      "Du hast alle ${budget} Erfolge für diesen Monat gesendet. Das Kontingent wird am 1. erneuert.";

  static String m52(min, max) =>
      "Der Wert muss zwischen ${min} und ${max} XP liegen.";

  static String m53(values) => "Basis-Erfolge können ${values} XP wert sein.";

  static String m54(min) =>
      "Das Passwort muss mindestens ${min} Zeichen lang sein.";

  static String m55(count) => "Alle · ${count}";

  static String m56(tier, count) => "${tier} · ${count}";

  static String m57(code) => "Code ${code}";

  static String m58(name, date) =>
      "Eingeladen von ${name} · läuft am ${date} ab";

  static String m59(company) =>
      "Die Person erhält per E-Mail einen Code, um ${company} beizutreten. Der Code ist 7 Tage gültig.";

  static String m60(email) => "Einladung für ${email} widerrufen?";

  static String m61(email) => "Einladung an ${email} gesendet";

  static String m62(email, code) =>
      "Demo-Modus, keine E-Mail gesendet: Gib ${email} den Code ${code}";

  static String m63(count) =>
      "${Intl.plural(count, one: 'An 1 Person ausgestellt', other: 'An ${count} Personen ausgestellt')}";

  static String m64(count) =>
      "${Intl.plural(count, one: 'einmal', other: '${count}-mal')}";

  static String m65(level, points) => "Level ${level} · ${points} XP";

  static String m66(level) => "Level ${level}";

  static String m67(count) => "Bibliothek · ${count}";

  static String m68(date) => "Mitglied seit ${date}";

  static String m69(name) => "Team von ${name}";

  static String m70(count) =>
      "${Intl.plural(count, one: '1 Mitglied', other: '${count} Mitglieder')}";

  static String m71(name) => "Für ${name}. Ein Admin prüft deinen Vorschlag.";

  static String m72(achievement) =>
      "„${achievement}“ wurde genehmigt und ist jetzt bei deinen Erfolgen";

  static String m73(actor, achievement, text) =>
      "${actor} hat „${achievement}“ kommentiert: ${text}";

  static String m74(level) => "Du hast Level ${level} erreicht";

  static String m75(actor, achievement) =>
      "${actor} hat „${achievement}“ angefragt";

  static String m76(actor, achievement, member) =>
      "${actor} schlägt „${achievement}“ für ${member} vor";

  static String m77(actor, achievement) =>
      "${actor} hat dir „${achievement}“ gesendet";

  static String m78(actor, achievement) =>
      "${actor} hat auf „${achievement}“ reagiert";

  static String m79(xp, rank) => "Diese Woche: +${xp} XP · Rang #${rank}";

  static String m80(achievement) => "„${achievement}“ wurde nicht genehmigt";

  static String m81(achievement, reason) =>
      "„${achievement}“ wurde nicht genehmigt: ${reason}";

  static String m82(company, achievement) =>
      "${company} hat dir „${achievement}“ ausgestellt";

  static String m83(count) =>
      "${Intl.plural(count, zero: 'Keine ungelesenen Mitteilungen', one: '1 ungelesene Mitteilung', other: '${count} ungelesene Mitteilungen')}";

  static String m84(shortcut) =>
      "Drück ${shortcut}, um von überall einen Erfolg zu senden, oder nutz das Symbol in der Menüleiste.";

  static String m85(budget) =>
      "Verifizierte Erfolge kommen von deinem Unternehmen: Du kannst sie im Katalog anfragen. Basis-Erfolge werden unter Kolleginnen und Kollegen ausgetauscht, bis zu ${budget} im Monat.";

  static String m86(min) => "Mindestens ${min} Zeichen";

  static String m87(percent) => "${percent} %";

  static String m88(rank) => "#${rank}";

  static String m89(reason) => "Grund: ${reason}";

  static String m90(company) => "Ein Admin von ${company} prüft deine Anfrage.";

  static String m91(name) => "Vorgeschlagen von ${name}";

  static String m92(role, company) => "${role} bei ${company}";

  static String m93(days) =>
      "${Intl.plural(days, one: 'Noch 1 Tag', other: 'Noch ${days} Tage')}";

  static String m94(start, end) => "${start} – ${end}";

  static String m95(rank, points) => "Du bist #${rank} mit ${points} XP";

  static String m96(name) => "Erfolg an ${name} gesendet";

  static String m97(count) => "Von dir gesendet · ${count}";

  static String m98(count) => "${count} gesendet";

  static String m99(company) =>
      "Fügt ihn unter „Bescheinigungen und Zertifikate“ hinzu, mit ${company} als Aussteller.";

  static String m100(company) => "Ausgestellt von ${company}";

  static String m101(sender, name, description) =>
      "🤝 ${sender} hat mich mit dem Erfolg „${name}“ gewürdigt.\n\n${description}\n\n#Scoreboard";

  static String m102(name, company, description) =>
      "🏆 Ich habe gerade den Erfolg „${name}“ erhalten, ausgestellt von ${company}.\n\n${description}\n\n#Scoreboard";

  static String m103(time) => "Zuletzt gewürdigt: ${time}";

  static String m104(received, sent) =>
      "${received} erhalten · ${sent} gesendet in 90 Tagen";

  static String m105(name) => "„${name}“ zur Bibliothek hinzugefügt";

  static String m106(name) => "„${name}“ gelöscht";

  static String m107(count) =>
      "${Intl.plural(count, one: 'Gestern', other: 'vor ${count} Tagen')}";

  static String m108(count) => "vor ${count} Std.";

  static String m109(count) => "vor ${count} Min.";

  static String m110(version) => "Version ${version} ist verfügbar";

  static String m111(count) => "${count} verifiziert";

  static String m112(version) => "Version ${version}";

  static String m113(points, level) => "Noch ${points} XP bis Level ${level}";

  static String m114(points) => "${points} XP";

  static String m115(name) => "${name} (du)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountSubtitle": MessageLookupByLibrary.simpleMessage(
          "Anmeldedaten. Name, Foto und Titelbild findest du im Profil.",
        ),
        "achievementDetailTitle":
            MessageLookupByLibrary.simpleMessage("Erfolg"),
        "achievementNamePlaceholder": MessageLookupByLibrary.simpleMessage(
          "Name des Erfolgs",
        ),
        "achievementsCount": m0,
        "achievementsEmptyBody": MessageLookupByLibrary.simpleMessage(
          "Frag einen verifizierten Erfolg aus dem Katalog deines Unternehmens an oder würdige die Arbeit einer Kollegin oder eines Kollegen: Das ist oft der beste Anfang.",
        ),
        "achievementsEmptyTitle": MessageLookupByLibrary.simpleMessage(
          "Dein erster Erfolg wartet",
        ),
        "achievementsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Deine ganze Arbeit, schwarz auf weiß",
        ),
        "achievementsTitle":
            MessageLookupByLibrary.simpleMessage("Deine Erfolge"),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "Das hat nicht geklappt. Versuch es noch einmal.",
        ),
        "activityAchievementsIssued": m1,
        "activityAdminGranted": m2,
        "activityAdminRevoked": m3,
        "activityAnniversariesUpdated": MessageLookupByLibrary.simpleMessage(
          "hat die Dienstjubiläen geändert",
        ),
        "activityBrandUpdated": MessageLookupByLibrary.simpleMessage(
          "hat Farbe oder Logo des Unternehmens geändert",
        ),
        "activityCatalogArchived": m4,
        "activityCatalogCreated": m5,
        "activityCatalogRestored": m6,
        "activityCatalogUpdated": m7,
        "activityEmpty": MessageLookupByLibrary.simpleMessage(
          "Noch keine Aktivität aufgezeichnet.",
        ),
        "activityHint": MessageLookupByLibrary.simpleMessage(
          "Was Admins und Teamleitungen getan haben, das Neueste zuerst. Es kann nicht geändert werden.",
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
        "adminGroupCompany":
            MessageLookupByLibrary.simpleMessage("UNTERNEHMEN"),
        "adminGroupData": MessageLookupByLibrary.simpleMessage("DATEN"),
        "adminGroupPeople": MessageLookupByLibrary.simpleMessage("PERSONEN"),
        "adminGroupRecognition": MessageLookupByLibrary.simpleMessage(
          "ANERKENNUNG",
        ),
        "adminMode": MessageLookupByLibrary.simpleMessage("Admin-Modus"),
        "adminModeHint": MessageLookupByLibrary.simpleMessage(
          "Verwalte die verifizierten Erfolge deines Unternehmens",
        ),
        "adminRevokeSelfAction":
            MessageLookupByLibrary.simpleMessage("Verzichten"),
        "adminRevokeSelfBody": MessageLookupByLibrary.simpleMessage(
          "Du verlässt die Konsole und kannst das Unternehmen nicht mehr verwalten. Ein anderer Administrator kann dir diese Rechte zurückgeben.",
        ),
        "adminRevokeSelfTitle": MessageLookupByLibrary.simpleMessage(
          "Auf deine Administratorrechte verzichten?",
        ),
        "adminRevokedMessage": m26,
        "adminRole": MessageLookupByLibrary.simpleMessage("Administrator"),
        "adminRoleTooltip": MessageLookupByLibrary.simpleMessage(
          "Kann die Konsole nutzen und das Unternehmen verwalten",
        ),
        "alreadyHasIt":
            MessageLookupByLibrary.simpleMessage("Bereits vorhanden"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Bereits an diese Person gesendet",
        ),
        "anniversariesBody": MessageLookupByLibrary.simpleMessage(
          "Ein verifizierter Erfolg zu jedem Dienstjubiläum, das ihr feiert, automatisch vergeben.",
        ),
        "anniversariesEnabled": MessageLookupByLibrary.simpleMessage(
          "Dienstjubiläen feiern",
        ),
        "anniversariesTitle": MessageLookupByLibrary.simpleMessage(
          "Dienstjubiläen",
        ),
        "anniversaryXp": m27,
        "anniversaryYears": m28,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Wähle, wie Scoreboard aussieht",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Genehmigen"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivieren"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archiviert"),
        "assignButton": m29,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "Eine Nachricht an die Empfänger",
        ),
        "assignNoteLabel":
            MessageLookupByLibrary.simpleMessage("Notiz (optional)"),
        "authCreateCompanySubtitle": MessageLookupByLibrary.simpleMessage(
          "Richte Scoreboard für dein Unternehmen ein. Du wirst sein Administrator.",
        ),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Mach mit beim Scoreboard deines Unternehmens.",
        ),
        "authCreateTitle":
            MessageLookupByLibrary.simpleMessage("Konto erstellen"),
        "authJoinSubtitle": MessageLookupByLibrary.simpleMessage(
          "Verwende den Einladungscode aus deiner E-Mail.",
        ),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Sammle die Erfolge, die dein Unternehmen ausstellt, und würdige die Kolleginnen und Kollegen, die etwas bewegen.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Deine Trophäen haben dich vermisst.",
        ),
        "authTagline": MessageLookupByLibrary.simpleMessage(
          "Jeder Erfolg,\nfestgehalten.",
        ),
        "authWelcomeBack": MessageLookupByLibrary.simpleMessage(
          "Willkommen zurück",
        ),
        "bannerClay": MessageLookupByLibrary.simpleMessage("Ton"),
        "bannerForest": MessageLookupByLibrary.simpleMessage("Wald"),
        "bannerGold": MessageLookupByLibrary.simpleMessage("Gold"),
        "bannerGraphite": MessageLookupByLibrary.simpleMessage("Graphit"),
        "bannerOcean": MessageLookupByLibrary.simpleMessage("Ozean"),
        "bannerSand": MessageLookupByLibrary.simpleMessage("Sand"),
        "baseExplanation": m30,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Kleine Dankeschöns, XP inklusive",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Ein Satz über dich und deine Arbeit",
        ),
        "brandBody": m31,
        "brandColor": MessageLookupByLibrary.simpleMessage("Farbe"),
        "brandDefault": MessageLookupByLibrary.simpleMessage("Scoreboard-Gold"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Vorschau"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Marke"),
        "budgetRemaining": m32,
        "cardBaseAchievement":
            MessageLookupByLibrary.simpleMessage("Basis-Erfolg"),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Karte umdrehen"),
        "cardFrom": m33,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("AUSGESTELLT VON"),
        "cardIssuedOn": m34,
        "cardReceivedOn": m35,
        "cardSentBy": MessageLookupByLibrary.simpleMessage("GESENDET VON"),
        "cardVerifiedAchievement": MessageLookupByLibrary.simpleMessage(
          "Verifizierter Erfolg",
        ),
        "catalogDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Nur Admins können ihn ausstellen, und er erscheint als verifiziert bei allen, die ihn erhalten.",
        ),
        "catalogEmpty": MessageLookupByLibrary.simpleMessage(
          "Der Katalog ist leer. Erstelle den ersten Erfolg.",
        ),
        "catalogPointsHint": MessageLookupByLibrary.simpleMessage(
          "Der Wert bestimmt die Stufe: Bronze unter 100 XP, Silber ab 100, Gold ab 120, Platin ab 140.",
        ),
        "catalogSaved": MessageLookupByLibrary.simpleMessage(
          "Katalog aktualisiert",
        ),
        "certCredentialId": m36,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "den folgenden Erfolg erhalten hat",
        ),
        "certIssuedBy": m37,
        "certPresentedTo": MessageLookupByLibrary.simpleMessage(
          "Hiermit wird bestätigt, dass",
        ),
        "certTitle": MessageLookupByLibrary.simpleMessage("URKUNDE"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Passwort ändern"),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Nach Updates suchen",
        ),
        "commentHint": MessageLookupByLibrary.simpleMessage(
          "Schreib einen Kommentar…",
        ),
        "commentsCount": m38,
        "commonBack": MessageLookupByLibrary.simpleMessage("Zurück"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "commonClose": MessageLookupByLibrary.simpleMessage("Schließen"),
        "commonCreate": MessageLookupByLibrary.simpleMessage("Erstellen"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Bearbeiten"),
        "commonPreview": MessageLookupByLibrary.simpleMessage("VORSCHAU"),
        "commonRemove": MessageLookupByLibrary.simpleMessage("Entfernen"),
        "commonRetry": MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
        "commonSave": MessageLookupByLibrary.simpleMessage("Speichern"),
        "commonSend": MessageLookupByLibrary.simpleMessage("Senden"),
        "communityCompanies":
            MessageLookupByLibrary.simpleMessage("Unternehmen"),
        "communityHiddenNotice": MessageLookupByLibrary.simpleMessage(
          "Du erscheinst nicht in dieser Rangliste. Du kannst das unter Einstellungen → Konto ändern.",
        ),
        "communityPeople": MessageLookupByLibrary.simpleMessage("Personen"),
        "communitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Alle, überall, in einer Rangliste. Kein Druck.",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Community"),
        "companyCatalog": MessageLookupByLibrary.simpleMessage(
          "Unternehmenskatalog",
        ),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "Die verifizierten Erfolge, die du erhalten kannst. Wenn du findest, dass du einen verdient hast, frag ihn an.",
        ),
        "companyIndustryLabel": MessageLookupByLibrary.simpleMessage(
          "Branche (optional)",
        ),
        "companyLocationLabel": MessageLookupByLibrary.simpleMessage(
          "Stadt (optional)",
        ),
        "companyNameLabel": MessageLookupByLibrary.simpleMessage(
          "Name des Unternehmens",
        ),
        "companyNameRequired": MessageLookupByLibrary.simpleMessage(
          "Gib den Namen des Unternehmens ein",
        ),
        "companySince": m39,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Bestätigen"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Neues Passwort bestätigen",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage(
          "Aktivitätsprotokoll",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Vergeben"),
        "consoleAssignSubtitle": MessageLookupByLibrary.simpleMessage(
          "Wähle einen Erfolg, wähle die Leute, versüße ihnen den Tag.",
        ),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Katalog"),
        "consoleCatalogSubtitle": m40,
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Unternehmen"),
        "consoleCompanySubtitle": m41,
        "consoleInsightsSubtitle": m42,
        "consoleMembers": MessageLookupByLibrary.simpleMessage("Mitglieder"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Berichte"),
        "consoleRequests": m43,
        "consoleRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Leute, die um Anerkennung bitten, die sie verdient zu haben glauben. Du entscheidest.",
        ),
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Saisons"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Statistiken"),
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Teams"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Konto erstellen"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Alle in deinem Unternehmen können ihn an Kolleginnen und Kollegen senden.",
        ),
        "createdBy": m44,
        "createdByYou":
            MessageLookupByLibrary.simpleMessage("Von dir erstellt"),
        "currentPassword": MessageLookupByLibrary.simpleMessage(
          "Aktuelles Passwort",
        ),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Gib dein aktuelles Passwort ein",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Entschieden"),
        "deleteSeasonBody": MessageLookupByLibrary.simpleMessage(
          "Die Rangliste verschwindet. Die Erfolge bleiben erhalten.",
        ),
        "deleteSeasonTitle": m45,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "Die Mitglieder sind dann ohne Team. Ihre Erfolge bleiben erhalten.",
        ),
        "deleteTeamTitle": m46,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Er wird aus der Bibliothek entfernt. Wer ihn schon erhalten hat, behält seinen Erfolg.",
        ),
        "deleteTemplateTitle": m47,
        "demoAccount": m48,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "Was muss man tun, um ihn zu verdienen?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Füg eine kurze Beschreibung hinzu",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Unternehmen"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Erhalten am"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Erfahrung"),
        "detailId": m49,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Gesendet von"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Stufe"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Erhalten"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Erfolg bearbeiten",
        ),
        "editProfile":
            MessageLookupByLibrary.simpleMessage("Profil bearbeiten"),
        "editSeason": MessageLookupByLibrary.simpleMessage("Saison bearbeiten"),
        "editTeam": MessageLookupByLibrary.simpleMessage("Team bearbeiten"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Deine E-Mail konnte nicht gespeichert werden. Versuch es noch einmal.",
        ),
        "emailUpdated":
            MessageLookupByLibrary.simpleMessage("E-Mail aktualisiert"),
        "emptyOpenCatalog":
            MessageLookupByLibrary.simpleMessage("Katalog öffnen"),
        "errorAlreadyMember": MessageLookupByLibrary.simpleMessage(
          "Diese Person hat bereits ein Scoreboard-Konto.",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "Du hast diesen Erfolg bereits.",
        ),
        "errorAlreadySent": m50,
        "errorBudgetExhausted": m51,
        "errorCatalogPoints": m52,
        "errorCompanyNameTaken": MessageLookupByLibrary.simpleMessage(
          "Ein Unternehmen mit diesem Namen ist bereits auf Scoreboard. Bitte einen seiner Administratoren, dich einzuladen.",
        ),
        "errorEmailNotSent": MessageLookupByLibrary.simpleMessage(
          "Die Einladungs-E-Mail konnte nicht gesendet werden. Versuche es später erneut.",
        ),
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "Es gibt bereits ein Konto mit dieser E-Mail.",
        ),
        "errorInvalidDates": MessageLookupByLibrary.simpleMessage(
          "Das Enddatum darf nicht vor dem Startdatum liegen.",
        ),
        "errorInvalidInviteCode": MessageLookupByLibrary.simpleMessage(
          "Der Code gilt nicht für diese E-Mail-Adresse oder ist abgelaufen. Bitte einen Administrator um eine neue Einladung.",
        ),
        "errorInvalidPoints": m53,
        "errorLastAdmin": MessageLookupByLibrary.simpleMessage(
          "Das Unternehmen braucht mindestens einen Administrator.",
        ),
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Gib deine E-Mail und dein Passwort ein.",
        ),
        "errorMissingFields": MessageLookupByLibrary.simpleMessage(
          "Füll alle Pflichtfelder aus.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Gib deinen Namen und deine Rolle ein.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "Du kannst Erfolge nur an Personen aus deinem Unternehmen senden.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Das können nur Admins des Unternehmens.",
        ),
        "errorNotFound":
            MessageLookupByLibrary.simpleMessage("Nicht gefunden."),
        "errorNotInTeam": MessageLookupByLibrary.simpleMessage(
          "Diese Person gehört nicht zu deinem Team.",
        ),
        "errorNotManager": MessageLookupByLibrary.simpleMessage(
          "Das können nur Teamleitungen.",
        ),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "Du bist nicht angemeldet.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "Du kannst nur Basis-Erfolge löschen, die du selbst erstellt hast.",
        ),
        "errorPasswordTooShort": m54,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Für diesen Erfolg hast du bereits eine offene Anfrage.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "Diese Daten überschneiden sich mit einer anderen Saison.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "Diesen Basis-Erfolg gibt es nicht mehr.",
        ),
        "errorWrongCredentials": MessageLookupByLibrary.simpleMessage(
          "E-Mail oder Passwort falsch.",
        ),
        "errorWrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
          "Das aktuelle Passwort ist falsch.",
        ),
        "evidenceLink": MessageLookupByLibrary.simpleMessage("Nachweis öffnen"),
        "evidenceUrlLabel": MessageLookupByLibrary.simpleMessage(
          "Link zum Nachweis (optional)",
        ),
        "experienceNote": MessageLookupByLibrary.simpleMessage(
          "Basis-Erfolge sind weniger wert als die verifizierten Erfolge deines Unternehmens.",
        ),
        "exportCsv":
            MessageLookupByLibrary.simpleMessage("Als CSV exportieren"),
        "exportError": MessageLookupByLibrary.simpleMessage(
          "Die Datei konnte nicht gespeichert werden. Versuch es noch einmal.",
        ),
        "exportJson":
            MessageLookupByLibrary.simpleMessage("Als JSON exportieren"),
        "exportMenu": MessageLookupByLibrary.simpleMessage("Exportieren"),
        "exportOpenBadge": MessageLookupByLibrary.simpleMessage(
          "Open Badge (JSON)",
        ),
        "exportOpenBadgeHint": MessageLookupByLibrary.simpleMessage(
          "Open-Badges-3.0-Nachweis. Die digitale Signatur kommt mit dem Backend.",
        ),
        "exportPdf": MessageLookupByLibrary.simpleMessage("PDF-Zertifikat"),
        "exportSaved":
            MessageLookupByLibrary.simpleMessage("Datei gespeichert"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("hat erhalten"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Noch ganz still hier. Der nächste Erfolg ändert das.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "Die Erfolge deiner Kollegen, sobald sie passieren. Applaus erwünscht.",
        ),
        "feedTitle": MessageLookupByLibrary.simpleMessage("Unternehmens-Feed"),
        "fieldAchievement": MessageLookupByLibrary.simpleMessage("Erfolg"),
        "fieldBio": MessageLookupByLibrary.simpleMessage("Über mich"),
        "fieldColleague": MessageLookupByLibrary.simpleMessage(
          "Kollegin oder Kollege",
        ),
        "fieldCover": MessageLookupByLibrary.simpleMessage("Titelbild"),
        "fieldDescription":
            MessageLookupByLibrary.simpleMessage("Beschreibung"),
        "fieldEmail": MessageLookupByLibrary.simpleMessage("E-Mail"),
        "fieldExperience": MessageLookupByLibrary.simpleMessage("Erfahrung"),
        "fieldFullName":
            MessageLookupByLibrary.simpleMessage("Vollständiger Name"),
        "fieldIcon": MessageLookupByLibrary.simpleMessage("Symbol"),
        "fieldMessageOptional": MessageLookupByLibrary.simpleMessage(
          "Nachricht (optional)",
        ),
        "fieldName": MessageLookupByLibrary.simpleMessage("Name"),
        "fieldPhoto": MessageLookupByLibrary.simpleMessage("Foto"),
        "fieldRole": MessageLookupByLibrary.simpleMessage("Rolle"),
        "filterAll": m55,
        "filterTier": m56,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Klick auf die Karte, um sie umzudrehen",
        ),
        "fromAColleague": MessageLookupByLibrary.simpleMessage(
          "Von einer Kollegin oder einem Kollegen",
        ),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Etwas ist schiefgelaufen. Versuch es noch einmal.",
        ),
        "hapticsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Halte eine Karte gedrückt, um sie umzudrehen, und spür auf dem Force-Touch-Trackpad, wie sie einrastet.",
        ),
        "hapticsTitle":
            MessageLookupByLibrary.simpleMessage("Haptisches Feedback"),
        "hidePassword":
            MessageLookupByLibrary.simpleMessage("Passwort verbergen"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Gib eine gültige E-Mail-Adresse ein",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Gib einen gültigen http(s)-Link ein",
        ),
        "inviteCodeChip": m57,
        "inviteCodeLabel":
            MessageLookupByLibrary.simpleMessage("Einladungscode"),
        "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
          "Gib den erhaltenen Code ein",
        ),
        "inviteDetails": m58,
        "inviteDialogBody": m59,
        "inviteDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Kollegen einladen",
        ),
        "inviteEmailHint": MessageLookupByLibrary.simpleMessage(
          "Die E-Mail-Adresse, an die die Einladung ging",
        ),
        "inviteExpired": MessageLookupByLibrary.simpleMessage("Abgelaufen"),
        "inviteMember": MessageLookupByLibrary.simpleMessage("Einladen"),
        "inviteResend": MessageLookupByLibrary.simpleMessage("Erneut senden"),
        "inviteRevoke": MessageLookupByLibrary.simpleMessage("Widerrufen"),
        "inviteRevokeBody": MessageLookupByLibrary.simpleMessage(
          "Der Code funktioniert dann nicht mehr. Du kannst die Person später erneut einladen.",
        ),
        "inviteRevokeTitle": m60,
        "inviteRevoked": MessageLookupByLibrary.simpleMessage(
          "Einladung widerrufen",
        ),
        "inviteSend": MessageLookupByLibrary.simpleMessage("Einladung senden"),
        "inviteSent": m61,
        "inviteSentDemo": m62,
        "invitesEmpty": MessageLookupByLibrary.simpleMessage(
          "Keine offenen Einladungen.",
        ),
        "issuedCount": m63,
        "issuedTimes": m64,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verifiziert"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("System"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Sprache"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Rangliste"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Unter Kollegen"),
        "levelAndXp": m65,
        "levelN": m66,
        "libraryCount": m67,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "Die Bibliothek ist leer. Irgendwer muss anfangen. Warum nicht du?",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Beim Laden der Daten ist etwas schiefgelaufen.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Alle als gelesen markieren",
        ),
        "memberSince": m68,
        "memberTeamLabel": m69,
        "membersCount": m70,
        "membersHint": MessageLookupByLibrary.simpleMessage(
          "Lade Personen in das Unternehmen ein und lege fest, wer es verwalten darf.",
        ),
        "membersWithoutTeam": MessageLookupByLibrary.simpleMessage("Ohne Team"),
        "messageHint": MessageLookupByLibrary.simpleMessage(
          "Schreib, warum der Erfolg verdient ist",
        ),
        "myRequests": MessageLookupByLibrary.simpleMessage("Deine Anfragen"),
        "nameHint": MessageLookupByLibrary.simpleMessage("z. B. Teamplayer"),
        "nameRequired": MessageLookupByLibrary.simpleMessage(
          "Gib deinen Namen ein",
        ),
        "navAchievements": MessageLookupByLibrary.simpleMessage("Erfolge"),
        "navBaseAchievements": MessageLookupByLibrary.simpleMessage(
          "Basis-Erfolge",
        ),
        "navCommunity": MessageLookupByLibrary.simpleMessage("Community"),
        "navConsole":
            MessageLookupByLibrary.simpleMessage("Unternehmenskonsole"),
        "navFeed": MessageLookupByLibrary.simpleMessage("Feed"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
        "navRequests": MessageLookupByLibrary.simpleMessage("Anfragen"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "navTeam": MessageLookupByLibrary.simpleMessage("Mein Team"),
        "navYourCompany":
            MessageLookupByLibrary.simpleMessage("Dein Unternehmen"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Neuer Basis-Erfolg",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Neuer verifizierter Erfolg",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
        "newSeason": MessageLookupByLibrary.simpleMessage("Neue Saison"),
        "newTeam": MessageLookupByLibrary.simpleMessage("Neues Team"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "In dieser Stufe noch nichts. Das kommt noch.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Noch keine Erfolge.",
        ),
        "noManager": MessageLookupByLibrary.simpleMessage("Keine Teamleitung"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Nichts gefunden. Versuch es mit weniger Buchstaben oder einer anderen Idee.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("Kein Team"),
        "nominateDialogSubtitle": m71,
        "nominateDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Einen verifizierten Erfolg vorschlagen",
        ),
        "nominateMessageHint": MessageLookupByLibrary.simpleMessage(
          "Warum hat die Person ihn verdient?",
        ),
        "nominateSent": MessageLookupByLibrary.simpleMessage(
          "Vorschlag an die Admins gesendet",
        ),
        "noteAuthorFallback": MessageLookupByLibrary.simpleMessage(
          "Eine Kollegin oder ein Kollege",
        ),
        "notifApprovedBody": m72,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Anfrage genehmigt",
        ),
        "notifCommentBody": m73,
        "notifCommentTitle": MessageLookupByLibrary.simpleMessage(
          "Neuer Kommentar",
        ),
        "notifLevelUpBody": m74,
        "notifLevelUpTitle": MessageLookupByLibrary.simpleMessage("Level-Up!"),
        "notifNewRequestBody": m75,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Neue Anfrage",
        ),
        "notifNominationBody": m76,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "Neuer Vorschlag",
        ),
        "notifPeerBody": m77,
        "notifPeerTitle": MessageLookupByLibrary.simpleMessage("Neuer Erfolg"),
        "notifReactionBody": m78,
        "notifReactionTitle":
            MessageLookupByLibrary.simpleMessage("Neue Reaktion"),
        "notifRecapBody": m79,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Dein Wochenrückblick",
        ),
        "notifRejectedBody": m80,
        "notifRejectedBodyReason": m81,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Anfrage abgelehnt",
        ),
        "notifVerifiedBody": m82,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Verifizierter Erfolg",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "Alles erledigt. Gerade braucht dich nichts.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Mitteilungen öffnen",
        ),
        "notificationsTitle":
            MessageLookupByLibrary.simpleMessage("Mitteilungen"),
        "notificationsUnread": m83,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Los geht’s"),
        "onboardingFastBody": m84,
        "onboardingFastTitle": MessageLookupByLibrary.simpleMessage(
          "Schnell unterwegs",
        ),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "Der Feed zeigt die Erfolge deiner Kolleginnen und Kollegen, damit du reagieren und kommentieren kannst. Mitteilungen sagen dir, wenn es um dich geht.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Gemeinsam feiern",
        ),
        "onboardingKindsBody": m85,
        "onboardingKindsTitle": MessageLookupByLibrary.simpleMessage(
          "Verifizierte Erfolge und Erfolge unter Kollegen",
        ),
        "onboardingNext": MessageLookupByLibrary.simpleMessage("Weiter"),
        "onboardingReplay": MessageLookupByLibrary.simpleMessage(
          "Einführung erneut ansehen",
        ),
        "onboardingSkip": MessageLookupByLibrary.simpleMessage("Überspringen"),
        "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
          "Hier sammelst du die Erfolge, die du bei der Arbeit erhältst, als Karten. Fahr mit der Maus darüber und dreh sie um, um zu sehen, wer sie ausgestellt hat.",
        ),
        "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
          "Willkommen bei Scoreboard",
        ),
        "passwordChangeError": MessageLookupByLibrary.simpleMessage(
          "Dein Passwort konnte nicht geändert werden. Versuch es noch einmal.",
        ),
        "passwordChanged": MessageLookupByLibrary.simpleMessage(
          "Passwort geändert",
        ),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Passwort"),
        "passwordMinLength": m86,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Gib dein Passwort ein",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Passwort"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Die Passwörter stimmen nicht überein",
        ),
        "pendingInvites": MessageLookupByLibrary.simpleMessage(
          "Offene Einladungen",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("Offen"),
        "percentValue": m87,
        "periodAll": MessageLookupByLibrary.simpleMessage("Gesamter Zeitraum"),
        "periodLast30": MessageLookupByLibrary.simpleMessage("Letzte 30 Tage"),
        "periodQuarter": MessageLookupByLibrary.simpleMessage("Dieses Quartal"),
        "periodYear": MessageLookupByLibrary.simpleMessage("Dieses Jahr"),
        "personalDataBody": MessageLookupByLibrary.simpleMessage(
          "Alles, was Scoreboard über eine Person speichert, als JSON, für Datenschutzanfragen.",
        ),
        "personalDataPerson": MessageLookupByLibrary.simpleMessage("Person"),
        "personalDataTitle": MessageLookupByLibrary.simpleMessage(
          "Personenbezogene Daten",
        ),
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Wähl einen Erfolg aus dem Katalog.",
        ),
        "pickDates": MessageLookupByLibrary.simpleMessage("Zeitraum wählen"),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Deine Kolleginnen und Kollegen sehen dich weiterhin in der Team-Rangliste.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "Mich in der Community-Rangliste zeigen",
        ),
        "privacySection": MessageLookupByLibrary.simpleMessage("Datenschutz"),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "Dein Profil konnte nicht gespeichert werden. Versuch es noch einmal.",
        ),
        "profileUpdated": MessageLookupByLibrary.simpleMessage(
          "Profil aktualisiert",
        ),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Verborgen"),
        "rankValue": m88,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Feiern"),
        "reactionInsightful":
            MessageLookupByLibrary.simpleMessage("Inspirierend"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Gefällt mir"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Super"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Neueste Erfolge",
        ),
        "registerCreateCompany": MessageLookupByLibrary.simpleMessage(
          "Unternehmen anlegen",
        ),
        "registerJoin": MessageLookupByLibrary.simpleMessage(
          "Einem Unternehmen beitreten",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Ablehnen"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Anfrage ablehnen?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Grund (optional)",
        ),
        "rejectionReason": m89,
        "replaceImage": MessageLookupByLibrary.simpleMessage("Bild ersetzen"),
        "reportAchievementsBody": MessageLookupByLibrary.simpleMessage(
          "Eine Zeile pro erhaltenem Erfolg: Datum, Person, Team, Art, XP und von wem.",
        ),
        "reportAchievementsTitle":
            MessageLookupByLibrary.simpleMessage("Erfolge"),
        "reportPeopleBody": MessageLookupByLibrary.simpleMessage(
          "Eine Zeile pro Person: erhaltene und gesendete Erfolge, XP und letzte Anerkennung.",
        ),
        "reportPeopleTitle": MessageLookupByLibrary.simpleMessage("Personen"),
        "reportPeriod": MessageLookupByLibrary.simpleMessage("Zeitraum"),
        "reportSaved":
            MessageLookupByLibrary.simpleMessage("Bericht gespeichert"),
        "reportsHint": MessageLookupByLibrary.simpleMessage(
          "Für Mitarbeitergespräche und HR-Systeme. Jeder Export landet im Aktivitätsprotokoll.",
        ),
        "requestAction": MessageLookupByLibrary.simpleMessage("Anfragen"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Anfrage genehmigt",
        ),
        "requestDialogSubtitle": m90,
        "requestDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Einen Erfolg anfragen",
        ),
        "requestMessage": MessageLookupByLibrary.simpleMessage("Nachricht"),
        "requestMessageHint": MessageLookupByLibrary.simpleMessage(
          "Womit hast du ihn verdient?",
        ),
        "requestMessageRequired": MessageLookupByLibrary.simpleMessage(
          "Schreib eine Nachricht",
        ),
        "requestNominatedBy": m91,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Anfrage abgelehnt",
        ),
        "requestSent": MessageLookupByLibrary.simpleMessage("Anfrage gesendet"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage(
          "Keine Anfragen. Entweder läuft alles super, oder alle sind bescheiden.",
        ),
        "restore": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
        "roleAtCompany": m92,
        "roleRequired":
            MessageLookupByLibrary.simpleMessage("Gib deine Rolle ein"),
        "saveProfile": MessageLookupByLibrary.simpleMessage("Profil speichern"),
        "searchAchievementsHint": MessageLookupByLibrary.simpleMessage(
          "Deine Erfolge durchsuchen",
        ),
        "searchCompaniesHint": MessageLookupByLibrary.simpleMessage(
          "Nach Name oder Branche suchen",
        ),
        "searchPeopleHint": MessageLookupByLibrary.simpleMessage(
          "Nach Name, Rolle oder Unternehmen suchen",
        ),
        "seasonActive": MessageLookupByLibrary.simpleMessage("Läuft"),
        "seasonCurrent":
            MessageLookupByLibrary.simpleMessage("Aktuelle Saison"),
        "seasonDates": MessageLookupByLibrary.simpleMessage("Zeitraum"),
        "seasonDaysLeft": m93,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Saison gelöscht",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Beendet"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Name"),
        "seasonNameHint":
            MessageLookupByLibrary.simpleMessage("z. B. Herbst 2026"),
        "seasonRange": m94,
        "seasonSaved":
            MessageLookupByLibrary.simpleMessage("Saison gespeichert"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("Geplant"),
        "seasonYourRank": m95,
        "seasonsEmpty":
            MessageLookupByLibrary.simpleMessage("Noch keine Saisons."),
        "seasonsHint": MessageLookupByLibrary.simpleMessage(
          "Jede Saison hat eine eigene Rangliste mit den XP aus ihrem Zeitraum. Saisons dürfen sich nicht überschneiden.",
        ),
        "selectAll": MessageLookupByLibrary.simpleMessage("Alle auswählen"),
        "sendAchievement":
            MessageLookupByLibrary.simpleMessage("Erfolg senden"),
        "sendAnAchievement": MessageLookupByLibrary.simpleMessage(
          "Einen Erfolg senden",
        ),
        "sendDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Würdige eine Kollegin oder einen Kollegen mit einem deiner Basis-Erfolge.",
        ),
        "sendError": MessageLookupByLibrary.simpleMessage(
          "Der Erfolg konnte nicht gesendet werden. Versuch es noch einmal.",
        ),
        "sendLoadError": MessageLookupByLibrary.simpleMessage(
          "Deine Kolleginnen und Kollegen konnten nicht geladen werden. Versuch es noch einmal.",
        ),
        "sendNoColleagues": MessageLookupByLibrary.simpleMessage(
          "In deinem Unternehmen gibt es noch keine weiteren Personen.",
        ),
        "sendNoTemplates": MessageLookupByLibrary.simpleMessage(
          "Erstelle zuerst einen Basis-Erfolg.",
        ),
        "sendPreviewHint": MessageLookupByLibrary.simpleMessage(
          "Wähle einen Erfolg, und seine Karte erscheint hier, bereit zum Versand.",
        ),
        "sendSuccess": m96,
        "sentByYouCount": m97,
        "sentCount": m98,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "Du hast noch keinen Erfolg gesendet. Wähl einen aus der Bibliothek und mach jemandem im Team eine Freude.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("an"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Sitzung"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("Info"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Konto"),
        "settingsAppearance":
            MessageLookupByLibrary.simpleMessage("Darstellung"),
        "settingsSavedMessage": MessageLookupByLibrary.simpleMessage(
          "Einstellungen gespeichert",
        ),
        "shareAddToProfile": MessageLookupByLibrary.simpleMessage(
          "Zum Profil hinzufügen",
        ),
        "shareAddToProfileHint": m99,
        "shareCopyText": MessageLookupByLibrary.simpleMessage("Text kopieren"),
        "shareDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Poste darüber oder füg ihn deinem LinkedIn-Profil hinzu.",
        ),
        "shareImageHeadline": MessageLookupByLibrary.simpleMessage(
          "ERFOLG FREIGESCHALTET",
        ),
        "shareImageHint": MessageLookupByLibrary.simpleMessage(
          "LinkedIn-Links können keine Bilder anhängen: Speichere dieses Bild und füg es deinem Beitrag hinzu.",
        ),
        "shareImageIssuedBy": m100,
        "shareImageSaved":
            MessageLookupByLibrary.simpleMessage("Bild gespeichert"),
        "shareOnLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Auf LinkedIn teilen",
        ),
        "shareOpenError": MessageLookupByLibrary.simpleMessage(
          "LinkedIn konnte nicht geöffnet werden.",
        ),
        "shareOpenLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Auf LinkedIn posten",
        ),
        "shareOpened": MessageLookupByLibrary.simpleMessage(
          "Text kopiert: Falls LinkedIn ihn nicht einfügt, füg ihn selbst in den Beitrag ein.",
        ),
        "sharePostLabel":
            MessageLookupByLibrary.simpleMessage("Text des Beitrags"),
        "sharePostPeer": m101,
        "sharePostVerified": m102,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Das Bild konnte nicht gespeichert werden. Versuch es noch einmal.",
        ),
        "shareSaveImage":
            MessageLookupByLibrary.simpleMessage("Bild speichern"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Text in die Zwischenablage kopiert",
        ),
        "shortcutFlipCard": MessageLookupByLibrary.simpleMessage(
          "Ausgewählte Karte umdrehen",
        ),
        "shortcutGoToPage": MessageLookupByLibrary.simpleMessage(
          "Zu Seite 1–8 wechseln",
        ),
        "shortcutsSection":
            MessageLookupByLibrary.simpleMessage("Tastenkürzel"),
        "showArchived": MessageLookupByLibrary.simpleMessage(
          "Archivierte anzeigen",
        ),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Passwort anzeigen"),
        "signIn": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "signOut": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "signOutDescription": MessageLookupByLibrary.simpleMessage(
          "Von Scoreboard auf diesem Computer abmelden.",
        ),
        "signOutError": MessageLookupByLibrary.simpleMessage(
          "Abmelden fehlgeschlagen. Versuch es noch einmal.",
        ),
        "sortLabel": MessageLookupByLibrary.simpleMessage("Sortieren"),
        "sortName": MessageLookupByLibrary.simpleMessage("Name (A–Z)"),
        "sortNewest": MessageLookupByLibrary.simpleMessage("Neueste"),
        "sortOldest": MessageLookupByLibrary.simpleMessage("Älteste"),
        "sortPoints": MessageLookupByLibrary.simpleMessage("Meiste XP"),
        "statAchievements": MessageLookupByLibrary.simpleMessage("Erfolge"),
        "statCompanyRank": MessageLookupByLibrary.simpleMessage(
          "Rang im Unternehmen",
        ),
        "statGlobalRank": MessageLookupByLibrary.simpleMessage("Globaler Rang"),
        "statMembers": MessageLookupByLibrary.simpleMessage("Mitglieder"),
        "statTotalXp": MessageLookupByLibrary.simpleMessage("XP gesamt"),
        "statVerified": MessageLookupByLibrary.simpleMessage("Verifiziert"),
        "statYourRank": MessageLookupByLibrary.simpleMessage("Dein Rang"),
        "statsActiveSenders": MessageLookupByLibrary.simpleMessage(
          "Personen, die andere würdigen",
        ),
        "statsCoverage": MessageLookupByLibrary.simpleMessage(
          "In den letzten 30 Tagen gewürdigt",
        ),
        "statsIssuedThisMonth": MessageLookupByLibrary.simpleMessage(
          "Verifiziert diesen Monat",
        ),
        "statsMonthlyChart": MessageLookupByLibrary.simpleMessage(
          "Erfolge der letzten 6 Monate",
        ),
        "statsNoData":
            MessageLookupByLibrary.simpleMessage("Noch keine Daten."),
        "statsPeerThisMonth": MessageLookupByLibrary.simpleMessage(
          "Unter Kollegen diesen Monat",
        ),
        "statsTopCatalog": MessageLookupByLibrary.simpleMessage(
          "Am häufigsten ausgestellt",
        ),
        "statsTopSenders": MessageLookupByLibrary.simpleMessage(
          "Wer am meisten würdigt",
        ),
        "statsTopSendersHint": MessageLookupByLibrary.simpleMessage(
          "In den letzten 90 Tagen gesendete Basis-Erfolge.",
        ),
        "statsUnderRecognized": MessageLookupByLibrary.simpleMessage(
          "Könnten etwas Anerkennung brauchen",
        ),
        "statsUnderRecognizedHint": MessageLookupByLibrary.simpleMessage(
          "Wer in den letzten 90 Tagen die wenigsten Erfolge erhalten hat.",
        ),
        "statusApproved": MessageLookupByLibrary.simpleMessage("Genehmigt"),
        "statusPending": MessageLookupByLibrary.simpleMessage("Offen"),
        "statusRejected": MessageLookupByLibrary.simpleMessage("Abgelehnt"),
        "submitRequest": MessageLookupByLibrary.simpleMessage("Anfrage senden"),
        "teamDeletedMessage":
            MessageLookupByLibrary.simpleMessage("Team gelöscht"),
        "teamEmpty": MessageLookupByLibrary.simpleMessage(
          "Noch niemand in deinem Team.",
        ),
        "teamLastRecognized": m103,
        "teamLeaderboard":
            MessageLookupByLibrary.simpleMessage("Team-Rangliste"),
        "teamManager": MessageLookupByLibrary.simpleMessage("Teamleitung"),
        "teamMemberActivity": m104,
        "teamName": MessageLookupByLibrary.simpleMessage("Teamname"),
        "teamNeverRecognized": MessageLookupByLibrary.simpleMessage(
          "Noch keine Anerkennung",
        ),
        "teamNoRecent": MessageLookupByLibrary.simpleMessage(
          "Seit über 30 Tagen nichts",
        ),
        "teamNominate": MessageLookupByLibrary.simpleMessage("Vorschlagen"),
        "teamNominateTooltip": MessageLookupByLibrary.simpleMessage(
          "Einen verifizierten Erfolg vorschlagen",
        ),
        "teamSaved": MessageLookupByLibrary.simpleMessage("Team gespeichert"),
        "teamStatNeedAttention": MessageLookupByLibrary.simpleMessage(
          "Brauchen Aufmerksamkeit",
        ),
        "teamStatReceived30": MessageLookupByLibrary.simpleMessage(
          "In 30 Tagen erhalten",
        ),
        "teamSubtitle": MessageLookupByLibrary.simpleMessage(
          "Wer Anerkennung bekommt, und wer mehr verdient",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "Noch keine Teams. Erstelle das erste.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Jedes Team hat eine Leitung, die sieht, wie die Mitglieder gewürdigt werden, und verifizierte Erfolge für sie vorschlagen kann.",
        ),
        "templateAdded": m105,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Der Erfolg konnte nicht erstellt werden. Versuch es noch einmal.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Der Erfolg konnte nicht gelöscht werden. Versuch es noch einmal.",
        ),
        "templateDeleted": m106,
        "templateNameRequired": MessageLookupByLibrary.simpleMessage(
          "Gib ihm einen Namen",
        ),
        "themeDark": MessageLookupByLibrary.simpleMessage("Dunkel"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Hell"),
        "themeTitle": MessageLookupByLibrary.simpleMessage("Design"),
        "tierBronze": MessageLookupByLibrary.simpleMessage("Bronze"),
        "tierGold": MessageLookupByLibrary.simpleMessage("Gold"),
        "tierPeer": MessageLookupByLibrary.simpleMessage("Kollegen"),
        "tierPlatinum": MessageLookupByLibrary.simpleMessage("Platin"),
        "tierSilver": MessageLookupByLibrary.simpleMessage("Silber"),
        "timeDays": m107,
        "timeHours": m108,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Gerade eben"),
        "timeMinutes": m109,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("Die Besten"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Scoreboard öffnen"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Scoreboard beenden"),
        "upToDate": MessageLookupByLibrary.simpleMessage(
          "Du hast die neueste Version.",
        ),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Lade sie von der Release-Seite auf GitHub herunter.",
        ),
        "updateAvailableTitle": m110,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "Die Suche nach Updates ist fehlgeschlagen.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Herunterladen"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Später"),
        "updatesSection": MessageLookupByLibrary.simpleMessage("Updates"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Bild hochladen"),
        "uploadLogo": MessageLookupByLibrary.simpleMessage("Logo hochladen"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Foto hochladen"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Verwenden"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Vom Unternehmen verifiziert",
        ),
        "verifiedCount": m111,
        "versionLabel": m112,
        "workEmail":
            MessageLookupByLibrary.simpleMessage("Geschäftliche E-Mail"),
        "xpToNextLevel": m113,
        "xpValue": m114,
        "youLabel": MessageLookupByLibrary.simpleMessage("(du)"),
        "youSuffix": m115,
      };
}
