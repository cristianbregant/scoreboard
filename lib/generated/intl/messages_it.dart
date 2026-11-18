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

  static String m12(count) =>
      "${Intl.plural(count, one: 'ha invitato 1 persona da un file', other: 'ha invitato ${count} persone da un file')}";

  static String m13(subject, target) =>
      "ha proposto “${subject}” per ${target}";

  static String m14(target) => "ha esportato i dati personali di ${target}";

  static String m15(target) =>
      "ha esportato il report dei traguardi (${target})";

  static String m16(target) => "ha esportato il report per persona (${target})";

  static String m17(subject, target) =>
      "ha approvato “${subject}” per ${target}";

  static String m18(subject, target) =>
      "ha respinto “${subject}” per ${target}";

  static String m19(subject) => "ha creato la stagione ${subject}";

  static String m20(subject) => "ha eliminato la stagione ${subject}";

  static String m21(subject) => "ha modificato la stagione ${subject}";

  static String m22(subject) => "ha creato il team ${subject}";

  static String m23(subject) => "ha eliminato il team ${subject}";

  static String m24(subject) => "ha modificato il team ${subject}";

  static String m25(company) => "Admin · ${company}";

  static String m26(name) => "${name} ora è amministratore";

  static String m27(name) => "${name} non è più amministratore";

  static String m28(points) => "${points} XP";

  static String m29(years) =>
      "${Intl.plural(years, one: '1 anno', other: '${years} anni')}";

  static String m30(count) =>
      "${Intl.plural(count, zero: 'Assegna', one: 'Assegna a 1 persona', other: 'Assegna a ${count} persone')}";

  static String m31(maxPoints) =>
      "I traguardi base si scambiano tra colleghi e valgono fino a ${maxPoints} XP. Quelli verificati li rilascia solo la tua azienda. Puoi inviare ogni traguardo base allo stesso collega una sola volta.";

  static String m32(company) =>
      "Il vostro colore e il vostro logo sostituiscono l\'oro di Scoreboard per tutti in ${company}. Il colore viene adattato perché i testi restino leggibili.";

  static String m33(remaining, budget) =>
      "${remaining} di ${budget} invii rimasti questo mese";

  static String m34(name) => "Da ${name}";

  static String m35(date) => "Rilasciato il ${date}";

  static String m36(date) => "Ricevuto il ${date}";

  static String m37(id) => "ID credenziale: ${id}";

  static String m38(company, date) => "Rilasciato da ${company} il ${date}";

  static String m39(name) => "Collega ${name}";

  static String m40(name) => "${name} collegato";

  static String m41(hint) => "Collegato · ${hint}";

  static String m42(name) => "Scollegare ${name}?";

  static String m43(channel, date) =>
      "L\'ultimo invio a ${channel} non è andato a buon fine (${date}). Controlla il collegamento e invia una prova.";

  static String m44(name) => "Messaggio di prova inviato a ${name}";

  static String m45(count) =>
      "${Intl.plural(count, zero: 'Commenta', one: '1 commento', other: '${count} commenti')}";

  static String m46(year) => "Dal ${year}";

  static String m47(company) =>
      "I traguardi verificati che ${company} può assegnare. Clicca una carta per modificarla.";

  static String m48(company) =>
      "Come ${company} appare e festeggia su Scoreboard";

  static String m49(company) =>
      "Come circola il riconoscimento in ${company}, e dove si inceppa.";

  static String m50(count) => "Richieste · ${count}";

  static String m51(name) => "Di ${name}";

  static String m52(name) => "Eliminare ${name}?";

  static String m53(name) => "Eliminare ${name}?";

  static String m54(name) => "Eliminare “${name}”?";

  static String m55(email, password) => "Account demo: ${email} / ${password}";

  static String m56(id) => "ID ${id}";

  static String m57(template, colleague) =>
      "Hai già inviato “${template}” a ${colleague}.";

  static String m58(budget) =>
      "Hai già inviato i ${budget} traguardi di questo mese. Il budget si rinnova il primo del mese.";

  static String m59(min, max) =>
      "Il valore deve essere tra ${min} e ${max} XP.";

  static String m60(values) => "I traguardi base possono valere ${values} XP.";

  static String m61(min) => "La password deve avere almeno ${min} caratteri.";

  static String m62(max) =>
      "Al massimo ${max} persone per importazione: dividi il file.";

  static String m63(company) =>
      "Firmata da ${company}: chiunque può verificarla dalla sua pagina pubblica.";

  static String m64(count) => "Tutti · ${count}";

  static String m65(tier, count) => "${tier} · ${count}";

  static String m66(count) =>
      "${Intl.plural(count, one: 'Invita 1 persona', other: 'Invita ${count} persone')}";

  static String m67(created, skipped) =>
      "Inviti inviati: ${created}. Esclusi: ${skipped}.";

  static String m68(count) =>
      "${Intl.plural(count, one: '1 riga esclusa', other: '${count} righe escluse')}";

  static String m69(value) => "${value} è già più in alto nel file";

  static String m70(value) => "“${value}” non è un\'email valida";

  static String m71(line, reason) => "Riga ${line}: ${reason}";

  static String m72(value) => "${value} ha già un account";

  static String m73(value) => "nessun team si chiama “${value}”";

  static String m74(count) =>
      "${Intl.plural(count, zero: 'Nessuno da invitare', one: '1 persona riceverà un invito', other: '${count} persone riceveranno un invito')}";

  static String m75(count) =>
      "${Intl.plural(count, one: '1 entrerà direttamente nel suo team.', other: '${count} entreranno direttamente nel loro team.')}";

  static String m76(code) => "Codice ${code}";

  static String m77(name, date) => "Invitato da ${name} · scade il ${date}";

  static String m78(company) =>
      "Riceverà via email un codice per entrare in ${company}. Il codice vale 7 giorni.";

  static String m79(email) => "Revocare l\'invito per ${email}?";

  static String m80(email) => "Invito inviato a ${email}";

  static String m81(email, code) =>
      "Modalità demo, nessuna email inviata: dai a ${email} il codice ${code}";

  static String m82(count) =>
      "${Intl.plural(count, one: 'Assegnato a 1 persona', other: 'Assegnato a ${count} persone')}";

  static String m83(count) =>
      "${Intl.plural(count, one: '1 volta', other: '${count} volte')}";

  static String m84(level, points) => "Livello ${level} · ${points} XP";

  static String m85(level) => "Livello ${level}";

  static String m86(count) => "Libreria · ${count}";

  static String m87(date) => "Membro dal ${date}";

  static String m88(name) => "Team di ${name}";

  static String m89(count) =>
      "${Intl.plural(count, one: '1 membro', other: '${count} membri')}";

  static String m90(name) => "Per ${name}. Un admin valuterà la tua proposta.";

  static String m91(achievement) =>
      "“${achievement}” è stato approvato ed è nei tuoi traguardi";

  static String m92(actor, achievement, text) =>
      "${actor} ha commentato “${achievement}”: ${text}";

  static String m93(level) => "Hai raggiunto il livello ${level}";

  static String m94(actor, achievement) => "${actor} chiede “${achievement}”";

  static String m95(actor, achievement, member) =>
      "${actor} propone “${achievement}” per ${member}";

  static String m96(actor, achievement) =>
      "${actor} ti ha inviato “${achievement}”";

  static String m97(actor, achievement) =>
      "${actor} ha reagito a “${achievement}”";

  static String m98(xp, rank) =>
      "Questa settimana: +${xp} XP · posizione #${rank}";

  static String m99(xp) => "Questa settimana: +${xp} XP";

  static String m100(achievement) => "“${achievement}” non è stato approvato";

  static String m101(achievement, reason) =>
      "“${achievement}” non è stato approvato: ${reason}";

  static String m102(company, achievement) =>
      "${company} ti ha rilasciato “${achievement}”";

  static String m103(count) =>
      "${Intl.plural(count, zero: 'Nessuna notifica da leggere', one: '1 notifica da leggere', other: '${count} notifiche da leggere')}";

  static String m104(shortcut) =>
      "Premi ${shortcut} per inviare un traguardo da qualsiasi schermata, oppure usa l\'icona nella barra dei menu.";

  static String m105(budget) =>
      "I traguardi verificati li rilascia la tua azienda: puoi richiederli dal catalogo. Quelli base li scambi con i colleghi, fino a ${budget} al mese.";

  static String m106(min) => "Almeno ${min} caratteri";

  static String m107(percent) => "${percent}%";

  static String m108(rank) => "#${rank}";

  static String m109(reason) => "Motivazione: ${reason}";

  static String m110(company) =>
      "Un admin di ${company} valuterà la tua richiesta.";

  static String m111(name) => "Proposto da ${name}";

  static String m112(role, company) => "${role} in ${company}";

  static String m113(days) =>
      "${Intl.plural(days, one: 'Manca 1 giorno', other: 'Mancano ${days} giorni')}";

  static String m114(start, end) => "${start} – ${end}";

  static String m115(rank, points) => "Sei #${rank} con ${points} XP";

  static String m116(name) => "Traguardo inviato a ${name}";

  static String m117(count) => "Inviati da te · ${count}";

  static String m118(count) =>
      "${Intl.plural(count, one: '1 inviato', other: '${count} inviati')}";

  static String m119(company) =>
      "Lo aggiunge a Licenze e certificazioni, con ${company} come ente emittente.";

  static String m120(company) => "Rilasciato da ${company}";

  static String m121(sender, name, description) =>
      "🤝 ${sender} mi ha assegnato il traguardo “${name}”.\n\n${description}\n\n#Scoreboard";

  static String m122(name, company, description) =>
      "🏆 Ho ottenuto il traguardo “${name}”, rilasciato da ${company}.\n\n${description}\n\n#Scoreboard";

  static String m123(provider) => "Continua con ${provider}";

  static String m124(time) => "Ultimo riconoscimento: ${time}";

  static String m125(received, sent) =>
      "${received} ricevuti · ${sent} inviati in 90 giorni";

  static String m126(name) => "“${name}” aggiunto alla libreria";

  static String m127(name) => "“${name}” eliminato";

  static String m128(count) =>
      "${Intl.plural(count, one: 'Ieri', other: '${count} giorni fa')}";

  static String m129(count) => "${count} h fa";

  static String m130(count) => "${count} min fa";

  static String m131(version) => "È disponibile la versione ${version}";

  static String m132(count) =>
      "${Intl.plural(count, one: '1 verificato', other: '${count} verificati')}";

  static String m133(version) => "Versione ${version}";

  static String m134(points, level) => "${points} XP al livello ${level}";

  static String m135(points) => "${points} XP";

  static String m136(name) => "${name} (tu)";

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
          "Tutto il tuo lavoro, nero su bianco",
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
        "activityIntegrationsUpdated": MessageLookupByLibrary.simpleMessage(
          "ha cambiato le integrazioni",
        ),
        "activityInviteRevoked": m8,
        "activityMemberInvited": m9,
        "activityMemberMoved": m10,
        "activityMemberRemoved": m11,
        "activityMembersImported": m12,
        "activityNominationSubmitted": m13,
        "activityPersonalDataExported": m14,
        "activityPrivacyUpdated": MessageLookupByLibrary.simpleMessage(
          "ha cambiato le impostazioni di privacy",
        ),
        "activityReportAchievements": m15,
        "activityReportPeople": m16,
        "activityRequestApproved": m17,
        "activityRequestRejected": m18,
        "activitySeasonCreated": m19,
        "activitySeasonDeleted": m20,
        "activitySeasonUpdated": m21,
        "activitySsoUpdated": MessageLookupByLibrary.simpleMessage(
          "ha cambiato l\'accesso singolo",
        ),
        "activityTeamCreated": m22,
        "activityTeamDeleted": m23,
        "activityTeamUpdated": m24,
        "adminBadge": m25,
        "adminGrantedMessage": m26,
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
        "adminRevokedMessage": m27,
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
        "anniversaryXp": m28,
        "anniversaryYears": m29,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Scegli l\'aspetto di Scoreboard",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Approva"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivia"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archiviato"),
        "assignButton": m30,
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
        "authOr": MessageLookupByLibrary.simpleMessage("oppure"),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Raccogli i traguardi rilasciati dalla tua azienda e riconosci il merito dei colleghi che fanno la differenza.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "I tuoi trofei sentivano la tua mancanza.",
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
        "baseExplanation": m31,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Piccoli grazie, XP inclusi",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Una riga su di te e su cosa fai",
        ),
        "brandBody": m32,
        "brandColor": MessageLookupByLibrary.simpleMessage("Colore"),
        "brandDefault":
            MessageLookupByLibrary.simpleMessage("Oro di Scoreboard"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Anteprima"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Marchio"),
        "budgetRemaining": m33,
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Traguardo base",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Gira la card"),
        "cardFrom": m34,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("RILASCIATO DA"),
        "cardIssuedOn": m35,
        "cardReceivedOn": m36,
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
        "certCredentialId": m37,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "ha ottenuto il traguardo",
        ),
        "certIssuedBy": m38,
        "certPresentedTo":
            MessageLookupByLibrary.simpleMessage("Si certifica che"),
        "certTitle": MessageLookupByLibrary.simpleMessage(
          "CERTIFICATO DI TRAGUARDO",
        ),
        "certVerify": MessageLookupByLibrary.simpleMessage(
          "Verifica questo certificato",
        ),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Cambia password"),
        "chatBody": MessageLookupByLibrary.simpleMessage(
          "Ogni riconoscimento compare anche nel canale che scegli, dove il team lo vede davvero. Le note personali restano in Scoreboard.",
        ),
        "chatConnect": MessageLookupByLibrary.simpleMessage("Collega"),
        "chatConnectTitle": m39,
        "chatConnected": m40,
        "chatConnectedTo": m41,
        "chatDisconnect": MessageLookupByLibrary.simpleMessage("Scollega"),
        "chatDisconnectBody": MessageLookupByLibrary.simpleMessage(
          "Nel canale non arriveranno più riconoscimenti. Potrai ricollegarlo quando vuoi.",
        ),
        "chatDisconnectTitle": m42,
        "chatLanguage":
            MessageLookupByLibrary.simpleMessage("Lingua dei messaggi"),
        "chatLastError": m43,
        "chatNotConnected":
            MessageLookupByLibrary.simpleMessage("Non collegato"),
        "chatPostPeer": MessageLookupByLibrary.simpleMessage(
          "Pubblica anche quelli tra colleghi",
        ),
        "chatPostPeerHint": MessageLookupByLibrary.simpleMessage(
          "Più frequenti: utili in un canale dedicato, rumorosi in quello generale.",
        ),
        "chatPostVerified": MessageLookupByLibrary.simpleMessage(
          "Pubblica i traguardi verificati",
        ),
        "chatSendTest": MessageLookupByLibrary.simpleMessage("Invia una prova"),
        "chatSlackHowTo": MessageLookupByLibrary.simpleMessage(
          "In Slack, crea un\'app su api.slack.com/apps, attiva «Incoming Webhooks» e aggiungi un webhook per il canale. Copia qui l\'URL che inizia con https://hooks.slack.com.",
        ),
        "chatTeamsHowTo": MessageLookupByLibrary.simpleMessage(
          "In Teams, apri il canale, scegli «Flussi di lavoro» e il modello «Pubblica in un canale quando viene ricevuta una richiesta webhook». Copia qui l\'URL che ti dà.",
        ),
        "chatTestSent": m44,
        "chatTitle": MessageLookupByLibrary.simpleMessage("Teams e Slack"),
        "chatWebhookUrl":
            MessageLookupByLibrary.simpleMessage("URL del webhook"),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Verifica aggiornamenti",
        ),
        "colleaguesTitle": MessageLookupByLibrary.simpleMessage("Colleghi"),
        "commentHint":
            MessageLookupByLibrary.simpleMessage("Scrivi un commento…"),
        "commentsCount": m45,
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
          "Tutti, ovunque, in classifica. Nessuna pressione.",
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
        "companySince": m46,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Conferma"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Conferma nuova password",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage(
          "Registro attività",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Assegna"),
        "consoleAssignSubtitle": MessageLookupByLibrary.simpleMessage(
          "Scegli un traguardo, scegli le persone, svolta loro la giornata.",
        ),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catalogo"),
        "consoleCatalogSubtitle": m47,
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Azienda"),
        "consoleCompanySubtitle": m48,
        "consoleInsightsSubtitle": m49,
        "consoleIntegrations":
            MessageLookupByLibrary.simpleMessage("Integrazioni"),
        "consoleIntegrationsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Scoreboard dentro gli strumenti che già usate: chat e account di lavoro.",
        ),
        "consoleMembers": MessageLookupByLibrary.simpleMessage("Membri"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Report"),
        "consoleRequests": m50,
        "consoleRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Chi chiede un riconoscimento che crede di essersi guadagnato. Decidi tu.",
        ),
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Stagioni"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Statistiche"),
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Team"),
        "copyVerifyLink": MessageLookupByLibrary.simpleMessage(
          "Copia il link di verifica",
        ),
        "createAccount": MessageLookupByLibrary.simpleMessage("Crea account"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Chiunque nella tua azienda può inviarlo a un collega.",
        ),
        "createdBy": m51,
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
        "deleteSeasonTitle": m52,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "I suoi membri resteranno senza team. I loro traguardi restano.",
        ),
        "deleteTeamTitle": m53,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Verrà rimosso dalla libreria. I colleghi che l\'hanno già ricevuto lo conservano.",
        ),
        "deleteTemplateTitle": m54,
        "demoAccount": m55,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "Cosa bisogna fare per meritarlo?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Aggiungi una breve descrizione",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Azienda"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Ottenuto il"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Esperienza"),
        "detailId": m56,
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
        "errorAlreadySent": m57,
        "errorBudgetExhausted": m58,
        "errorCatalogPoints": m59,
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
        "errorInvalidPoints": m60,
        "errorInvalidSsoDomain": MessageLookupByLibrary.simpleMessage(
          "Non è un dominio valido, ad esempio azienda.it.",
        ),
        "errorInvalidSsoTenant": MessageLookupByLibrary.simpleMessage(
          "Non è un ID tenant di Microsoft: lo trovi nel portale di Entra, nella panoramica.",
        ),
        "errorInvalidWebhook": MessageLookupByLibrary.simpleMessage(
          "Non è un webhook di Teams o Slack. Controlla di aver copiato l\'URL intero.",
        ),
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
        "errorNeedsBackend": MessageLookupByLibrary.simpleMessage(
          "Disponibile con il server di Scoreboard: in questa demo non si inviano messaggi.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "Puoi inviare traguardi solo ai colleghi della tua azienda.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Solo gli admin dell\'azienda possono farlo.",
        ),
        "errorNotConfigured": MessageLookupByLibrary.simpleMessage(
          "Questo canale non è collegato.",
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
        "errorPasswordTooShort": m61,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Hai già una richiesta in attesa per questo traguardo.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "Queste date si sovrappongono a un\'altra stagione.",
        ),
        "errorSsoCancelled": MessageLookupByLibrary.simpleMessage(
          "Accesso annullato.",
        ),
        "errorSsoFailed": MessageLookupByLibrary.simpleMessage(
          "L\'accesso con il tuo account di lavoro non è riuscito. Riprova.",
        ),
        "errorSsoInUse": MessageLookupByLibrary.simpleMessage(
          "Un\'altra azienda usa già questo accesso: un tenant o un dominio vale per una sola azienda.",
        ),
        "errorSsoNoAccount": MessageLookupByLibrary.simpleMessage(
          "Questo account non è ancora in Scoreboard: chiedi a un admin della tua azienda di invitarti.",
        ),
        "errorSsoNotConfigured": MessageLookupByLibrary.simpleMessage(
          "La tua azienda non ha attivato l\'accesso con questo account. Usa email e password, o chiedi al tuo admin.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "Questo traguardo base non esiste più.",
        ),
        "errorTooManyAttempts": MessageLookupByLibrary.simpleMessage(
          "Troppi tentativi con questa email. Riprova tra qualche minuto.",
        ),
        "errorTooManyInvites": m62,
        "errorWebhookFailed": MessageLookupByLibrary.simpleMessage(
          "Il servizio ha rifiutato il messaggio. Il webhook potrebbe essere stato rimosso: collegalo di nuovo.",
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
        "exportOpenBadgeSigned": MessageLookupByLibrary.simpleMessage(
          "Open Badge firmato",
        ),
        "exportOpenBadgeSignedHint": m63,
        "exportPdf": MessageLookupByLibrary.simpleMessage("Certificato PDF"),
        "exportSaved": MessageLookupByLibrary.simpleMessage("File salvato"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("ha ottenuto"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Tutto tranquillo. Il prossimo traguardo ricevuto romperà il silenzio.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "I successi dei colleghi, appena succedono. Applausi graditi.",
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
        "filterAll": m64,
        "filterTier": m65,
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
        "importConfirm": m66,
        "importCsv": MessageLookupByLibrary.simpleMessage("Importa CSV"),
        "importDone": m67,
        "importEmpty": MessageLookupByLibrary.simpleMessage(
          "Nessun indirizzo email in questo file.",
        ),
        "importFormatHint": MessageLookupByLibrary.simpleMessage(
          "Una colonna di email, più ruolo e team se vuoi. Virgola o punto e virgola, intestazione facoltativa: va bene l\'export di Excel.",
        ),
        "importLeftOut": m68,
        "importProblemDuplicate": m69,
        "importProblemInvalidEmail": m70,
        "importProblemLine": m71,
        "importProblemMember": m72,
        "importProblemTeam": m73,
        "importSummary": m74,
        "importTitle": MessageLookupByLibrary.simpleMessage("Importa persone"),
        "importWithTeams": m75,
        "individualRankingsBody": MessageLookupByLibrary.simpleMessage(
          "Podio, classifica del team, posizioni nel profilo e nelle stagioni, classifica Community. Spente, restano solo i totali dell\'azienda.",
        ),
        "individualRankingsTitle": MessageLookupByLibrary.simpleMessage(
          "Classifiche individuali",
        ),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Inserisci un indirizzo email valido",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Inserisci un link http(s) valido",
        ),
        "inviteCodeChip": m76,
        "inviteCodeLabel":
            MessageLookupByLibrary.simpleMessage("Codice d\'invito"),
        "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
          "Inserisci il codice che hai ricevuto",
        ),
        "inviteDetails": m77,
        "inviteDialogBody": m78,
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
        "inviteRevokeTitle": m79,
        "inviteRevoked":
            MessageLookupByLibrary.simpleMessage("Invito revocato"),
        "inviteSend": MessageLookupByLibrary.simpleMessage("Invia invito"),
        "inviteSent": m80,
        "inviteSentDemo": m81,
        "invitesEmpty": MessageLookupByLibrary.simpleMessage(
          "Nessun invito in attesa.",
        ),
        "issuedCount": m82,
        "issuedTimes": m83,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verificato"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("Sistema"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Lingua"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Classifica"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Tra colleghi"),
        "levelAndXp": m84,
        "levelN": m85,
        "libraryCount": m86,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "La libreria è vuota. Qualcuno deve pur iniziare: perché non tu?",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Qualcosa è andato storto durante il caricamento dei dati.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Segna tutte come lette",
        ),
        "memberSince": m87,
        "memberTeamLabel": m88,
        "membersCount": m89,
        "membersHint": MessageLookupByLibrary.simpleMessage(
          "Invita le persone nell\'azienda e scegli chi può gestirla.",
        ),
        "membersWithoutTeam":
            MessageLookupByLibrary.simpleMessage("Senza team"),
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
          "Ancora niente in questa categoria. Dagli tempo.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun traguardo.",
        ),
        "noManager":
            MessageLookupByLibrary.simpleMessage("Nessun responsabile"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Nessun risultato. Prova con meno lettere, o un\'altra intuizione.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("Nessun team"),
        "nominateDialogSubtitle": m90,
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
        "notifApprovedBody": m91,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Richiesta approvata",
        ),
        "notifCommentBody": m92,
        "notifCommentTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo commento"),
        "notifLevelUpBody": m93,
        "notifLevelUpTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo livello!"),
        "notifNewRequestBody": m94,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova richiesta",
        ),
        "notifNominationBody": m95,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova proposta",
        ),
        "notifPeerBody": m96,
        "notifPeerTitle":
            MessageLookupByLibrary.simpleMessage("Nuovo traguardo"),
        "notifReactionBody": m97,
        "notifReactionTitle": MessageLookupByLibrary.simpleMessage(
          "Nuova reazione",
        ),
        "notifRecapBody": m98,
        "notifRecapBodyNoRank": m99,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Il tuo riepilogo settimanale",
        ),
        "notifRejectedBody": m100,
        "notifRejectedBodyReason": m101,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Richiesta respinta",
        ),
        "notifVerifiedBody": m102,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Traguardo verificato",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "Sei in pari. Per ora nulla richiede la tua attenzione.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Apri le notifiche",
        ),
        "notificationsTitle": MessageLookupByLibrary.simpleMessage("Notifiche"),
        "notificationsUnread": m103,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Inizia"),
        "onboardingFastBody": m104,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Vai veloce"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "In bacheca vedi i traguardi dei colleghi e puoi reagire e commentare. Le notifiche ti avvisano quando succede qualcosa che ti riguarda.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Festeggiate insieme",
        ),
        "onboardingKindsBody": m105,
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
        "passwordMinLength": m106,
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
        "percentValue": m107,
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
        "privacyBody": MessageLookupByLibrary.simpleMessage(
          "Cosa mostra l\'app sulle singole persone. Se un accordo con le rappresentanze dei lavoratori lo richiede, spegni queste opzioni: valgono per tutta l\'azienda.",
        ),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "I colleghi della tua azienda ti vedono comunque nella classifica del team.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "Mostrami nella classifica Community",
        ),
        "privacySection": MessageLookupByLibrary.simpleMessage("Privacy"),
        "privacyTitle": MessageLookupByLibrary.simpleMessage(
          "Privacy e monitoraggio",
        ),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossibile salvare il profilo. Riprova.",
        ),
        "profileUpdated": MessageLookupByLibrary.simpleMessage(
          "Profilo aggiornato",
        ),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Nascosta"),
        "rankValue": m108,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Festeggio"),
        "reactionInsightful": MessageLookupByLibrary.simpleMessage("Geniale"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Mi piace"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Adoro"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Traguardi recenti",
        ),
        "recognitionGapsBody": MessageLookupByLibrary.simpleMessage(
          "Per i manager, chi non riceve nulla da un mese; per gli admin, chi ne ha ricevuti meno negli ultimi 90 giorni.",
        ),
        "recognitionGapsTitle": MessageLookupByLibrary.simpleMessage(
          "Segnala chi è poco riconosciuto",
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
        "rejectionReason": m109,
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
        "requestDialogSubtitle": m110,
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
        "requestNominatedBy": m111,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Richiesta respinta",
        ),
        "requestSent":
            MessageLookupByLibrary.simpleMessage("Richiesta inviata"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage(
          "Nessuna richiesta. O va tutto benissimo, o sono tutti modesti.",
        ),
        "restore": MessageLookupByLibrary.simpleMessage("Ripristina"),
        "roleAtCompany": m112,
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
        "seasonDaysLeft": m113,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Stagione eliminata",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Conclusa"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Nome"),
        "seasonNameHint":
            MessageLookupByLibrary.simpleMessage("es. Autunno 2026"),
        "seasonRange": m114,
        "seasonSaved": MessageLookupByLibrary.simpleMessage("Stagione salvata"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("In arrivo"),
        "seasonYourRank": m115,
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
          "Scegli un traguardo: la sua carta comparirà qui, pronta a partire.",
        ),
        "sendSuccess": m116,
        "sentByYouCount": m117,
        "sentCount": m118,
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
        "shareAddToProfileHint": m119,
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
        "shareImageIssuedBy": m120,
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
        "sharePostPeer": m121,
        "sharePostVerified": m122,
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
        "ssoBody": MessageLookupByLibrary.simpleMessage(
          "Le persone accedono con l\'account di lavoro, senza un\'altra password. Vale solo per il tenant o il dominio indicati qui, e solo per chi è già membro o ha ricevuto un invito.",
        ),
        "ssoBrowserDone": MessageLookupByLibrary.simpleMessage(
          "Accesso fatto. Puoi chiudere questa scheda e tornare a Scoreboard.",
        ),
        "ssoBrowserFailed": MessageLookupByLibrary.simpleMessage(
          "L\'accesso non è andato a buon fine. Torna a Scoreboard per vedere perché.",
        ),
        "ssoContinueWith": m123,
        "ssoGoogleDomain": MessageLookupByLibrary.simpleMessage(
          "Dominio Google Workspace",
        ),
        "ssoGoogleDomainHint": MessageLookupByLibrary.simpleMessage(
          "Quello degli indirizzi di lavoro, ad esempio azienda.it. Lascia vuoto per non usare Google.",
        ),
        "ssoMicrosoftTenant": MessageLookupByLibrary.simpleMessage(
          "ID tenant Microsoft Entra",
        ),
        "ssoMicrosoftTenantHint": MessageLookupByLibrary.simpleMessage(
          "Nel portale di Entra, alla voce Panoramica. Lascia vuoto per non usare Microsoft.",
        ),
        "ssoTitle":
            MessageLookupByLibrary.simpleMessage("Accesso singolo (SSO)"),
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
        "teamLastRecognized": m124,
        "teamLeaderboard": MessageLookupByLibrary.simpleMessage(
          "Classifica del team",
        ),
        "teamManager": MessageLookupByLibrary.simpleMessage("Responsabile"),
        "teamMemberActivity": m125,
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
          "Chi riceve i meriti, e chi ne meriterebbe di più",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "Ancora nessun team. Crea il primo.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Ogni team ha un responsabile, che vede come vengono riconosciuti i suoi membri e può proporre per loro traguardi verificati.",
        ),
        "templateAdded": m126,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Impossibile creare il traguardo. Riprova.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Impossibile eliminare il traguardo. Riprova.",
        ),
        "templateDeleted": m127,
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
        "timeDays": m128,
        "timeHours": m129,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Adesso"),
        "timeMinutes": m130,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("I migliori"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Apri Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Esci da Scoreboard"),
        "upToDate":
            MessageLookupByLibrary.simpleMessage("Hai l\'ultima versione."),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Scaricala dalla pagina della release su GitHub.",
        ),
        "updateAvailableTitle": m131,
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
        "verifiedCount": m132,
        "verifyLinkCopied": MessageLookupByLibrary.simpleMessage(
          "Link di verifica copiato",
        ),
        "versionLabel": m133,
        "workEmail": MessageLookupByLibrary.simpleMessage("Email di lavoro"),
        "xpToNextLevel": m134,
        "xpValue": m135,
        "youLabel": MessageLookupByLibrary.simpleMessage("(tu)"),
        "youSuffix": m136,
      };
}
