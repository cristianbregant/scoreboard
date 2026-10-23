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

  static String m1(count) =>
      "${Intl.plural(count, zero: 'Assegna', one: 'Assegna a 1 persona', other: 'Assegna a ${count} persone')}";

  static String m2(maxPoints) =>
      "I traguardi base si scambiano tra colleghi e valgono fino a ${maxPoints} XP. Quelli verificati li rilascia solo la tua azienda. Puoi inviare ogni traguardo base allo stesso collega una sola volta.";

  static String m3(remaining, budget) =>
      "${remaining} di ${budget} invii rimasti questo mese";

  static String m4(name) => "Da ${name}";

  static String m5(date) => "Rilasciato il ${date}";

  static String m6(date) => "Ricevuto il ${date}";

  static String m7(id) => "ID credenziale: ${id}";

  static String m8(company, date) => "Rilasciato da ${company} il ${date}";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'Commenta', one: '1 commento', other: '${count} commenti')}";

  static String m10(year) => "Dal ${year}";

  static String m11(count) => "Richieste · ${count}";

  static String m12(company) => "Gestisci i traguardi verificati di ${company}";

  static String m13(name) => "Di ${name}";

  static String m14(name) => "Eliminare “${name}”?";

  static String m15(email, password) => "Account demo: ${email} / ${password}";

  static String m16(id) => "ID ${id}";

  static String m17(template, colleague) =>
      "Hai già inviato “${template}” a ${colleague}.";

  static String m18(budget) =>
      "Hai già inviato i ${budget} traguardi di questo mese. Il budget si rinnova il primo del mese.";

  static String m19(min, max) =>
      "Il valore deve essere tra ${min} e ${max} XP.";

  static String m20(values) => "I traguardi base possono valere ${values} XP.";

  static String m21(min) => "La password deve avere almeno ${min} caratteri.";

  static String m22(count) => "Tutti · ${count}";

  static String m23(tier, count) => "${tier} · ${count}";

  static String m24(count) =>
      "${Intl.plural(count, one: 'Assegnato a 1 persona', other: 'Assegnato a ${count} persone')}";

  static String m25(count) =>
      "${Intl.plural(count, one: '1 volta', other: '${count} volte')}";

  static String m26(level, points) => "Livello ${level} · ${points} XP";

  static String m27(level) => "Livello ${level}";

  static String m28(count) => "Libreria · ${count}";

  static String m29(date) => "Membro dal ${date}";

  static String m30(count) =>
      "${Intl.plural(count, one: '1 membro', other: '${count} membri')}";

  static String m31(achievement) =>
      "“${achievement}” è stato approvato ed è nei tuoi traguardi";

  static String m32(actor, achievement, text) =>
      "${actor} ha commentato “${achievement}”: ${text}";

  static String m33(level) => "Hai raggiunto il livello ${level}";

  static String m34(actor, achievement) => "${actor} chiede “${achievement}”";

  static String m35(actor, achievement) =>
      "${actor} ti ha inviato “${achievement}”";

  static String m36(actor, achievement) =>
      "${actor} ha reagito a “${achievement}”";

  static String m37(xp, rank) =>
      "Questa settimana: +${xp} XP · posizione #${rank}";

  static String m38(achievement) => "“${achievement}” non è stato approvato";

  static String m39(achievement, reason) =>
      "“${achievement}” non è stato approvato: ${reason}";

  static String m40(company, achievement) =>
      "${company} ti ha rilasciato “${achievement}”";

  static String m41(shortcut) =>
      "Premi ${shortcut} per inviare un traguardo da qualsiasi schermata, oppure usa l\'icona nella barra dei menu.";

  static String m42(budget) =>
      "I traguardi verificati li rilascia la tua azienda: puoi richiederli dal catalogo. Quelli base li scambi con i colleghi, fino a ${budget} al mese.";

  static String m43(min) => "Almeno ${min} caratteri";

  static String m44(percent) => "${percent}%";

  static String m45(rank) => "#${rank}";

  static String m46(reason) => "Motivazione: ${reason}";

  static String m47(company) =>
      "Un admin di ${company} valuterà la tua richiesta.";

  static String m48(role, company) => "${role} in ${company}";

  static String m49(name) => "Traguardo inviato a ${name}";

  static String m50(count) => "Inviati da te · ${count}";

  static String m51(count) =>
      "${Intl.plural(count, one: '1 inviato', other: '${count} inviati')}";

  static String m52(company) =>
      "Lo aggiunge a Licenze e certificazioni, con ${company} come ente emittente.";

  static String m53(company) => "Rilasciato da ${company}";

  static String m54(sender, name, description) =>
      "🤝 ${sender} mi ha assegnato il traguardo “${name}”.\n\n${description}\n\n#Scoreboard";

  static String m55(name, company, description) =>
      "🏆 Ho ottenuto il traguardo “${name}”, rilasciato da ${company}.\n\n${description}\n\n#Scoreboard";

  static String m56(name) => "“${name}” aggiunto alla libreria";

  static String m57(name) => "“${name}” eliminato";

  static String m58(count) =>
      "${Intl.plural(count, one: 'Ieri', other: '${count} giorni fa')}";

  static String m59(count) => "${count} h fa";

  static String m60(count) => "${count} min fa";

  static String m61(version) => "È disponibile la versione ${version}";

  static String m62(count) =>
      "${Intl.plural(count, one: '1 verificato', other: '${count} verificati')}";

  static String m63(version) => "Versione ${version}";

  static String m64(points, level) => "${points} XP al livello ${level}";

  static String m65(points) => "${points} XP";

  static String m66(name) => "${name} (tu)";

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
        "alreadyHasIt": MessageLookupByLibrary.simpleMessage("Lo ha già"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Già inviato a questo collega",
        ),
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Scegli l\'aspetto di Scoreboard",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Approva"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivia"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archiviato"),
        "assignButton": m1,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "Un messaggio per chi lo riceve",
        ),
        "assignNoteLabel": MessageLookupByLibrary.simpleMessage(
          "Nota (facoltativa)",
        ),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Entra nello scoreboard della tua azienda.",
        ),
        "authCreateTitle": MessageLookupByLibrary.simpleMessage(
          "Crea il tuo account",
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
        "baseExplanation": m2,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Crea traguardi e inviali ai tuoi colleghi",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Una riga su di te e su cosa fai",
        ),
        "budgetRemaining": m3,
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Traguardo base",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Gira la card"),
        "cardFrom": m4,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("RILASCIATO DA"),
        "cardIssuedOn": m5,
        "cardReceivedOn": m6,
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
        "certCredentialId": m7,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "ha ottenuto il traguardo",
        ),
        "certIssuedBy": m8,
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
        "chooseCompany": MessageLookupByLibrary.simpleMessage(
          "Scegli la tua azienda",
        ),
        "commentHint":
            MessageLookupByLibrary.simpleMessage("Scrivi un commento…"),
        "commentsCount": m9,
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
        "companySince": m10,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Conferma"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Conferma nuova password",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Assegna"),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catalogo"),
        "consoleRequests": m11,
        "consoleStats": MessageLookupByLibrary.simpleMessage("Statistiche"),
        "consoleSubtitle": m12,
        "createAccount": MessageLookupByLibrary.simpleMessage("Crea account"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Chiunque nella tua azienda può inviarlo a un collega.",
        ),
        "createdBy": m13,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Creato da te"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Password attuale"),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci la password attuale",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Già decise"),
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Verrà rimosso dalla libreria. I colleghi che l\'hanno già ricevuto lo conservano.",
        ),
        "deleteTemplateTitle": m14,
        "demoAccount": m15,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "Cosa bisogna fare per meritarlo?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Aggiungi una breve descrizione",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Azienda"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Ottenuto il"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Esperienza"),
        "detailId": m16,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Inviato da"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Categoria"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Ottenuto"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Modifica traguardo",
        ),
        "editProfile": MessageLookupByLibrary.simpleMessage("Modifica profilo"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare l\'email. Riprova.",
        ),
        "emailUpdated":
            MessageLookupByLibrary.simpleMessage("Email aggiornata"),
        "emptyOpenCatalog": MessageLookupByLibrary.simpleMessage(
          "Apri il catalogo",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "Hai già questo traguardo.",
        ),
        "errorAlreadySent": m17,
        "errorBudgetExhausted": m18,
        "errorCatalogPoints": m19,
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "Esiste già un account con questa email.",
        ),
        "errorInvalidPoints": m20,
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
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "Non hai effettuato l\'accesso.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "Puoi eliminare solo i traguardi base che hai creato tu.",
        ),
        "errorPasswordTooShort": m21,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Hai già una richiesta in attesa per questo traguardo.",
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
        "exportError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare il file. Riprova.",
        ),
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
        "filterAll": m22,
        "filterTier": m23,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Clicca la card per girarla",
        ),
        "fromAColleague": MessageLookupByLibrary.simpleMessage("Da un collega"),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Qualcosa è andato storto. Riprova.",
        ),
        "hidePassword":
            MessageLookupByLibrary.simpleMessage("Nascondi password"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Inserisci un indirizzo email valido",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Inserisci un link http(s) valido",
        ),
        "issuedCount": m24,
        "issuedTimes": m25,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verificato"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("Sistema"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Lingua"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Classifica"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Tra colleghi"),
        "levelAndXp": m26,
        "levelN": m27,
        "libraryCount": m28,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun traguardo base. Crea il primo!",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Qualcosa è andato storto durante il caricamento dei dati.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Segna tutte come lette",
        ),
        "memberSince": m29,
        "membersCount": m30,
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
        "navSettings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
        "navYourCompany":
            MessageLookupByLibrary.simpleMessage("La tua azienda"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Nuovo traguardo base",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Nuovo traguardo verificato",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage("Nuova password"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "Nessun traguardo in questa categoria.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun traguardo.",
        ),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Nessun risultato per la tua ricerca.",
        ),
        "noteAuthorFallback":
            MessageLookupByLibrary.simpleMessage("Un collega"),
        "notifApprovedBody": m31,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Richiesta approvata",
        ),
        "notifCommentBody": m32,
        "notifCommentTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo commento"),
        "notifLevelUpBody": m33,
        "notifLevelUpTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo livello!"),
        "notifNewRequestBody": m34,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova richiesta",
        ),
        "notifPeerBody": m35,
        "notifPeerTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo traguardo"),
        "notifReactionBody": m36,
        "notifReactionTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova reazione",
        ),
        "notifRecapBody": m37,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Il tuo riepilogo settimanale",
        ),
        "notifRejectedBody": m38,
        "notifRejectedBodyReason": m39,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Richiesta respinta",
        ),
        "notifVerifiedBody": m40,
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
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Inizia"),
        "onboardingFastBody": m41,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Vai veloce"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "In bacheca vedi i traguardi dei colleghi e puoi reagire e commentare. Le notifiche ti avvisano quando succede qualcosa che ti riguarda.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Festeggiate insieme",
        ),
        "onboardingKindsBody": m42,
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
        "passwordMinLength": m43,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci la password",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Le password non coincidono",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("In attesa"),
        "percentValue": m44,
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Scegli un traguardo dal catalogo.",
        ),
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
        "rankValue": m45,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Festeggio"),
        "reactionInsightful": MessageLookupByLibrary.simpleMessage("Geniale"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Mi piace"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Adoro"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Traguardi recenti",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Respingi"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Respingere la richiesta?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Motivazione (facoltativa)",
        ),
        "rejectionReason": m46,
        "replaceImage": MessageLookupByLibrary.simpleMessage(
          "Sostituisci immagine",
        ),
        "requestAction": MessageLookupByLibrary.simpleMessage("Richiedi"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Richiesta approvata",
        ),
        "requestDialogSubtitle": m47,
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
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Richiesta respinta",
        ),
        "requestSent":
            MessageLookupByLibrary.simpleMessage("Richiesta inviata"),
        "requestsEmpty":
            MessageLookupByLibrary.simpleMessage("Nessuna richiesta."),
        "restore": MessageLookupByLibrary.simpleMessage("Ripristina"),
        "roleAtCompany": m48,
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
        "sendSuccess": m49,
        "sentByYouCount": m50,
        "sentCount": m51,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "Non hai ancora inviato traguardi. Scegline uno dalla libreria e fai felice un collega.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("a"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Sessione"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("Informazioni"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Account"),
        "settingsAppearance": MessageLookupByLibrary.simpleMessage("Aspetto"),
        "shareAddToProfile": MessageLookupByLibrary.simpleMessage(
          "Aggiungi al profilo",
        ),
        "shareAddToProfileHint": m52,
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
        "shareImageIssuedBy": m53,
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
        "sharePostPeer": m54,
        "sharePostVerified": m55,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare l\'immagine. Riprova.",
        ),
        "shareSaveImage":
            MessageLookupByLibrary.simpleMessage("Salva immagine"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Testo copiato negli appunti",
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
        "teamLeaderboard": MessageLookupByLibrary.simpleMessage(
          "Classifica del team",
        ),
        "templateAdded": m56,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Impossibile creare il traguardo. Riprova.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Impossibile eliminare il traguardo. Riprova.",
        ),
        "templateDeleted": m57,
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
        "timeDays": m58,
        "timeHours": m59,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Adesso"),
        "timeMinutes": m60,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("I migliori"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Apri Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Esci da Scoreboard"),
        "upToDate":
            MessageLookupByLibrary.simpleMessage("Hai l\'ultima versione."),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Scaricala dalla pagina della release su GitHub.",
        ),
        "updateAvailableTitle": m61,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "Impossibile verificare gli aggiornamenti.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Scarica"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Più tardi"),
        "updatesSection": MessageLookupByLibrary.simpleMessage("Aggiornamenti"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Carica immagine"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Carica foto"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Usalo"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Verificato dall\'azienda",
        ),
        "verifiedCount": m62,
        "versionLabel": m63,
        "workEmail": MessageLookupByLibrary.simpleMessage("Email di lavoro"),
        "xpToNextLevel": m64,
        "xpValue": m65,
        "youSuffix": m66,
      };
}
