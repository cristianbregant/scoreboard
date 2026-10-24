// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 traguardo', other: '${count} traguardi')}";

  static String m1(count, subject) =>
      "${Intl.plural(count, one: 'ha assegnato “${subject}” a 1 persona', other: 'ha assegnato “${subject}” a ${count} persone')}";

  static String m2(subject) => "ha reso ${subject} amministratore";

  static String m3(subject) =>
      "ha tolto a ${subject} i diritti di amministratore";

  static String m4(subject) => "ha archiviato “${subject}”";

  static String m5(subject) => "ha aggiunto “${subject}” al catalogo";

  static String m6(subject) => "ha ripristinato “${subject}”";

  static String m7(subject) => "ha modificato “${subject}”";

  static String m8(subject) => "ha revocato l\'invito per ${subject}";

  static String m9(subject) => "ha invitato ${subject}";

  static String m10(subject, target) => "ha spostato ${subject} in ${target}";

  static String m11(subject) => "ha tolto ${subject} dal suo team";

  static String m12(subject, target) =>
      "ha proposto “${subject}” per ${target}";

  static String m13(target) => "ha esportato i dati personali di ${target}";

  static String m14(target) =>
      "ha esportato il report dei traguardi (${target})";

  static String m15(target) => "ha esportato il report per persona (${target})";

  static String m16(subject, target) =>
      "ha approvato “${subject}” per ${target}";

  static String m17(subject, target) =>
      "ha respinto “${subject}” per ${target}";

  static String m18(subject) => "ha creato la stagione ${subject}";

  static String m19(subject) => "ha eliminato la stagione ${subject}";

  static String m20(subject) => "ha modificato la stagione ${subject}";

  static String m21(subject) => "ha creato il team ${subject}";

  static String m22(subject) => "ha eliminato il team ${subject}";

  static String m23(subject) => "ha modificato il team ${subject}";

  static String m24(company) => "Admin · ${company}";

  static String m25(name) => "${name} ora è amministratore";

  static String m26(name) => "${name} non è più amministratore";

  static String m27(points) => "${points} XP";

  static String m28(years) =>
      "${Intl.plural(years, one: '1 anno', other: '${years} anni')}";

  static String m29(count) =>
      "${Intl.plural(count, zero: 'Assegna', one: 'Assegna a 1 persona', other: 'Assegna a ${count} persone')}";

  static String m30(maxPoints) =>
      "I traguardi base si scambiano tra colleghi e valgono fino a ${maxPoints} XP. Quelli verificati li rilascia solo la tua azienda. Puoi inviare ogni traguardo base allo stesso collega una sola volta.";

  static String m31(company) =>
      "Il vostro colore e il vostro logo sostituiscono l\'oro di Scoreboard per tutti in ${company}. Il colore viene adattato perché i testi restino leggibili.";

  static String m32(remaining, budget) =>
      "${remaining} di ${budget} invii rimasti questo mese";

  static String m33(name) => "Da ${name}";

  static String m34(date) => "Rilasciato il ${date}";

  static String m35(date) => "Ricevuto il ${date}";

  static String m36(id) => "ID credenziale: ${id}";

  static String m37(company, date) => "Rilasciato da ${company} il ${date}";

  static String m38(count) =>
      "${Intl.plural(count, zero: 'Commenta', one: '1 commento', other: '${count} commenti')}";

  static String m39(year) => "Dal ${year}";

  static String m40(count) => "Richieste · ${count}";

  static String m41(company) => "Gestisci i traguardi verificati di ${company}";

  static String m42(name) => "Di ${name}";

  static String m43(name) => "Eliminare ${name}?";

  static String m44(name) => "Eliminare ${name}?";

  static String m45(name) => "Eliminare “${name}”?";

  static String m46(email, password) => "Account demo: ${email} / ${password}";

  static String m47(id) => "ID ${id}";

  static String m48(template, colleague) =>
      "Hai già inviato “${template}” a ${colleague}.";

  static String m49(budget) =>
      "Hai già inviato i ${budget} traguardi di questo mese. Il budget si rinnova il primo del mese.";

  static String m50(min, max) =>
      "Il valore deve essere tra ${min} e ${max} XP.";

  static String m51(values) => "I traguardi base possono valere ${values} XP.";

  static String m52(min) => "La password deve avere almeno ${min} caratteri.";

  static String m53(count) => "Tutti · ${count}";

  static String m54(tier, count) => "${tier} · ${count}";

  static String m55(code) => "Codice ${code}";

  static String m56(name, date) => "Invitato da ${name} · scade il ${date}";

  static String m57(company) =>
      "Riceverà via email un codice per entrare in ${company}. Il codice vale 7 giorni.";

  static String m58(email) => "Revocare l\'invito per ${email}?";

  static String m59(email) => "Invito inviato a ${email}";

  static String m60(email, code) =>
      "Modalità demo, nessuna email inviata: dai a ${email} il codice ${code}";

  static String m61(count) =>
      "${Intl.plural(count, one: 'Assegnato a 1 persona', other: 'Assegnato a ${count} persone')}";

  static String m62(count) =>
      "${Intl.plural(count, one: '1 volta', other: '${count} volte')}";

  static String m63(level, points) => "Livello ${level} · ${points} XP";

  static String m64(level) => "Livello ${level}";

  static String m65(count) => "Libreria · ${count}";

  static String m66(date) => "Membro dal ${date}";

  static String m67(name) => "Team di ${name}";

  static String m68(count) =>
      "${Intl.plural(count, one: '1 membro', other: '${count} membri')}";

  static String m69(name) => "Per ${name}. Un admin valuterà la tua proposta.";

  static String m70(achievement) =>
      "“${achievement}” è stato approvato ed è nei tuoi traguardi";

  static String m71(actor, achievement, text) =>
      "${actor} ha commentato “${achievement}”: ${text}";

  static String m72(level) => "Hai raggiunto il livello ${level}";

  static String m73(actor, achievement) => "${actor} chiede “${achievement}”";

  static String m74(actor, achievement, member) =>
      "${actor} propone “${achievement}” per ${member}";

  static String m75(actor, achievement) =>
      "${actor} ti ha inviato “${achievement}”";

  static String m76(actor, achievement) =>
      "${actor} ha reagito a “${achievement}”";

  static String m77(xp, rank) =>
      "Questa settimana: +${xp} XP · posizione #${rank}";

  static String m78(achievement) => "“${achievement}” non è stato approvato";

  static String m79(achievement, reason) =>
      "“${achievement}” non è stato approvato: ${reason}";

  static String m80(company, achievement) =>
      "${company} ti ha rilasciato “${achievement}”";

  static String m81(count) =>
      "${Intl.plural(count, zero: 'Nessuna notifica da leggere', one: '1 notifica da leggere', other: '${count} notifiche da leggere')}";

  static String m82(shortcut) =>
      "Premi ${shortcut} per inviare un traguardo da qualsiasi schermata, oppure usa l\'icona nella barra dei menu.";

  static String m83(budget) =>
      "I traguardi verificati li rilascia la tua azienda: puoi richiederli dal catalogo. Quelli base li scambi con i colleghi, fino a ${budget} al mese.";

  static String m84(min) => "Almeno ${min} caratteri";

  static String m85(percent) => "${percent}%";

  static String m86(rank) => "#${rank}";

  static String m87(reason) => "Motivazione: ${reason}";

  static String m88(company) =>
      "Un admin di ${company} valuterà la tua richiesta.";

  static String m89(name) => "Proposto da ${name}";

  static String m90(role, company) => "${role} in ${company}";

  static String m91(days) =>
      "${Intl.plural(days, one: 'Manca 1 giorno', other: 'Mancano ${days} giorni')}";

  static String m92(start, end) => "${start} – ${end}";

  static String m93(rank, points) => "Sei #${rank} con ${points} XP";

  static String m94(name) => "Traguardo inviato a ${name}";

  static String m95(count) => "Inviati da te · ${count}";

  static String m96(count) =>
      "${Intl.plural(count, one: '1 inviato', other: '${count} inviati')}";

  static String m97(company) =>
      "Lo aggiunge a Licenze e certificazioni, con ${company} come ente emittente.";

  static String m98(company) => "Rilasciato da ${company}";

  static String m99(sender, name, description) =>
      "🤝 ${sender} mi ha assegnato il traguardo “${name}”.\n\n${description}\n\n#Scoreboard";

  static String m100(name, company, description) =>
      "🏆 Ho ottenuto il traguardo “${name}”, rilasciato da ${company}.\n\n${description}\n\n#Scoreboard";

  static String m101(time) => "Ultimo riconoscimento: ${time}";

  static String m102(received, sent) =>
      "${received} ricevuti · ${sent} inviati in 90 giorni";

  static String m103(name) => "“${name}” aggiunto alla libreria";

  static String m104(name) => "“${name}” eliminato";

  static String m105(count) =>
      "${Intl.plural(count, one: 'Ieri', other: '${count} giorni fa')}";

  static String m106(count) => "${count} h fa";

  static String m107(count) => "${count} min fa";

  static String m108(version) => "È disponibile la versione ${version}";

  static String m109(count) =>
      "${Intl.plural(count, one: '1 verificato', other: '${count} verificati')}";

  static String m110(version) => "Versione ${version}";

  static String m111(points, level) => "${points} XP al livello ${level}";

  static String m112(points) => "${points} XP";

  static String m113(name) => "${name} (tu)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountSubtitle": MessageLookupByLibrary.simpleMessage(
          "Dati di accesso. Nome, foto e copertina si modificano dal profilo.",
        ),
        "achievementDetailTitle":
            MessageLookupByLibrary.simpleMessage("Traguardo"),
        "achievementNamePlaceholder": MessageLookupByLibrary.simpleMessage(
          "Nome del traguardo",
        ),
        "achievementsCount": m0,
        "achievementsEmptyBody": MessageLookupByLibrary.simpleMessage(
          "Chiedi un traguardo verificato dal catalogo della tua azienda, oppure riconosci il lavoro di un collega: spesso è il modo migliore per iniziare.",
        ),
        "achievementsEmptyTitle": MessageLookupByLibrary.simpleMessage(
          "Il tuo primo traguardo ti aspetta",
        ),
        "achievementsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Ogni traguardo raggiunto lungo il percorso",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage(
          "I tuoi traguardi",
        ),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "Operazione non riuscita. Riprova.",
        ),
        "activityAchievementsIssued": m1,
        "activityAdminGranted": m2,
        "activityAdminRevoked": m3,
        "activityAnniversariesUpdated": MessageLookupByLibrary.simpleMessage(
          "ha cambiato le ricorrenze di servizio",
        ),
        "activityBrandUpdated": MessageLookupByLibrary.simpleMessage(
          "ha cambiato il colore o il logo dell\'azienda",
        ),
        "activityCatalogArchived": m4,
        "activityCatalogCreated": m5,
        "activityCatalogRestored": m6,
        "activityCatalogUpdated": m7,
        "activityEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessuna attività registrata.",
        ),
        "activityHint": MessageLookupByLibrary.simpleMessage(
          "Cosa hanno fatto admin e responsabili, dalla più recente. Non si può modificare.",
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
        "adminGroupCompany": MessageLookupByLibrary.simpleMessage("AZIENDA"),
        "adminGroupData": MessageLookupByLibrary.simpleMessage("DATI"),
        "adminGroupPeople": MessageLookupByLibrary.simpleMessage("PERSONE"),
        "adminGroupRecognition": MessageLookupByLibrary.simpleMessage(
          "RICONOSCIMENTI",
        ),
        "adminMode": MessageLookupByLibrary.simpleMessage("Modalità admin"),
        "adminModeHint": MessageLookupByLibrary.simpleMessage(
          "Gestisci i traguardi verificati dell\'azienda",
        ),
        "adminRevokeSelfAction":
            MessageLookupByLibrary.simpleMessage("Rinuncia"),
        "adminRevokeSelfBody": MessageLookupByLibrary.simpleMessage(
          "Uscirai dalla console e non potrai più gestire l\'azienda. Un altro amministratore potrà ridarti questi diritti.",
        ),
        "adminRevokeSelfTitle": MessageLookupByLibrary.simpleMessage(
          "Rinunciare ai diritti di amministratore?",
        ),
        "adminRevokedMessage": m26,
        "adminRole": MessageLookupByLibrary.simpleMessage("Amministratore"),
        "adminRoleTooltip": MessageLookupByLibrary.simpleMessage(
          "Può usare la console e gestire l\'azienda",
        ),
        "alreadyHasIt": MessageLookupByLibrary.simpleMessage("Lo ha già"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Già inviato a questo collega",
        ),
        "anniversariesBody": MessageLookupByLibrary.simpleMessage(
          "Un traguardo verificato a ogni anniversario di assunzione che festeggiate, assegnato in automatico.",
        ),
        "anniversariesEnabled": MessageLookupByLibrary.simpleMessage(
          "Festeggia gli anni di servizio",
        ),
        "anniversariesTitle": MessageLookupByLibrary.simpleMessage(
          "Anni di servizio",
        ),
        "anniversaryXp": m27,
        "anniversaryYears": m28,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Scegli l\'aspetto di Scoreboard",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Approva"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivia"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archiviato"),
        "assignButton": m29,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "Un messaggio per chi lo riceve",
        ),
        "assignNoteLabel": MessageLookupByLibrary.simpleMessage(
          "Nota (facoltativa)",
        ),
        "authCreateCompanySubtitle": MessageLookupByLibrary.simpleMessage(
          "Porta Scoreboard nella tua azienda: ne sarai l\'amministratore.",
        ),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Entra nello scoreboard della tua azienda.",
        ),
        "authCreateTitle": MessageLookupByLibrary.simpleMessage(
          "Crea il tuo account",
        ),
        "authJoinSubtitle": MessageLookupByLibrary.simpleMessage(
          "Usa il codice dell\'invito che hai ricevuto via email.",
        ),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Raccogli i traguardi rilasciati dalla tua azienda e riconosci il merito dei colleghi che fanno la differenza.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Accedi per vedere i tuoi traguardi.",
        ),
        "authTagline": MessageLookupByLibrary.simpleMessage(
          "Ogni traguardo,\nnero su bianco.",
        ),
        "authWelcomeBack": MessageLookupByLibrary.simpleMessage(
          "Ti diamo il bentornato",
        ),
        "bannerClay": MessageLookupByLibrary.simpleMessage("Argilla"),
        "bannerForest": MessageLookupByLibrary.simpleMessage("Foresta"),
        "bannerGold": MessageLookupByLibrary.simpleMessage("Oro"),
        "bannerGraphite": MessageLookupByLibrary.simpleMessage("Grafite"),
        "bannerOcean": MessageLookupByLibrary.simpleMessage("Oceano"),
        "bannerSand": MessageLookupByLibrary.simpleMessage("Sabbia"),
        "baseExplanation": m30,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Crea traguardi e inviali ai tuoi colleghi",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Una riga su di te e su cosa fai",
        ),
        "brandBody": m31,
        "brandColor": MessageLookupByLibrary.simpleMessage("Colore"),
        "brandDefault":
            MessageLookupByLibrary.simpleMessage("Oro di Scoreboard"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Anteprima"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Marchio"),
        "budgetRemaining": m32,
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Traguardo base",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Gira la card"),
        "cardFrom": m33,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("RILASCIATO DA"),
        "cardIssuedOn": m34,
        "cardReceivedOn": m35,
        "cardSentBy": MessageLookupByLibrary.simpleMessage("INVIATO DA"),
        "cardVerifiedAchievement": MessageLookupByLibrary.simpleMessage(
          "Traguardo verificato",
        ),
        "catalogDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Solo gli admin possono rilasciarlo, e chi lo riceve lo vede come verificato.",
        ),
        "catalogEmpty": MessageLookupByLibrary.simpleMessage(
          "Il catalogo è vuoto. Crea il primo traguardo.",
        ),
        "catalogPointsHint": MessageLookupByLibrary.simpleMessage(
          "Il valore decide la categoria: Bronzo sotto 100 XP, Argento da 100, Oro da 120, Platino da 140.",
        ),
        "catalogSaved":
            MessageLookupByLibrary.simpleMessage("Catalogo aggiornato"),
        "certCredentialId": m36,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "ha ottenuto il traguardo",
        ),
        "certIssuedBy": m37,
        "certPresentedTo":
            MessageLookupByLibrary.simpleMessage("Si certifica che"),
        "certTitle": MessageLookupByLibrary.simpleMessage(
          "CERTIFICATO DI TRAGUARDO",
        ),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Cambia password"),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Verifica aggiornamenti",
        ),
        "commentHint":
            MessageLookupByLibrary.simpleMessage("Scrivi un commento…"),
        "commentsCount": m38,
        "commonBack": MessageLookupByLibrary.simpleMessage("Indietro"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Annulla"),
        "commonClose": MessageLookupByLibrary.simpleMessage("Chiudi"),
        "commonCreate": MessageLookupByLibrary.simpleMessage("Crea"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Elimina"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Modifica"),
        "commonPreview": MessageLookupByLibrary.simpleMessage("ANTEPRIMA"),
        "commonRemove": MessageLookupByLibrary.simpleMessage("Rimuovi"),
        "commonRetry": MessageLookupByLibrary.simpleMessage("Riprova"),
        "commonSave": MessageLookupByLibrary.simpleMessage("Salva"),
        "commonSend": MessageLookupByLibrary.simpleMessage("Invia"),
        "communityCompanies": MessageLookupByLibrary.simpleMessage("Aziende"),
        "communityHiddenNotice": MessageLookupByLibrary.simpleMessage(
          "Non compari in questa classifica. Puoi cambiarlo in Impostazioni → Account.",
        ),
        "communityPeople": MessageLookupByLibrary.simpleMessage("Persone"),
        "communitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Scopri come ti posizioni rispetto agli altri",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Community"),
        "companyCatalog": MessageLookupByLibrary.simpleMessage(
          "Catalogo dell\'azienda",
        ),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "I traguardi verificati che puoi ottenere. Se pensi di meritarne uno, chiedilo.",
        ),
        "companyIndustryLabel": MessageLookupByLibrary.simpleMessage(
          "Settore (facoltativo)",
        ),
        "companyLocationLabel": MessageLookupByLibrary.simpleMessage(
          "Città (facoltativo)",
        ),
        "companyNameLabel": MessageLookupByLibrary.simpleMessage(
          "Nome dell\'azienda",
        ),
        "companyNameRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci il nome dell\'azienda",
        ),
        "companySince": m39,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Conferma"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Conferma nuova password",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage(
          "Registro attività",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Assegna"),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catalogo"),
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Azienda"),
        "consoleMembers": MessageLookupByLibrary.simpleMessage("Membri"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Report"),
        "consoleRequests": m40,
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Stagioni"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Statistiche"),
        "consoleSubtitle": m41,
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Team"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Crea account"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Chiunque nella tua azienda può inviarlo a un collega.",
        ),
        "createdBy": m42,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Creato da te"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Password attuale"),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci la password attuale",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Già decise"),
        "deleteSeasonBody": MessageLookupByLibrary.simpleMessage(
          "La sua classifica sparisce. I traguardi restano.",
        ),
        "deleteSeasonTitle": m43,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "I suoi membri resteranno senza team. I loro traguardi restano.",
        ),
        "deleteTeamTitle": m44,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Verrà rimosso dalla libreria. I colleghi che l\'hanno già ricevuto lo conservano.",
        ),
        "deleteTemplateTitle": m45,
        "demoAccount": m46,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "Cosa bisogna fare per meritarlo?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Aggiungi una breve descrizione",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Azienda"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Ottenuto il"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Esperienza"),
        "detailId": m47,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Inviato da"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Categoria"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Ottenuto"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Modifica traguardo",
        ),
        "editProfile": MessageLookupByLibrary.simpleMessage("Modifica profilo"),
        "editSeason": MessageLookupByLibrary.simpleMessage("Modifica stagione"),
        "editTeam": MessageLookupByLibrary.simpleMessage("Modifica team"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare l\'email. Riprova.",
        ),
        "emailUpdated":
            MessageLookupByLibrary.simpleMessage("Email aggiornata"),
        "emptyOpenCatalog": MessageLookupByLibrary.simpleMessage(
          "Apri il catalogo",
        ),
        "errorAlreadyMember": MessageLookupByLibrary.simpleMessage(
          "Questa persona ha già un account Scoreboard.",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "Hai già questo traguardo.",
        ),
        "errorAlreadySent": m48,
        "errorBudgetExhausted": m49,
        "errorCatalogPoints": m50,
        "errorCompanyNameTaken": MessageLookupByLibrary.simpleMessage(
          "Un\'azienda con questo nome è già su Scoreboard. Chiedi a uno dei suoi amministratori di invitarti.",
        ),
        "errorEmailNotSent": MessageLookupByLibrary.simpleMessage(
          "Non è stato possibile inviare l\'email d\'invito. Riprova più tardi.",
        ),
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "Esiste già un account con questa email.",
        ),
        "errorInvalidDates": MessageLookupByLibrary.simpleMessage(
          "La data di fine non può precedere quella di inizio.",
        ),
        "errorInvalidInviteCode": MessageLookupByLibrary.simpleMessage(
          "Il codice non è valido per questa email o è scaduto. Chiedi un nuovo invito a un amministratore.",
        ),
        "errorInvalidPoints": m51,
        "errorLastAdmin": MessageLookupByLibrary.simpleMessage(
          "L\'azienda deve avere almeno un amministratore.",
        ),
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Inserisci email e password.",
        ),
        "errorMissingFields": MessageLookupByLibrary.simpleMessage(
          "Compila tutti i campi obbligatori.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Inserisci nome e ruolo.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "Puoi inviare traguardi solo ai colleghi della tua azienda.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Solo gli admin dell\'azienda possono farlo.",
        ),
        "errorNotFound": MessageLookupByLibrary.simpleMessage(
          "Elemento non trovato.",
        ),
        "errorNotInTeam": MessageLookupByLibrary.simpleMessage(
          "Questa persona non fa parte del tuo team.",
        ),
        "errorNotManager": MessageLookupByLibrary.simpleMessage(
          "Solo i responsabili di un team possono farlo.",
        ),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "Non hai effettuato l\'accesso.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "Puoi eliminare solo i traguardi base che hai creato tu.",
        ),
        "errorPasswordTooShort": m52,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Hai già una richiesta in attesa per questo traguardo.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "Queste date si sovrappongono a un\'altra stagione.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "Questo traguardo base non esiste più.",
        ),
        "errorWrongCredentials": MessageLookupByLibrary.simpleMessage(
          "Email o password errate.",
        ),
        "errorWrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
          "La password attuale non è corretta.",
        ),
        "evidenceLink": MessageLookupByLibrary.simpleMessage("Apri la prova"),
        "evidenceUrlLabel": MessageLookupByLibrary.simpleMessage(
          "Link a una prova (facoltativo)",
        ),
        "experienceNote": MessageLookupByLibrary.simpleMessage(
          "I traguardi base valgono meno di quelli verificati rilasciati dalla tua azienda.",
        ),
        "exportCsv": MessageLookupByLibrary.simpleMessage("Esporta CSV"),
        "exportError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare il file. Riprova.",
        ),
        "exportJson": MessageLookupByLibrary.simpleMessage("Esporta JSON"),
        "exportMenu": MessageLookupByLibrary.simpleMessage("Esporta"),
        "exportOpenBadge": MessageLookupByLibrary.simpleMessage(
          "Open Badge (JSON)",
        ),
        "exportOpenBadgeHint": MessageLookupByLibrary.simpleMessage(
          "Credenziale Open Badges 3.0. La firma digitale arriverà con il backend.",
        ),
        "exportPdf": MessageLookupByLibrary.simpleMessage("Certificato PDF"),
        "exportSaved": MessageLookupByLibrary.simpleMessage("File salvato"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("ha ottenuto"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora niente in bacheca.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "I traguardi dei tuoi colleghi, da festeggiare insieme",
        ),
        "feedTitle":
            MessageLookupByLibrary.simpleMessage("Bacheca dell\'azienda"),
        "fieldAchievement": MessageLookupByLibrary.simpleMessage("Traguardo"),
        "fieldBio": MessageLookupByLibrary.simpleMessage("Bio"),
        "fieldColleague": MessageLookupByLibrary.simpleMessage("Collega"),
        "fieldCover": MessageLookupByLibrary.simpleMessage("Copertina"),
        "fieldDescription": MessageLookupByLibrary.simpleMessage("Descrizione"),
        "fieldEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "fieldExperience": MessageLookupByLibrary.simpleMessage("Esperienza"),
        "fieldFullName": MessageLookupByLibrary.simpleMessage("Nome e cognome"),
        "fieldIcon": MessageLookupByLibrary.simpleMessage("Icona"),
        "fieldMessageOptional": MessageLookupByLibrary.simpleMessage(
          "Messaggio (facoltativo)",
        ),
        "fieldName": MessageLookupByLibrary.simpleMessage("Nome"),
        "fieldPhoto": MessageLookupByLibrary.simpleMessage("Foto"),
        "fieldRole": MessageLookupByLibrary.simpleMessage("Ruolo"),
        "filterAll": m53,
        "filterTier": m54,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Clicca la card per girarla",
        ),
        "fromAColleague": MessageLookupByLibrary.simpleMessage("Da un collega"),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Qualcosa è andato storto. Riprova.",
        ),
        "hapticsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Tieni premuta una card per girarla, e senti lo scatto sul trackpad Force Touch.",
        ),
        "hapticsTitle": MessageLookupByLibrary.simpleMessage("Feedback aptico"),
        "hidePassword":
            MessageLookupByLibrary.simpleMessage("Nascondi password"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Inserisci un indirizzo email valido",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Inserisci un link http(s) valido",
        ),
        "inviteCodeChip": m55,
        "inviteCodeLabel":
            MessageLookupByLibrary.simpleMessage("Codice d\'invito"),
        "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci il codice che hai ricevuto",
        ),
        "inviteDetails": m56,
        "inviteDialogBody": m57,
        "inviteDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Invita un collega",
        ),
        "inviteEmailHint": MessageLookupByLibrary.simpleMessage(
          "La stessa email a cui è arrivato l\'invito",
        ),
        "inviteExpired": MessageLookupByLibrary.simpleMessage("Scaduto"),
        "inviteMember": MessageLookupByLibrary.simpleMessage("Invita"),
        "inviteResend": MessageLookupByLibrary.simpleMessage("Invia di nuovo"),
        "inviteRevoke": MessageLookupByLibrary.simpleMessage("Revoca"),
        "inviteRevokeBody": MessageLookupByLibrary.simpleMessage(
          "Il codice smetterà di funzionare. Potrai invitare di nuovo questa persona in seguito.",
        ),
        "inviteRevokeTitle": m58,
        "inviteRevoked":
            MessageLookupByLibrary.simpleMessage("Invito revocato"),
        "inviteSend": MessageLookupByLibrary.simpleMessage("Invia invito"),
        "inviteSent": m59,
        "inviteSentDemo": m60,
        "invitesEmpty": MessageLookupByLibrary.simpleMessage(
          "Nessun invito in attesa.",
        ),
        "issuedCount": m61,
        "issuedTimes": m62,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verificato"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("Sistema"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Lingua"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Classifica"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Tra colleghi"),
        "levelAndXp": m63,
        "levelN": m64,
        "libraryCount": m65,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun traguardo base. Crea il primo!",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Qualcosa è andato storto durante il caricamento dei dati.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Segna tutte come lette",
        ),
        "memberSince": m66,
        "memberTeamLabel": m67,
        "membersCount": m68,
        "membersHint": MessageLookupByLibrary.simpleMessage(
          "Invita le persone nell\'azienda e scegli chi può gestirla.",
        ),
        "membersWithoutTeam":
            MessageLookupByLibrary.simpleMessage("Senza team"),
        "menuLabel": MessageLookupByLibrary.simpleMessage("MENU"),
        "messageHint": MessageLookupByLibrary.simpleMessage(
          "Spiega perché se lo merita",
        ),
        "myRequests": MessageLookupByLibrary.simpleMessage("Le tue richieste"),
        "nameHint": MessageLookupByLibrary.simpleMessage("es. Team Player"),
        "nameRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci il tuo nome",
        ),
        "navAchievements": MessageLookupByLibrary.simpleMessage("Traguardi"),
        "navBaseAchievements": MessageLookupByLibrary.simpleMessage(
          "Traguardi base",
        ),
        "navCommunity": MessageLookupByLibrary.simpleMessage("Community"),
        "navConsole": MessageLookupByLibrary.simpleMessage("Console azienda"),
        "navFeed": MessageLookupByLibrary.simpleMessage("Bacheca"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profilo"),
        "navRequests": MessageLookupByLibrary.simpleMessage("Richieste"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "navTeam": MessageLookupByLibrary.simpleMessage("Il mio team"),
        "navYourCompany":
            MessageLookupByLibrary.simpleMessage("La tua azienda"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Nuovo traguardo base",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Nuovo traguardo verificato",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage("Nuova password"),
        "newSeason": MessageLookupByLibrary.simpleMessage("Nuova stagione"),
        "newTeam": MessageLookupByLibrary.simpleMessage("Nuovo team"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "Nessun traguardo in questa categoria.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun traguardo.",
        ),
        "noManager":
            MessageLookupByLibrary.simpleMessage("Nessun responsabile"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Nessun risultato per la tua ricerca.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("Nessun team"),
        "nominateDialogSubtitle": m69,
        "nominateDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Proponi un traguardo verificato",
        ),
        "nominateMessageHint": MessageLookupByLibrary.simpleMessage(
          "Perché se lo merita?",
        ),
        "nominateSent": MessageLookupByLibrary.simpleMessage(
          "Proposta inviata agli admin",
        ),
        "noteAuthorFallback":
            MessageLookupByLibrary.simpleMessage("Un collega"),
        "notifApprovedBody": m70,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Richiesta approvata",
        ),
        "notifCommentBody": m71,
        "notifCommentTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo commento"),
        "notifLevelUpBody": m72,
        "notifLevelUpTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo livello!"),
        "notifNewRequestBody": m73,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova richiesta",
        ),
        "notifNominationBody": m74,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova proposta",
        ),
        "notifPeerBody": m75,
        "notifPeerTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo traguardo"),
        "notifReactionBody": m76,
        "notifReactionTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova reazione",
        ),
        "notifRecapBody": m77,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Il tuo riepilogo settimanale",
        ),
        "notifRejectedBody": m78,
        "notifRejectedBodyReason": m79,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Richiesta respinta",
        ),
        "notifVerifiedBody": m80,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Traguardo verificato",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "Nessuna notifica, per ora.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Apri le notifiche",
        ),
        "notificationsTitle": MessageLookupByLibrary.simpleMessage("Notifiche"),
        "notificationsUnread": m81,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Inizia"),
        "onboardingFastBody": m82,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Vai veloce"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "In bacheca vedi i traguardi dei colleghi e puoi reagire e commentare. Le notifiche ti avvisano quando succede qualcosa che ti riguarda.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Festeggiate insieme",
        ),
        "onboardingKindsBody": m83,
        "onboardingKindsTitle": MessageLookupByLibrary.simpleMessage(
          "Verificati e tra colleghi",
        ),
        "onboardingNext": MessageLookupByLibrary.simpleMessage("Avanti"),
        "onboardingReplay": MessageLookupByLibrary.simpleMessage(
          "Rivedi l\'introduzione",
        ),
        "onboardingSkip": MessageLookupByLibrary.simpleMessage("Salta"),
        "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
          "Qui raccogli i traguardi che ottieni al lavoro, sotto forma di card da collezionare. Passaci sopra con il mouse e girale per vedere chi le ha rilasciate.",
        ),
        "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
          "Ti diamo il benvenuto in Scoreboard",
        ),
        "passwordChangeError": MessageLookupByLibrary.simpleMessage(
          "Impossibile cambiare la password. Riprova.",
        ),
        "passwordChanged": MessageLookupByLibrary.simpleMessage(
          "Password cambiata",
        ),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordMinLength": m84,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci la password",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Le password non coincidono",
        ),
        "pendingInvites":
            MessageLookupByLibrary.simpleMessage("Inviti in attesa"),
        "pendingSection": MessageLookupByLibrary.simpleMessage("In attesa"),
        "percentValue": m85,
        "periodAll": MessageLookupByLibrary.simpleMessage("Da sempre"),
        "periodLast30":
            MessageLookupByLibrary.simpleMessage("Ultimi 30 giorni"),
        "periodQuarter":
            MessageLookupByLibrary.simpleMessage("Questo trimestre"),
        "periodYear": MessageLookupByLibrary.simpleMessage("Quest\'anno"),
        "personalDataBody": MessageLookupByLibrary.simpleMessage(
          "Tutto ciò che Scoreboard conserva su una persona, in JSON, per le richieste sulla protezione dei dati.",
        ),
        "personalDataPerson": MessageLookupByLibrary.simpleMessage("Persona"),
        "personalDataTitle":
            MessageLookupByLibrary.simpleMessage("Dati personali"),
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Scegli un traguardo dal catalogo.",
        ),
        "pickDates": MessageLookupByLibrary.simpleMessage("Scegli le date"),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "I colleghi della tua azienda ti vedono comunque nella classifica del team.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "Mostrami nella classifica Community",
        ),
        "privacySection": MessageLookupByLibrary.simpleMessage("Privacy"),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare il profilo. Riprova.",
        ),
        "profileUpdated": MessageLookupByLibrary.simpleMessage(
          "Profilo aggiornato",
        ),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Nascosta"),
        "rankValue": m86,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Festeggio"),
        "reactionInsightful": MessageLookupByLibrary.simpleMessage("Geniale"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Mi piace"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Adoro"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Traguardi recenti",
        ),
        "registerCreateCompany": MessageLookupByLibrary.simpleMessage(
          "Crea un\'azienda",
        ),
        "registerJoin": MessageLookupByLibrary.simpleMessage(
          "Entra in un\'azienda",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Respingi"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Respingere la richiesta?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Motivazione (facoltativa)",
        ),
        "rejectionReason": m87,
        "replaceImage": MessageLookupByLibrary.simpleMessage(
          "Sostituisci immagine",
        ),
        "reportAchievementsBody": MessageLookupByLibrary.simpleMessage(
          "Una riga per traguardo ricevuto: data, persona, team, tipo, XP e chi l\'ha dato.",
        ),
        "reportAchievementsTitle": MessageLookupByLibrary.simpleMessage(
          "Traguardi",
        ),
        "reportPeopleBody": MessageLookupByLibrary.simpleMessage(
          "Una riga per persona: traguardi ricevuti e inviati, XP e ultimo riconoscimento.",
        ),
        "reportPeopleTitle": MessageLookupByLibrary.simpleMessage("Persone"),
        "reportPeriod": MessageLookupByLibrary.simpleMessage("Periodo"),
        "reportSaved": MessageLookupByLibrary.simpleMessage("Report salvato"),
        "reportsHint": MessageLookupByLibrary.simpleMessage(
          "Per le valutazioni e i sistemi HR. Ogni esportazione finisce nel registro attività.",
        ),
        "requestAction": MessageLookupByLibrary.simpleMessage("Richiedi"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Richiesta approvata",
        ),
        "requestDialogSubtitle": m88,
        "requestDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Richiedi un traguardo",
        ),
        "requestMessage": MessageLookupByLibrary.simpleMessage("Messaggio"),
        "requestMessageHint": MessageLookupByLibrary.simpleMessage(
          "Cosa hai fatto per meritarlo?",
        ),
        "requestMessageRequired": MessageLookupByLibrary.simpleMessage(
          "Scrivi un messaggio",
        ),
        "requestNominatedBy": m89,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Richiesta respinta",
        ),
        "requestSent":
            MessageLookupByLibrary.simpleMessage("Richiesta inviata"),
        "requestsEmpty":
            MessageLookupByLibrary.simpleMessage("Nessuna richiesta."),
        "restore": MessageLookupByLibrary.simpleMessage("Ripristina"),
        "roleAtCompany": m90,
        "roleRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci il tuo ruolo",
        ),
        "saveProfile": MessageLookupByLibrary.simpleMessage("Salva profilo"),
        "searchAchievementsHint": MessageLookupByLibrary.simpleMessage(
          "Cerca tra i tuoi traguardi",
        ),
        "searchCompaniesHint": MessageLookupByLibrary.simpleMessage(
          "Cerca per nome o settore",
        ),
        "searchPeopleHint": MessageLookupByLibrary.simpleMessage(
          "Cerca per nome, ruolo o azienda",
        ),
        "seasonActive": MessageLookupByLibrary.simpleMessage("In corso"),
        "seasonCurrent":
            MessageLookupByLibrary.simpleMessage("Stagione in corso"),
        "seasonDates": MessageLookupByLibrary.simpleMessage("Date"),
        "seasonDaysLeft": m91,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Stagione eliminata",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Conclusa"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Nome"),
        "seasonNameHint":
            MessageLookupByLibrary.simpleMessage("es. Autunno 2026"),
        "seasonRange": m92,
        "seasonSaved": MessageLookupByLibrary.simpleMessage("Stagione salvata"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("In arrivo"),
        "seasonYourRank": m93,
        "seasonsEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessuna stagione.",
        ),
        "seasonsHint": MessageLookupByLibrary.simpleMessage(
          "Ogni stagione ha una sua classifica, che conta gli XP ottenuti tra le sue date. Le stagioni non possono sovrapporsi.",
        ),
        "selectAll": MessageLookupByLibrary.simpleMessage("Seleziona tutti"),
        "sendAchievement":
            MessageLookupByLibrary.simpleMessage("Invia traguardo"),
        "sendAnAchievement": MessageLookupByLibrary.simpleMessage(
          "Invia un traguardo",
        ),
        "sendDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Riconosci il merito di un collega con uno dei tuoi traguardi base.",
        ),
        "sendError": MessageLookupByLibrary.simpleMessage(
          "Impossibile inviare il traguardo. Riprova.",
        ),
        "sendLoadError": MessageLookupByLibrary.simpleMessage(
          "Impossibile caricare i tuoi colleghi. Riprova.",
        ),
        "sendNoColleagues": MessageLookupByLibrary.simpleMessage(
          "Nella tua azienda non ci sono ancora colleghi.",
        ),
        "sendNoTemplates": MessageLookupByLibrary.simpleMessage(
          "Crea prima un traguardo base.",
        ),
        "sendPreviewHint": MessageLookupByLibrary.simpleMessage(
          "Scegli un traguardo per vedere come apparirà.",
        ),
        "sendSuccess": m94,
        "sentByYouCount": m95,
        "sentCount": m96,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "Non hai ancora inviato traguardi. Scegline uno dalla libreria e fai felice un collega.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("a"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Sessione"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("Informazioni"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
        "settingsAppearance": MessageLookupByLibrary.simpleMessage("Aspetto"),
        "settingsSavedMessage": MessageLookupByLibrary.simpleMessage(
          "Impostazioni salvate",
        ),
        "shareAddToProfile": MessageLookupByLibrary.simpleMessage(
          "Aggiungi al profilo",
        ),
        "shareAddToProfileHint": m97,
        "shareCopyText": MessageLookupByLibrary.simpleMessage("Copia testo"),
        "shareDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Pubblica un post o aggiungilo al tuo profilo LinkedIn.",
        ),
        "shareImageHeadline": MessageLookupByLibrary.simpleMessage(
          "TRAGUARDO SBLOCCATO",
        ),
        "shareImageHint": MessageLookupByLibrary.simpleMessage(
          "LinkedIn non permette di allegare immagini da un link: salvala e aggiungila al post.",
        ),
        "shareImageIssuedBy": m98,
        "shareImageSaved":
            MessageLookupByLibrary.simpleMessage("Immagine salvata"),
        "shareOnLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Condividi su LinkedIn",
        ),
        "shareOpenError": MessageLookupByLibrary.simpleMessage(
          "Impossibile aprire LinkedIn.",
        ),
        "shareOpenLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Pubblica su LinkedIn",
        ),
        "shareOpened": MessageLookupByLibrary.simpleMessage(
          "Testo copiato: se LinkedIn non lo inserisce, incollalo nel post.",
        ),
        "sharePostLabel":
            MessageLookupByLibrary.simpleMessage("Testo del post"),
        "sharePostPeer": m99,
        "sharePostVerified": m100,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare l\'immagine. Riprova.",
        ),
        "shareSaveImage":
            MessageLookupByLibrary.simpleMessage("Salva immagine"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Testo copiato negli appunti",
        ),
        "shortcutFlipCard": MessageLookupByLibrary.simpleMessage(
          "Gira la card selezionata",
        ),
        "shortcutGoToPage": MessageLookupByLibrary.simpleMessage(
          "Vai alla pagina 1–8",
        ),
        "shortcutsSection": MessageLookupByLibrary.simpleMessage(
          "Scorciatoie da tastiera",
        ),
        "showArchived":
            MessageLookupByLibrary.simpleMessage("Mostra archiviati"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Mostra password"),
        "signIn": MessageLookupByLibrary.simpleMessage("Accedi"),
        "signOut": MessageLookupByLibrary.simpleMessage("Esci"),
        "signOutDescription": MessageLookupByLibrary.simpleMessage(
          "Esci da Scoreboard su questo computer.",
        ),
        "signOutError": MessageLookupByLibrary.simpleMessage(
          "Impossibile uscire. Riprova.",
        ),
        "sortLabel": MessageLookupByLibrary.simpleMessage("Ordina"),
        "sortName": MessageLookupByLibrary.simpleMessage("Nome (A–Z)"),
        "sortNewest": MessageLookupByLibrary.simpleMessage("Più recenti"),
        "sortOldest": MessageLookupByLibrary.simpleMessage("Meno recenti"),
        "sortPoints": MessageLookupByLibrary.simpleMessage("Più XP"),
        "statAchievements": MessageLookupByLibrary.simpleMessage("Traguardi"),
        "statCompanyRank": MessageLookupByLibrary.simpleMessage(
          "Posizione in azienda",
        ),
        "statGlobalRank":
            MessageLookupByLibrary.simpleMessage("Posizione globale"),
        "statMembers": MessageLookupByLibrary.simpleMessage("Membri"),
        "statTotalXp": MessageLookupByLibrary.simpleMessage("XP totali"),
        "statVerified": MessageLookupByLibrary.simpleMessage("Verificati"),
        "statYourRank":
            MessageLookupByLibrary.simpleMessage("La tua posizione"),
        "statsActiveSenders": MessageLookupByLibrary.simpleMessage(
          "Persone che riconoscono",
        ),
        "statsCoverage": MessageLookupByLibrary.simpleMessage(
          "Riconosciuti negli ultimi 30 giorni",
        ),
        "statsIssuedThisMonth": MessageLookupByLibrary.simpleMessage(
          "Verificati questo mese",
        ),
        "statsMonthlyChart": MessageLookupByLibrary.simpleMessage(
          "Traguardi negli ultimi 6 mesi",
        ),
        "statsNoData": MessageLookupByLibrary.simpleMessage(
          "Nessun dato, per ora.",
        ),
        "statsPeerThisMonth": MessageLookupByLibrary.simpleMessage(
          "Tra colleghi questo mese",
        ),
        "statsTopCatalog":
            MessageLookupByLibrary.simpleMessage("Più assegnati"),
        "statsTopSenders": MessageLookupByLibrary.simpleMessage(
          "Chi riconosce di più",
        ),
        "statsTopSendersHint": MessageLookupByLibrary.simpleMessage(
          "Traguardi base inviati negli ultimi 90 giorni.",
        ),
        "statsUnderRecognized": MessageLookupByLibrary.simpleMessage(
          "Da riconoscere",
        ),
        "statsUnderRecognizedHint": MessageLookupByLibrary.simpleMessage(
          "Chi ha ricevuto meno traguardi negli ultimi 90 giorni.",
        ),
        "statusApproved": MessageLookupByLibrary.simpleMessage("Approvata"),
        "statusPending": MessageLookupByLibrary.simpleMessage("In attesa"),
        "statusRejected": MessageLookupByLibrary.simpleMessage("Respinta"),
        "submitRequest":
            MessageLookupByLibrary.simpleMessage("Invia richiesta"),
        "teamDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Team eliminato",
        ),
        "teamEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessuno nel tuo team.",
        ),
        "teamLastRecognized": m101,
        "teamLeaderboard": MessageLookupByLibrary.simpleMessage(
          "Classifica del team",
        ),
        "teamManager": MessageLookupByLibrary.simpleMessage("Responsabile"),
        "teamMemberActivity": m102,
        "teamName": MessageLookupByLibrary.simpleMessage("Nome del team"),
        "teamNeverRecognized": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun riconoscimento",
        ),
        "teamNoRecent": MessageLookupByLibrary.simpleMessage(
          "Niente da oltre 30 giorni",
        ),
        "teamNominate": MessageLookupByLibrary.simpleMessage("Proponi"),
        "teamNominateTooltip": MessageLookupByLibrary.simpleMessage(
          "Proponi un traguardo verificato",
        ),
        "teamSaved": MessageLookupByLibrary.simpleMessage("Team salvato"),
        "teamStatNeedAttention":
            MessageLookupByLibrary.simpleMessage("Da seguire"),
        "teamStatReceived30": MessageLookupByLibrary.simpleMessage(
          "Ricevuti in 30 giorni",
        ),
        "teamSubtitle": MessageLookupByLibrary.simpleMessage(
          "Come viene riconosciuto il lavoro del tuo team",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun team. Crea il primo.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Ogni team ha un responsabile, che vede come vengono riconosciuti i suoi membri e può proporre per loro traguardi verificati.",
        ),
        "templateAdded": m103,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Impossibile creare il traguardo. Riprova.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Impossibile eliminare il traguardo. Riprova.",
        ),
        "templateDeleted": m104,
        "templateNameRequired": MessageLookupByLibrary.simpleMessage(
          "Dagli un nome",
        ),
        "themeDark": MessageLookupByLibrary.simpleMessage("Scuro"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Chiaro"),
        "themeTitle": MessageLookupByLibrary.simpleMessage("Tema"),
        "tierBronze": MessageLookupByLibrary.simpleMessage("Bronzo"),
        "tierGold": MessageLookupByLibrary.simpleMessage("Oro"),
        "tierPeer": MessageLookupByLibrary.simpleMessage("Colleghi"),
        "tierPlatinum": MessageLookupByLibrary.simpleMessage("Platino"),
        "tierSilver": MessageLookupByLibrary.simpleMessage("Argento"),
        "timeDays": m105,
        "timeHours": m106,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Adesso"),
        "timeMinutes": m107,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("I migliori"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Apri Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Esci da Scoreboard"),
        "upToDate":
            MessageLookupByLibrary.simpleMessage("Hai l\'ultima versione."),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Scaricala dalla pagina della release su GitHub.",
        ),
        "updateAvailableTitle": m108,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "Impossibile verificare gli aggiornamenti.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Scarica"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Più tardi"),
        "updatesSection": MessageLookupByLibrary.simpleMessage("Aggiornamenti"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Carica immagine"),
        "uploadLogo": MessageLookupByLibrary.simpleMessage("Carica logo"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Carica foto"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Usalo"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Verificato dall\'azienda",
        ),
        "verifiedCount": m109,
        "versionLabel": m110,
        "workEmail": MessageLookupByLibrary.simpleMessage("Email di lavoro"),
        "xpToNextLevel": m111,
        "xpValue": m112,
        "youLabel": MessageLookupByLibrary.simpleMessage("(tu)"),
        "youSuffix": m113,
      };
}
