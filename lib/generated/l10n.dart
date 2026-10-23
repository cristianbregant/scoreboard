// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalization {
  AppLocalization();

  static AppLocalization? _current;

  static AppLocalization get current {
    assert(
      _current != null,
      'No instance of AppLocalization was loaded. Try to initialize the AppLocalization delegate before accessing AppLocalization.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalization();
      AppLocalization._current = instance;

      return instance;
    });
  }

  static AppLocalization of(BuildContext context) {
    final instance = AppLocalization.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalization present in the widget tree. Did you add AppLocalization.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalization? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  /// `Annulla`
  String get commonCancel {
    return Intl.message('Annulla', name: 'commonCancel', desc: '', args: []);
  }

  /// `Salva`
  String get commonSave {
    return Intl.message('Salva', name: 'commonSave', desc: '', args: []);
  }

  /// `Invia`
  String get commonSend {
    return Intl.message('Invia', name: 'commonSend', desc: '', args: []);
  }

  /// `Elimina`
  String get commonDelete {
    return Intl.message('Elimina', name: 'commonDelete', desc: '', args: []);
  }

  /// `Riprova`
  String get commonRetry {
    return Intl.message('Riprova', name: 'commonRetry', desc: '', args: []);
  }

  /// `Indietro`
  String get commonBack {
    return Intl.message('Indietro', name: 'commonBack', desc: '', args: []);
  }

  /// `Crea`
  String get commonCreate {
    return Intl.message('Crea', name: 'commonCreate', desc: '', args: []);
  }

  /// `Rimuovi`
  String get commonRemove {
    return Intl.message('Rimuovi', name: 'commonRemove', desc: '', args: []);
  }

  /// `ANTEPRIMA`
  String get commonPreview {
    return Intl.message('ANTEPRIMA', name: 'commonPreview', desc: '', args: []);
  }

  /// `Qualcosa è andato storto durante il caricamento dei dati.`
  String get loadError {
    return Intl.message(
      'Qualcosa è andato storto durante il caricamento dei dati.',
      name: 'loadError',
      desc: '',
      args: [],
    );
  }

  /// `Qualcosa è andato storto. Riprova.`
  String get genericError {
    return Intl.message(
      'Qualcosa è andato storto. Riprova.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `{points} XP`
  String xpValue(int points) {
    return Intl.message(
      '$points XP',
      name: 'xpValue',
      desc: '',
      args: [points],
    );
  }

  /// `#{rank}`
  String rankValue(Object rank) {
    return Intl.message('#$rank', name: 'rankValue', desc: '', args: [rank]);
  }

  /// `{name} (tu)`
  String youSuffix(Object name) {
    return Intl.message(
      '$name (tu)',
      name: 'youSuffix',
      desc: '',
      args: [name],
    );
  }

  /// `{role} in {company}`
  String roleAtCompany(Object role, Object company) {
    return Intl.message(
      '$role in $company',
      name: 'roleAtCompany',
      desc: '',
      args: [role, company],
    );
  }

  /// `{count, plural, one{1 traguardo} other{{count} traguardi}}`
  String achievementsCount(int count) {
    return Intl.plural(
      count,
      one: '1 traguardo',
      other: '$count traguardi',
      name: 'achievementsCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{1 membro} other{{count} membri}}`
  String membersCount(int count) {
    return Intl.plural(
      count,
      one: '1 membro',
      other: '$count membri',
      name: 'membersCount',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{1 verificato} other{{count} verificati}}`
  String verifiedCount(int count) {
    return Intl.plural(
      count,
      one: '1 verificato',
      other: '$count verificati',
      name: 'verifiedCount',
      desc: '',
      args: [count],
    );
  }

  /// `Verificato`
  String get labelVerified {
    return Intl.message(
      'Verificato',
      name: 'labelVerified',
      desc: '',
      args: [],
    );
  }

  /// `MENU`
  String get menuLabel {
    return Intl.message('MENU', name: 'menuLabel', desc: '', args: []);
  }

  /// `Traguardi`
  String get navAchievements {
    return Intl.message(
      'Traguardi',
      name: 'navAchievements',
      desc: '',
      args: [],
    );
  }

  /// `Traguardi base`
  String get navBaseAchievements {
    return Intl.message(
      'Traguardi base',
      name: 'navBaseAchievements',
      desc: '',
      args: [],
    );
  }

  /// `La tua azienda`
  String get navYourCompany {
    return Intl.message(
      'La tua azienda',
      name: 'navYourCompany',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get navCommunity {
    return Intl.message('Community', name: 'navCommunity', desc: '', args: []);
  }

  /// `Profilo`
  String get navProfile {
    return Intl.message('Profilo', name: 'navProfile', desc: '', args: []);
  }

  /// `Impostazioni`
  String get navSettings {
    return Intl.message(
      'Impostazioni',
      name: 'navSettings',
      desc: '',
      args: [],
    );
  }

  /// `Livello {level} · {points} XP`
  String levelAndXp(int level, int points) {
    return Intl.message(
      'Livello $level · $points XP',
      name: 'levelAndXp',
      desc: '',
      args: [level, points],
    );
  }

  /// `Colleghi`
  String get tierPeer {
    return Intl.message('Colleghi', name: 'tierPeer', desc: '', args: []);
  }

  /// `Bronzo`
  String get tierBronze {
    return Intl.message('Bronzo', name: 'tierBronze', desc: '', args: []);
  }

  /// `Argento`
  String get tierSilver {
    return Intl.message('Argento', name: 'tierSilver', desc: '', args: []);
  }

  /// `Oro`
  String get tierGold {
    return Intl.message('Oro', name: 'tierGold', desc: '', args: []);
  }

  /// `Platino`
  String get tierPlatinum {
    return Intl.message('Platino', name: 'tierPlatinum', desc: '', args: []);
  }

  /// `I tuoi traguardi`
  String get achievementsTitle {
    return Intl.message(
      'I tuoi traguardi',
      name: 'achievementsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ogni traguardo raggiunto lungo il percorso`
  String get achievementsSubtitle {
    return Intl.message(
      'Ogni traguardo raggiunto lungo il percorso',
      name: 'achievementsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Invia traguardo`
  String get sendAchievement {
    return Intl.message(
      'Invia traguardo',
      name: 'sendAchievement',
      desc: '',
      args: [],
    );
  }

  /// `XP totali`
  String get statTotalXp {
    return Intl.message('XP totali', name: 'statTotalXp', desc: '', args: []);
  }

  /// `Traguardi`
  String get statAchievements {
    return Intl.message(
      'Traguardi',
      name: 'statAchievements',
      desc: '',
      args: [],
    );
  }

  /// `Verificati`
  String get statVerified {
    return Intl.message('Verificati', name: 'statVerified', desc: '', args: []);
  }

  /// `Tutti · {count}`
  String filterAll(int count) {
    return Intl.message(
      'Tutti · $count',
      name: 'filterAll',
      desc: '',
      args: [count],
    );
  }

  /// `{tier} · {count}`
  String filterTier(Object tier, int count) {
    return Intl.message(
      '$tier · $count',
      name: 'filterTier',
      desc: '',
      args: [tier, count],
    );
  }

  /// `Nessun traguardo in questa categoria.`
  String get noAchievementsInTier {
    return Intl.message(
      'Nessun traguardo in questa categoria.',
      name: 'noAchievementsInTier',
      desc: '',
      args: [],
    );
  }

  /// `Traguardo`
  String get achievementDetailTitle {
    return Intl.message(
      'Traguardo',
      name: 'achievementDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `Clicca la card per girarla`
  String get flipHint {
    return Intl.message(
      'Clicca la card per girarla',
      name: 'flipHint',
      desc: '',
      args: [],
    );
  }

  /// `Verificato dall'azienda`
  String get verifiedByCompany {
    return Intl.message(
      'Verificato dall\'azienda',
      name: 'verifiedByCompany',
      desc: '',
      args: [],
    );
  }

  /// `Da un collega`
  String get fromAColleague {
    return Intl.message(
      'Da un collega',
      name: 'fromAColleague',
      desc: '',
      args: [],
    );
  }

  /// `Esperienza`
  String get detailExperience {
    return Intl.message(
      'Esperienza',
      name: 'detailExperience',
      desc: '',
      args: [],
    );
  }

  /// `Categoria`
  String get detailTier {
    return Intl.message('Categoria', name: 'detailTier', desc: '', args: []);
  }

  /// `Azienda`
  String get detailCompany {
    return Intl.message('Azienda', name: 'detailCompany', desc: '', args: []);
  }

  /// `Inviato da`
  String get detailSentBy {
    return Intl.message('Inviato da', name: 'detailSentBy', desc: '', args: []);
  }

  /// `Ottenuto il`
  String get detailEarnedOn {
    return Intl.message(
      'Ottenuto il',
      name: 'detailEarnedOn',
      desc: '',
      args: [],
    );
  }

  /// `ID {id}`
  String detailId(Object id) {
    return Intl.message('ID $id', name: 'detailId', desc: '', args: [id]);
  }

  /// `Un collega`
  String get noteAuthorFallback {
    return Intl.message(
      'Un collega',
      name: 'noteAuthorFallback',
      desc: '',
      args: [],
    );
  }

  /// `Da {name}`
  String cardFrom(Object name) {
    return Intl.message('Da $name', name: 'cardFrom', desc: '', args: [name]);
  }

  /// `Traguardo base`
  String get cardBaseAchievement {
    return Intl.message(
      'Traguardo base',
      name: 'cardBaseAchievement',
      desc: '',
      args: [],
    );
  }

  /// `RILASCIATO DA`
  String get cardIssuedBy {
    return Intl.message(
      'RILASCIATO DA',
      name: 'cardIssuedBy',
      desc: '',
      args: [],
    );
  }

  /// `Traguardo verificato`
  String get cardVerifiedAchievement {
    return Intl.message(
      'Traguardo verificato',
      name: 'cardVerifiedAchievement',
      desc: '',
      args: [],
    );
  }

  /// `Rilasciato il {date}`
  String cardIssuedOn(Object date) {
    return Intl.message(
      'Rilasciato il $date',
      name: 'cardIssuedOn',
      desc: '',
      args: [date],
    );
  }

  /// `INVIATO DA`
  String get cardSentBy {
    return Intl.message('INVIATO DA', name: 'cardSentBy', desc: '', args: []);
  }

  /// `Ricevuto il {date}`
  String cardReceivedOn(Object date) {
    return Intl.message(
      'Ricevuto il $date',
      name: 'cardReceivedOn',
      desc: '',
      args: [date],
    );
  }

  /// `Gira la card`
  String get cardFlip {
    return Intl.message('Gira la card', name: 'cardFlip', desc: '', args: []);
  }

  /// `Membri`
  String get statMembers {
    return Intl.message('Membri', name: 'statMembers', desc: '', args: []);
  }

  /// `La tua posizione`
  String get statYourRank {
    return Intl.message(
      'La tua posizione',
      name: 'statYourRank',
      desc: '',
      args: [],
    );
  }

  /// `I migliori`
  String get topPerformers {
    return Intl.message(
      'I migliori',
      name: 'topPerformers',
      desc: '',
      args: [],
    );
  }

  /// `Classifica del team`
  String get teamLeaderboard {
    return Intl.message(
      'Classifica del team',
      name: 'teamLeaderboard',
      desc: '',
      args: [],
    );
  }

  /// `Invia un traguardo`
  String get sendAnAchievement {
    return Intl.message(
      'Invia un traguardo',
      name: 'sendAnAchievement',
      desc: '',
      args: [],
    );
  }

  /// `Dal {year}`
  String companySince(Object year) {
    return Intl.message(
      'Dal $year',
      name: 'companySince',
      desc: '',
      args: [year],
    );
  }

  /// `Community`
  String get communityTitle {
    return Intl.message(
      'Community',
      name: 'communityTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scopri come ti posizioni rispetto agli altri`
  String get communitySubtitle {
    return Intl.message(
      'Scopri come ti posizioni rispetto agli altri',
      name: 'communitySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Persone`
  String get communityPeople {
    return Intl.message('Persone', name: 'communityPeople', desc: '', args: []);
  }

  /// `Aziende`
  String get communityCompanies {
    return Intl.message(
      'Aziende',
      name: 'communityCompanies',
      desc: '',
      args: [],
    );
  }

  /// `Cerca per nome, ruolo o azienda`
  String get searchPeopleHint {
    return Intl.message(
      'Cerca per nome, ruolo o azienda',
      name: 'searchPeopleHint',
      desc: '',
      args: [],
    );
  }

  /// `Cerca per nome o settore`
  String get searchCompaniesHint {
    return Intl.message(
      'Cerca per nome o settore',
      name: 'searchCompaniesHint',
      desc: '',
      args: [],
    );
  }

  /// `Top 3`
  String get top3 {
    return Intl.message('Top 3', name: 'top3', desc: '', args: []);
  }

  /// `Classifica`
  String get leaderboard {
    return Intl.message('Classifica', name: 'leaderboard', desc: '', args: []);
  }

  /// `Nessun risultato per la tua ricerca.`
  String get noSearchResults {
    return Intl.message(
      'Nessun risultato per la tua ricerca.',
      name: 'noSearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Posizione in azienda`
  String get statCompanyRank {
    return Intl.message(
      'Posizione in azienda',
      name: 'statCompanyRank',
      desc: '',
      args: [],
    );
  }

  /// `Posizione globale`
  String get statGlobalRank {
    return Intl.message(
      'Posizione globale',
      name: 'statGlobalRank',
      desc: '',
      args: [],
    );
  }

  /// `Traguardi recenti`
  String get recentAchievements {
    return Intl.message(
      'Traguardi recenti',
      name: 'recentAchievements',
      desc: '',
      args: [],
    );
  }

  /// `Ancora nessun traguardo.`
  String get noAchievementsYet {
    return Intl.message(
      'Ancora nessun traguardo.',
      name: 'noAchievementsYet',
      desc: '',
      args: [],
    );
  }

  /// `Modifica profilo`
  String get editProfile {
    return Intl.message(
      'Modifica profilo',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Membro dal {date}`
  String memberSince(Object date) {
    return Intl.message(
      'Membro dal $date',
      name: 'memberSince',
      desc: '',
      args: [date],
    );
  }

  /// `Livello {level}`
  String levelN(int level) {
    return Intl.message(
      'Livello $level',
      name: 'levelN',
      desc: '',
      args: [level],
    );
  }

  /// `{points} XP al livello {level}`
  String xpToNextLevel(int points, int level) {
    return Intl.message(
      '$points XP al livello $level',
      name: 'xpToNextLevel',
      desc: '',
      args: [points, level],
    );
  }

  /// `Profilo aggiornato`
  String get profileUpdated {
    return Intl.message(
      'Profilo aggiornato',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile salvare il profilo. Riprova.`
  String get profileSaveError {
    return Intl.message(
      'Impossibile salvare il profilo. Riprova.',
      name: 'profileSaveError',
      desc: '',
      args: [],
    );
  }

  /// `Crea traguardi e inviali ai tuoi colleghi`
  String get baseSubtitle {
    return Intl.message(
      'Crea traguardi e inviali ai tuoi colleghi',
      name: 'baseSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Nuovo traguardo base`
  String get newBaseAchievement {
    return Intl.message(
      'Nuovo traguardo base',
      name: 'newBaseAchievement',
      desc: '',
      args: [],
    );
  }

  /// `Libreria · {count}`
  String libraryCount(int count) {
    return Intl.message(
      'Libreria · $count',
      name: 'libraryCount',
      desc: '',
      args: [count],
    );
  }

  /// `Ancora nessun traguardo base. Crea il primo!`
  String get libraryEmpty {
    return Intl.message(
      'Ancora nessun traguardo base. Crea il primo!',
      name: 'libraryEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Inviati da te · {count}`
  String sentByYouCount(int count) {
    return Intl.message(
      'Inviati da te · $count',
      name: 'sentByYouCount',
      desc: '',
      args: [count],
    );
  }

  /// `Non hai ancora inviato traguardi. Scegline uno dalla libreria e fai felice un collega.`
  String get sentEmpty {
    return Intl.message(
      'Non hai ancora inviato traguardi. Scegline uno dalla libreria e fai felice un collega.',
      name: 'sentEmpty',
      desc: '',
      args: [],
    );
  }

  /// `I traguardi base si scambiano tra colleghi e valgono fino a {maxPoints} XP. Quelli verificati li rilascia solo la tua azienda. Puoi inviare ogni traguardo base allo stesso collega una sola volta.`
  String baseExplanation(int maxPoints) {
    return Intl.message(
      'I traguardi base si scambiano tra colleghi e valgono fino a $maxPoints XP. Quelli verificati li rilascia solo la tua azienda. Puoi inviare ogni traguardo base allo stesso collega una sola volta.',
      name: 'baseExplanation',
      desc: '',
      args: [maxPoints],
    );
  }

  /// `Creato da te`
  String get createdByYou {
    return Intl.message(
      'Creato da te',
      name: 'createdByYou',
      desc: '',
      args: [],
    );
  }

  /// `Di {name}`
  String createdBy(Object name) {
    return Intl.message('Di $name', name: 'createdBy', desc: '', args: [name]);
  }

  /// `a`
  String get sentToConnector {
    return Intl.message('a', name: 'sentToConnector', desc: '', args: []);
  }

  /// `Eliminare “{name}”?`
  String deleteTemplateTitle(Object name) {
    return Intl.message(
      'Eliminare “$name”?',
      name: 'deleteTemplateTitle',
      desc: '',
      args: [name],
    );
  }

  /// `Verrà rimosso dalla libreria. I colleghi che l'hanno già ricevuto lo conservano.`
  String get deleteTemplateBody {
    return Intl.message(
      'Verrà rimosso dalla libreria. I colleghi che l\'hanno già ricevuto lo conservano.',
      name: 'deleteTemplateBody',
      desc: '',
      args: [],
    );
  }

  /// `“{name}” aggiunto alla libreria`
  String templateAdded(Object name) {
    return Intl.message(
      '“$name” aggiunto alla libreria',
      name: 'templateAdded',
      desc: '',
      args: [name],
    );
  }

  /// `Impossibile creare il traguardo. Riprova.`
  String get templateCreateError {
    return Intl.message(
      'Impossibile creare il traguardo. Riprova.',
      name: 'templateCreateError',
      desc: '',
      args: [],
    );
  }

  /// `“{name}” eliminato`
  String templateDeleted(Object name) {
    return Intl.message(
      '“$name” eliminato',
      name: 'templateDeleted',
      desc: '',
      args: [name],
    );
  }

  /// `Impossibile eliminare il traguardo. Riprova.`
  String get templateDeleteError {
    return Intl.message(
      'Impossibile eliminare il traguardo. Riprova.',
      name: 'templateDeleteError',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile caricare i tuoi colleghi. Riprova.`
  String get sendLoadError {
    return Intl.message(
      'Impossibile caricare i tuoi colleghi. Riprova.',
      name: 'sendLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Nella tua azienda non ci sono ancora colleghi.`
  String get sendNoColleagues {
    return Intl.message(
      'Nella tua azienda non ci sono ancora colleghi.',
      name: 'sendNoColleagues',
      desc: '',
      args: [],
    );
  }

  /// `Crea prima un traguardo base.`
  String get sendNoTemplates {
    return Intl.message(
      'Crea prima un traguardo base.',
      name: 'sendNoTemplates',
      desc: '',
      args: [],
    );
  }

  /// `Traguardo inviato a {name}`
  String sendSuccess(Object name) {
    return Intl.message(
      'Traguardo inviato a $name',
      name: 'sendSuccess',
      desc: '',
      args: [name],
    );
  }

  /// `Impossibile inviare il traguardo. Riprova.`
  String get sendError {
    return Intl.message(
      'Impossibile inviare il traguardo. Riprova.',
      name: 'sendError',
      desc: '',
      args: [],
    );
  }

  /// `Riconosci il merito di un collega con uno dei tuoi traguardi base.`
  String get sendDialogSubtitle {
    return Intl.message(
      'Riconosci il merito di un collega con uno dei tuoi traguardi base.',
      name: 'sendDialogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Scegli un traguardo per vedere come apparirà.`
  String get sendPreviewHint {
    return Intl.message(
      'Scegli un traguardo per vedere come apparirà.',
      name: 'sendPreviewHint',
      desc: '',
      args: [],
    );
  }

  /// `Collega`
  String get fieldColleague {
    return Intl.message('Collega', name: 'fieldColleague', desc: '', args: []);
  }

  /// `Traguardo`
  String get fieldAchievement {
    return Intl.message(
      'Traguardo',
      name: 'fieldAchievement',
      desc: '',
      args: [],
    );
  }

  /// `Messaggio (facoltativo)`
  String get fieldMessageOptional {
    return Intl.message(
      'Messaggio (facoltativo)',
      name: 'fieldMessageOptional',
      desc: '',
      args: [],
    );
  }

  /// `Spiega perché se lo merita`
  String get messageHint {
    return Intl.message(
      'Spiega perché se lo merita',
      name: 'messageHint',
      desc: '',
      args: [],
    );
  }

  /// `Già inviato a questo collega`
  String get alreadySentToColleague {
    return Intl.message(
      'Già inviato a questo collega',
      name: 'alreadySentToColleague',
      desc: '',
      args: [],
    );
  }

  /// `Chiunque nella tua azienda può inviarlo a un collega.`
  String get createDialogSubtitle {
    return Intl.message(
      'Chiunque nella tua azienda può inviarlo a un collega.',
      name: 'createDialogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Nome del traguardo`
  String get achievementNamePlaceholder {
    return Intl.message(
      'Nome del traguardo',
      name: 'achievementNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Nome`
  String get fieldName {
    return Intl.message('Nome', name: 'fieldName', desc: '', args: []);
  }

  /// `es. Team Player`
  String get nameHint {
    return Intl.message(
      'es. Team Player',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `Dagli un nome`
  String get templateNameRequired {
    return Intl.message(
      'Dagli un nome',
      name: 'templateNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Descrizione`
  String get fieldDescription {
    return Intl.message(
      'Descrizione',
      name: 'fieldDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cosa bisogna fare per meritarlo?`
  String get descriptionHint {
    return Intl.message(
      'Cosa bisogna fare per meritarlo?',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Aggiungi una breve descrizione`
  String get descriptionRequired {
    return Intl.message(
      'Aggiungi una breve descrizione',
      name: 'descriptionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Esperienza`
  String get fieldExperience {
    return Intl.message(
      'Esperienza',
      name: 'fieldExperience',
      desc: '',
      args: [],
    );
  }

  /// `I traguardi base valgono meno di quelli verificati rilasciati dalla tua azienda.`
  String get experienceNote {
    return Intl.message(
      'I traguardi base valgono meno di quelli verificati rilasciati dalla tua azienda.',
      name: 'experienceNote',
      desc: '',
      args: [],
    );
  }

  /// `Icona`
  String get fieldIcon {
    return Intl.message('Icona', name: 'fieldIcon', desc: '', args: []);
  }

  /// `Foto`
  String get fieldPhoto {
    return Intl.message('Foto', name: 'fieldPhoto', desc: '', args: []);
  }

  /// `Carica foto`
  String get uploadPhoto {
    return Intl.message('Carica foto', name: 'uploadPhoto', desc: '', args: []);
  }

  /// `Copertina`
  String get fieldCover {
    return Intl.message('Copertina', name: 'fieldCover', desc: '', args: []);
  }

  /// `Nome e cognome`
  String get fieldFullName {
    return Intl.message(
      'Nome e cognome',
      name: 'fieldFullName',
      desc: '',
      args: [],
    );
  }

  /// `Inserisci il tuo nome`
  String get nameRequired {
    return Intl.message(
      'Inserisci il tuo nome',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Ruolo`
  String get fieldRole {
    return Intl.message('Ruolo', name: 'fieldRole', desc: '', args: []);
  }

  /// `Inserisci il tuo ruolo`
  String get roleRequired {
    return Intl.message(
      'Inserisci il tuo ruolo',
      name: 'roleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get fieldBio {
    return Intl.message('Bio', name: 'fieldBio', desc: '', args: []);
  }

  /// `Una riga su di te e su cosa fai`
  String get bioHint {
    return Intl.message(
      'Una riga su di te e su cosa fai',
      name: 'bioHint',
      desc: '',
      args: [],
    );
  }

  /// `Salva profilo`
  String get saveProfile {
    return Intl.message(
      'Salva profilo',
      name: 'saveProfile',
      desc: '',
      args: [],
    );
  }

  /// `Sostituisci immagine`
  String get replaceImage {
    return Intl.message(
      'Sostituisci immagine',
      name: 'replaceImage',
      desc: '',
      args: [],
    );
  }

  /// `Carica immagine`
  String get uploadImage {
    return Intl.message(
      'Carica immagine',
      name: 'uploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Grafite`
  String get bannerGraphite {
    return Intl.message('Grafite', name: 'bannerGraphite', desc: '', args: []);
  }

  /// `Oro`
  String get bannerGold {
    return Intl.message('Oro', name: 'bannerGold', desc: '', args: []);
  }

  /// `Foresta`
  String get bannerForest {
    return Intl.message('Foresta', name: 'bannerForest', desc: '', args: []);
  }

  /// `Oceano`
  String get bannerOcean {
    return Intl.message('Oceano', name: 'bannerOcean', desc: '', args: []);
  }

  /// `Argilla`
  String get bannerClay {
    return Intl.message('Argilla', name: 'bannerClay', desc: '', args: []);
  }

  /// `Sabbia`
  String get bannerSand {
    return Intl.message('Sabbia', name: 'bannerSand', desc: '', args: []);
  }

  /// `Aspetto`
  String get settingsAppearance {
    return Intl.message(
      'Aspetto',
      name: 'settingsAppearance',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get settingsAccount {
    return Intl.message('Account', name: 'settingsAccount', desc: '', args: []);
  }

  /// `Informazioni`
  String get settingsAbout {
    return Intl.message(
      'Informazioni',
      name: 'settingsAbout',
      desc: '',
      args: [],
    );
  }

  /// `Scegli l'aspetto di Scoreboard`
  String get appearanceSubtitle {
    return Intl.message(
      'Scegli l\'aspetto di Scoreboard',
      name: 'appearanceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Tema`
  String get themeTitle {
    return Intl.message('Tema', name: 'themeTitle', desc: '', args: []);
  }

  /// `Chiaro`
  String get themeLight {
    return Intl.message('Chiaro', name: 'themeLight', desc: '', args: []);
  }

  /// `Scuro`
  String get themeDark {
    return Intl.message('Scuro', name: 'themeDark', desc: '', args: []);
  }

  /// `Lingua`
  String get languageTitle {
    return Intl.message('Lingua', name: 'languageTitle', desc: '', args: []);
  }

  /// `Sistema`
  String get languageSystem {
    return Intl.message('Sistema', name: 'languageSystem', desc: '', args: []);
  }

  /// `Dati di accesso. Nome, foto e copertina si modificano dal profilo.`
  String get accountSubtitle {
    return Intl.message(
      'Dati di accesso. Nome, foto e copertina si modificano dal profilo.',
      name: 'accountSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get fieldEmail {
    return Intl.message('Email', name: 'fieldEmail', desc: '', args: []);
  }

  /// `Inserisci un indirizzo email valido`
  String get invalidEmail {
    return Intl.message(
      'Inserisci un indirizzo email valido',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordSection {
    return Intl.message(
      'Password',
      name: 'passwordSection',
      desc: '',
      args: [],
    );
  }

  /// `Password attuale`
  String get currentPassword {
    return Intl.message(
      'Password attuale',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Inserisci la password attuale`
  String get currentPasswordRequired {
    return Intl.message(
      'Inserisci la password attuale',
      name: 'currentPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Nuova password`
  String get newPassword {
    return Intl.message(
      'Nuova password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Almeno {min} caratteri`
  String passwordMinLength(int min) {
    return Intl.message(
      'Almeno $min caratteri',
      name: 'passwordMinLength',
      desc: '',
      args: [min],
    );
  }

  /// `Conferma nuova password`
  String get confirmNewPassword {
    return Intl.message(
      'Conferma nuova password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Le password non coincidono`
  String get passwordsDontMatch {
    return Intl.message(
      'Le password non coincidono',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Cambia password`
  String get changePassword {
    return Intl.message(
      'Cambia password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Sessione`
  String get sessionSection {
    return Intl.message('Sessione', name: 'sessionSection', desc: '', args: []);
  }

  /// `Esci da Scoreboard su questo computer.`
  String get signOutDescription {
    return Intl.message(
      'Esci da Scoreboard su questo computer.',
      name: 'signOutDescription',
      desc: '',
      args: [],
    );
  }

  /// `Esci`
  String get signOut {
    return Intl.message('Esci', name: 'signOut', desc: '', args: []);
  }

  /// `Versione {version}`
  String versionLabel(Object version) {
    return Intl.message(
      'Versione $version',
      name: 'versionLabel',
      desc: '',
      args: [version],
    );
  }

  /// `Email aggiornata`
  String get emailUpdated {
    return Intl.message(
      'Email aggiornata',
      name: 'emailUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile salvare l'email. Riprova.`
  String get emailSaveError {
    return Intl.message(
      'Impossibile salvare l\'email. Riprova.',
      name: 'emailSaveError',
      desc: '',
      args: [],
    );
  }

  /// `Password cambiata`
  String get passwordChanged {
    return Intl.message(
      'Password cambiata',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile cambiare la password. Riprova.`
  String get passwordChangeError {
    return Intl.message(
      'Impossibile cambiare la password. Riprova.',
      name: 'passwordChangeError',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile uscire. Riprova.`
  String get signOutError {
    return Intl.message(
      'Impossibile uscire. Riprova.',
      name: 'signOutError',
      desc: '',
      args: [],
    );
  }

  /// `Ti diamo il bentornato`
  String get authWelcomeBack {
    return Intl.message(
      'Ti diamo il bentornato',
      name: 'authWelcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Accedi per vedere i tuoi traguardi.`
  String get authSignInSubtitle {
    return Intl.message(
      'Accedi per vedere i tuoi traguardi.',
      name: 'authSignInSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Crea il tuo account`
  String get authCreateTitle {
    return Intl.message(
      'Crea il tuo account',
      name: 'authCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entra nello scoreboard della tua azienda.`
  String get authCreateSubtitle {
    return Intl.message(
      'Entra nello scoreboard della tua azienda.',
      name: 'authCreateSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Accedi`
  String get signIn {
    return Intl.message('Accedi', name: 'signIn', desc: '', args: []);
  }

  /// `Crea account`
  String get createAccount {
    return Intl.message(
      'Crea account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Mostra password`
  String get showPassword {
    return Intl.message(
      'Mostra password',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Nascondi password`
  String get hidePassword {
    return Intl.message(
      'Nascondi password',
      name: 'hidePassword',
      desc: '',
      args: [],
    );
  }

  /// `Email di lavoro`
  String get workEmail {
    return Intl.message(
      'Email di lavoro',
      name: 'workEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Inserisci la password`
  String get passwordRequired {
    return Intl.message(
      'Inserisci la password',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Scegli la tua azienda`
  String get chooseCompany {
    return Intl.message(
      'Scegli la tua azienda',
      name: 'chooseCompany',
      desc: '',
      args: [],
    );
  }

  /// `Conferma`
  String get confirmLabel {
    return Intl.message('Conferma', name: 'confirmLabel', desc: '', args: []);
  }

  /// `Account demo: {email} / {password}`
  String demoAccount(Object email, Object password) {
    return Intl.message(
      'Account demo: $email / $password',
      name: 'demoAccount',
      desc: '',
      args: [email, password],
    );
  }

  /// `Usalo`
  String get useDemo {
    return Intl.message('Usalo', name: 'useDemo', desc: '', args: []);
  }

  /// `Ogni traguardo,\nnero su bianco.`
  String get authTagline {
    return Intl.message(
      'Ogni traguardo,\nnero su bianco.',
      name: 'authTagline',
      desc: '',
      args: [],
    );
  }

  /// `Raccogli i traguardi rilasciati dalla tua azienda e riconosci il merito dei colleghi che fanno la differenza.`
  String get authPitch {
    return Intl.message(
      'Raccogli i traguardi rilasciati dalla tua azienda e riconosci il merito dei colleghi che fanno la differenza.',
      name: 'authPitch',
      desc: '',
      args: [],
    );
  }

  /// `Non hai effettuato l'accesso.`
  String get errorNotSignedIn {
    return Intl.message(
      'Non hai effettuato l\'accesso.',
      name: 'errorNotSignedIn',
      desc: '',
      args: [],
    );
  }

  /// `Email o password errate.`
  String get errorWrongCredentials {
    return Intl.message(
      'Email o password errate.',
      name: 'errorWrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Esiste già un account con questa email.`
  String get errorEmailTaken {
    return Intl.message(
      'Esiste già un account con questa email.',
      name: 'errorEmailTaken',
      desc: '',
      args: [],
    );
  }

  /// `La password attuale non è corretta.`
  String get errorWrongCurrentPassword {
    return Intl.message(
      'La password attuale non è corretta.',
      name: 'errorWrongCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Inserisci email e password.`
  String get errorMissingCredentials {
    return Intl.message(
      'Inserisci email e password.',
      name: 'errorMissingCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Inserisci nome e ruolo.`
  String get errorMissingNameOrRole {
    return Intl.message(
      'Inserisci nome e ruolo.',
      name: 'errorMissingNameOrRole',
      desc: '',
      args: [],
    );
  }

  /// `La password deve avere almeno {min} caratteri.`
  String errorPasswordTooShort(int min) {
    return Intl.message(
      'La password deve avere almeno $min caratteri.',
      name: 'errorPasswordTooShort',
      desc: '',
      args: [min],
    );
  }

  /// `I traguardi base possono valere {values} XP.`
  String errorInvalidPoints(Object values) {
    return Intl.message(
      'I traguardi base possono valere $values XP.',
      name: 'errorInvalidPoints',
      desc: '',
      args: [values],
    );
  }

  /// `Puoi eliminare solo i traguardi base che hai creato tu.`
  String get errorNotTemplateOwner {
    return Intl.message(
      'Puoi eliminare solo i traguardi base che hai creato tu.',
      name: 'errorNotTemplateOwner',
      desc: '',
      args: [],
    );
  }

  /// `Puoi inviare traguardi solo ai colleghi della tua azienda.`
  String get errorNotAColleague {
    return Intl.message(
      'Puoi inviare traguardi solo ai colleghi della tua azienda.',
      name: 'errorNotAColleague',
      desc: '',
      args: [],
    );
  }

  /// `Questo traguardo base non esiste più.`
  String get errorTemplateNotFound {
    return Intl.message(
      'Questo traguardo base non esiste più.',
      name: 'errorTemplateNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Hai già inviato “{template}” a {colleague}.`
  String errorAlreadySent(Object template, Object colleague) {
    return Intl.message(
      'Hai già inviato “$template” a $colleague.',
      name: 'errorAlreadySent',
      desc: '',
      args: [template, colleague],
    );
  }

  /// `Condividi su LinkedIn`
  String get shareOnLinkedIn {
    return Intl.message(
      'Condividi su LinkedIn',
      name: 'shareOnLinkedIn',
      desc: '',
      args: [],
    );
  }

  /// `Pubblica un post o aggiungilo al tuo profilo LinkedIn.`
  String get shareDialogSubtitle {
    return Intl.message(
      'Pubblica un post o aggiungilo al tuo profilo LinkedIn.',
      name: 'shareDialogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Testo del post`
  String get sharePostLabel {
    return Intl.message(
      'Testo del post',
      name: 'sharePostLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pubblica su LinkedIn`
  String get shareOpenLinkedIn {
    return Intl.message(
      'Pubblica su LinkedIn',
      name: 'shareOpenLinkedIn',
      desc: '',
      args: [],
    );
  }

  /// `Aggiungi al profilo`
  String get shareAddToProfile {
    return Intl.message(
      'Aggiungi al profilo',
      name: 'shareAddToProfile',
      desc: '',
      args: [],
    );
  }

  /// `Lo aggiunge a Licenze e certificazioni, con {company} come ente emittente.`
  String shareAddToProfileHint(Object company) {
    return Intl.message(
      'Lo aggiunge a Licenze e certificazioni, con $company come ente emittente.',
      name: 'shareAddToProfileHint',
      desc: '',
      args: [company],
    );
  }

  /// `Copia testo`
  String get shareCopyText {
    return Intl.message(
      'Copia testo',
      name: 'shareCopyText',
      desc: '',
      args: [],
    );
  }

  /// `Salva immagine`
  String get shareSaveImage {
    return Intl.message(
      'Salva immagine',
      name: 'shareSaveImage',
      desc: '',
      args: [],
    );
  }

  /// `LinkedIn non permette di allegare immagini da un link: salvala e aggiungila al post.`
  String get shareImageHint {
    return Intl.message(
      'LinkedIn non permette di allegare immagini da un link: salvala e aggiungila al post.',
      name: 'shareImageHint',
      desc: '',
      args: [],
    );
  }

  /// `Testo copiato negli appunti`
  String get shareTextCopied {
    return Intl.message(
      'Testo copiato negli appunti',
      name: 'shareTextCopied',
      desc: '',
      args: [],
    );
  }

  /// `Testo copiato: se LinkedIn non lo inserisce, incollalo nel post.`
  String get shareOpened {
    return Intl.message(
      'Testo copiato: se LinkedIn non lo inserisce, incollalo nel post.',
      name: 'shareOpened',
      desc: '',
      args: [],
    );
  }

  /// `Immagine salvata`
  String get shareImageSaved {
    return Intl.message(
      'Immagine salvata',
      name: 'shareImageSaved',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile salvare l'immagine. Riprova.`
  String get shareSaveError {
    return Intl.message(
      'Impossibile salvare l\'immagine. Riprova.',
      name: 'shareSaveError',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile aprire LinkedIn.`
  String get shareOpenError {
    return Intl.message(
      'Impossibile aprire LinkedIn.',
      name: 'shareOpenError',
      desc: '',
      args: [],
    );
  }

  /// `🏆 Ho ottenuto il traguardo “{name}”, rilasciato da {company}.\n\n{description}\n\n#Scoreboard`
  String sharePostVerified(Object name, Object company, Object description) {
    return Intl.message(
      '🏆 Ho ottenuto il traguardo “$name”, rilasciato da $company.\n\n$description\n\n#Scoreboard',
      name: 'sharePostVerified',
      desc: '',
      args: [name, company, description],
    );
  }

  /// `🤝 {sender} mi ha assegnato il traguardo “{name}”.\n\n{description}\n\n#Scoreboard`
  String sharePostPeer(Object sender, Object name, Object description) {
    return Intl.message(
      '🤝 $sender mi ha assegnato il traguardo “$name”.\n\n$description\n\n#Scoreboard',
      name: 'sharePostPeer',
      desc: '',
      args: [sender, name, description],
    );
  }

  /// `TRAGUARDO SBLOCCATO`
  String get shareImageHeadline {
    return Intl.message(
      'TRAGUARDO SBLOCCATO',
      name: 'shareImageHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Rilasciato da {company}`
  String shareImageIssuedBy(Object company) {
    return Intl.message(
      'Rilasciato da $company',
      name: 'shareImageIssuedBy',
      desc: '',
      args: [company],
    );
  }

  /// `Chiudi`
  String get commonClose {
    return Intl.message('Chiudi', name: 'commonClose', desc: '', args: []);
  }

  /// `Bacheca`
  String get navFeed {
    return Intl.message('Bacheca', name: 'navFeed', desc: '', args: []);
  }

  /// `Console azienda`
  String get navConsole {
    return Intl.message(
      'Console azienda',
      name: 'navConsole',
      desc: '',
      args: [],
    );
  }

  /// `Notifiche`
  String get notificationsTitle {
    return Intl.message(
      'Notifiche',
      name: 'notificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Apri le notifiche`
  String get notificationsOpen {
    return Intl.message(
      'Apri le notifiche',
      name: 'notificationsOpen',
      desc: '',
      args: [],
    );
  }

  /// `Segna tutte come lette`
  String get markAllRead {
    return Intl.message(
      'Segna tutte come lette',
      name: 'markAllRead',
      desc: '',
      args: [],
    );
  }

  /// `Nessuna notifica, per ora.`
  String get notificationsEmpty {
    return Intl.message(
      'Nessuna notifica, per ora.',
      name: 'notificationsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Nuovo traguardo`
  String get notifPeerTitle {
    return Intl.message(
      'Nuovo traguardo',
      name: 'notifPeerTitle',
      desc: '',
      args: [],
    );
  }

  /// `{actor} ti ha inviato “{achievement}”`
  String notifPeerBody(Object actor, Object achievement) {
    return Intl.message(
      '$actor ti ha inviato “$achievement”',
      name: 'notifPeerBody',
      desc: '',
      args: [actor, achievement],
    );
  }

  /// `Traguardo verificato`
  String get notifVerifiedTitle {
    return Intl.message(
      'Traguardo verificato',
      name: 'notifVerifiedTitle',
      desc: '',
      args: [],
    );
  }

  /// `{company} ti ha rilasciato “{achievement}”`
  String notifVerifiedBody(Object company, Object achievement) {
    return Intl.message(
      '$company ti ha rilasciato “$achievement”',
      name: 'notifVerifiedBody',
      desc: '',
      args: [company, achievement],
    );
  }

  /// `Nuovo livello!`
  String get notifLevelUpTitle {
    return Intl.message(
      'Nuovo livello!',
      name: 'notifLevelUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Hai raggiunto il livello {level}`
  String notifLevelUpBody(int level) {
    return Intl.message(
      'Hai raggiunto il livello $level',
      name: 'notifLevelUpBody',
      desc: '',
      args: [level],
    );
  }

  /// `Richiesta approvata`
  String get notifApprovedTitle {
    return Intl.message(
      'Richiesta approvata',
      name: 'notifApprovedTitle',
      desc: '',
      args: [],
    );
  }

  /// `“{achievement}” è stato approvato ed è nei tuoi traguardi`
  String notifApprovedBody(Object achievement) {
    return Intl.message(
      '“$achievement” è stato approvato ed è nei tuoi traguardi',
      name: 'notifApprovedBody',
      desc: '',
      args: [achievement],
    );
  }

  /// `Richiesta respinta`
  String get notifRejectedTitle {
    return Intl.message(
      'Richiesta respinta',
      name: 'notifRejectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `“{achievement}” non è stato approvato`
  String notifRejectedBody(Object achievement) {
    return Intl.message(
      '“$achievement” non è stato approvato',
      name: 'notifRejectedBody',
      desc: '',
      args: [achievement],
    );
  }

  /// `“{achievement}” non è stato approvato: {reason}`
  String notifRejectedBodyReason(Object achievement, Object reason) {
    return Intl.message(
      '“$achievement” non è stato approvato: $reason',
      name: 'notifRejectedBodyReason',
      desc: '',
      args: [achievement, reason],
    );
  }

  /// `Nuova richiesta`
  String get notifNewRequestTitle {
    return Intl.message(
      'Nuova richiesta',
      name: 'notifNewRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `{actor} chiede “{achievement}”`
  String notifNewRequestBody(Object actor, Object achievement) {
    return Intl.message(
      '$actor chiede “$achievement”',
      name: 'notifNewRequestBody',
      desc: '',
      args: [actor, achievement],
    );
  }

  /// `Nuova reazione`
  String get notifReactionTitle {
    return Intl.message(
      'Nuova reazione',
      name: 'notifReactionTitle',
      desc: '',
      args: [],
    );
  }

  /// `{actor} ha reagito a “{achievement}”`
  String notifReactionBody(Object actor, Object achievement) {
    return Intl.message(
      '$actor ha reagito a “$achievement”',
      name: 'notifReactionBody',
      desc: '',
      args: [actor, achievement],
    );
  }

  /// `Nuovo commento`
  String get notifCommentTitle {
    return Intl.message(
      'Nuovo commento',
      name: 'notifCommentTitle',
      desc: '',
      args: [],
    );
  }

  /// `{actor} ha commentato “{achievement}”: {text}`
  String notifCommentBody(Object actor, Object achievement, Object text) {
    return Intl.message(
      '$actor ha commentato “$achievement”: $text',
      name: 'notifCommentBody',
      desc: '',
      args: [actor, achievement, text],
    );
  }

  /// `Il tuo riepilogo settimanale`
  String get notifRecapTitle {
    return Intl.message(
      'Il tuo riepilogo settimanale',
      name: 'notifRecapTitle',
      desc: '',
      args: [],
    );
  }

  /// `Questa settimana: +{xp} XP · posizione #{rank}`
  String notifRecapBody(int xp, int rank) {
    return Intl.message(
      'Questa settimana: +$xp XP · posizione #$rank',
      name: 'notifRecapBody',
      desc: '',
      args: [xp, rank],
    );
  }

  /// `Adesso`
  String get timeJustNow {
    return Intl.message('Adesso', name: 'timeJustNow', desc: '', args: []);
  }

  /// `{count} min fa`
  String timeMinutes(int count) {
    return Intl.message(
      '$count min fa',
      name: 'timeMinutes',
      desc: '',
      args: [count],
    );
  }

  /// `{count} h fa`
  String timeHours(int count) {
    return Intl.message(
      '$count h fa',
      name: 'timeHours',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Ieri} other{{count} giorni fa}}`
  String timeDays(int count) {
    return Intl.plural(
      count,
      one: 'Ieri',
      other: '$count giorni fa',
      name: 'timeDays',
      desc: '',
      args: [count],
    );
  }

  /// `Bacheca dell'azienda`
  String get feedTitle {
    return Intl.message(
      'Bacheca dell\'azienda',
      name: 'feedTitle',
      desc: '',
      args: [],
    );
  }

  /// `I traguardi dei tuoi colleghi, da festeggiare insieme`
  String get feedSubtitle {
    return Intl.message(
      'I traguardi dei tuoi colleghi, da festeggiare insieme',
      name: 'feedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `ha ottenuto`
  String get feedEarned {
    return Intl.message('ha ottenuto', name: 'feedEarned', desc: '', args: []);
  }

  /// `Ancora niente in bacheca.`
  String get feedEmpty {
    return Intl.message(
      'Ancora niente in bacheca.',
      name: 'feedEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Mi piace`
  String get reactionLike {
    return Intl.message('Mi piace', name: 'reactionLike', desc: '', args: []);
  }

  /// `Festeggio`
  String get reactionCelebrate {
    return Intl.message(
      'Festeggio',
      name: 'reactionCelebrate',
      desc: '',
      args: [],
    );
  }

  /// `Adoro`
  String get reactionLove {
    return Intl.message('Adoro', name: 'reactionLove', desc: '', args: []);
  }

  /// `Geniale`
  String get reactionInsightful {
    return Intl.message(
      'Geniale',
      name: 'reactionInsightful',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{Commenta} one{1 commento} other{{count} commenti}}`
  String commentsCount(int count) {
    return Intl.plural(
      count,
      zero: 'Commenta',
      one: '1 commento',
      other: '$count commenti',
      name: 'commentsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Scrivi un commento…`
  String get commentHint {
    return Intl.message(
      'Scrivi un commento…',
      name: 'commentHint',
      desc: '',
      args: [],
    );
  }

  /// `Gestisci i traguardi verificati di {company}`
  String consoleSubtitle(Object company) {
    return Intl.message(
      'Gestisci i traguardi verificati di $company',
      name: 'consoleSubtitle',
      desc: '',
      args: [company],
    );
  }

  /// `Catalogo`
  String get consoleCatalog {
    return Intl.message('Catalogo', name: 'consoleCatalog', desc: '', args: []);
  }

  /// `Assegna`
  String get consoleAssign {
    return Intl.message('Assegna', name: 'consoleAssign', desc: '', args: []);
  }

  /// `Richieste · {count}`
  String consoleRequests(int count) {
    return Intl.message(
      'Richieste · $count',
      name: 'consoleRequests',
      desc: '',
      args: [count],
    );
  }

  /// `Nuovo traguardo verificato`
  String get newCatalogAchievement {
    return Intl.message(
      'Nuovo traguardo verificato',
      name: 'newCatalogAchievement',
      desc: '',
      args: [],
    );
  }

  /// `Modifica traguardo`
  String get editCatalogAchievement {
    return Intl.message(
      'Modifica traguardo',
      name: 'editCatalogAchievement',
      desc: '',
      args: [],
    );
  }

  /// `Solo gli admin possono rilasciarlo, e chi lo riceve lo vede come verificato.`
  String get catalogDialogSubtitle {
    return Intl.message(
      'Solo gli admin possono rilasciarlo, e chi lo riceve lo vede come verificato.',
      name: 'catalogDialogSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Modifica`
  String get commonEdit {
    return Intl.message('Modifica', name: 'commonEdit', desc: '', args: []);
  }

  /// `Archivia`
  String get archive {
    return Intl.message('Archivia', name: 'archive', desc: '', args: []);
  }

  /// `Ripristina`
  String get restore {
    return Intl.message('Ripristina', name: 'restore', desc: '', args: []);
  }

  /// `Archiviato`
  String get archivedLabel {
    return Intl.message(
      'Archiviato',
      name: 'archivedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Mostra archiviati`
  String get showArchived {
    return Intl.message(
      'Mostra archiviati',
      name: 'showArchived',
      desc: '',
      args: [],
    );
  }

  /// `Il catalogo è vuoto. Crea il primo traguardo.`
  String get catalogEmpty {
    return Intl.message(
      'Il catalogo è vuoto. Crea il primo traguardo.',
      name: 'catalogEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Catalogo aggiornato`
  String get catalogSaved {
    return Intl.message(
      'Catalogo aggiornato',
      name: 'catalogSaved',
      desc: '',
      args: [],
    );
  }

  /// `Il valore decide la categoria: Bronzo sotto 100 XP, Argento da 100, Oro da 120, Platino da 140.`
  String get catalogPointsHint {
    return Intl.message(
      'Il valore decide la categoria: Bronzo sotto 100 XP, Argento da 100, Oro da 120, Platino da 140.',
      name: 'catalogPointsHint',
      desc: '',
      args: [],
    );
  }

  /// `Seleziona tutti`
  String get selectAll {
    return Intl.message(
      'Seleziona tutti',
      name: 'selectAll',
      desc: '',
      args: [],
    );
  }

  /// `Lo ha già`
  String get alreadyHasIt {
    return Intl.message('Lo ha già', name: 'alreadyHasIt', desc: '', args: []);
  }

  /// `Nota (facoltativa)`
  String get assignNoteLabel {
    return Intl.message(
      'Nota (facoltativa)',
      name: 'assignNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Un messaggio per chi lo riceve`
  String get assignNoteHint {
    return Intl.message(
      'Un messaggio per chi lo riceve',
      name: 'assignNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{Assegna} one{Assegna a 1 persona} other{Assegna a {count} persone}}`
  String assignButton(int count) {
    return Intl.plural(
      count,
      zero: 'Assegna',
      one: 'Assegna a 1 persona',
      other: 'Assegna a $count persone',
      name: 'assignButton',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, one{Assegnato a 1 persona} other{Assegnato a {count} persone}}`
  String issuedCount(int count) {
    return Intl.plural(
      count,
      one: 'Assegnato a 1 persona',
      other: 'Assegnato a $count persone',
      name: 'issuedCount',
      desc: '',
      args: [count],
    );
  }

  /// `Scegli un traguardo dal catalogo.`
  String get pickAchievementHint {
    return Intl.message(
      'Scegli un traguardo dal catalogo.',
      name: 'pickAchievementHint',
      desc: '',
      args: [],
    );
  }

  /// `Nessuna richiesta.`
  String get requestsEmpty {
    return Intl.message(
      'Nessuna richiesta.',
      name: 'requestsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `In attesa`
  String get pendingSection {
    return Intl.message(
      'In attesa',
      name: 'pendingSection',
      desc: '',
      args: [],
    );
  }

  /// `Già decise`
  String get decidedSection {
    return Intl.message(
      'Già decise',
      name: 'decidedSection',
      desc: '',
      args: [],
    );
  }

  /// `Approva`
  String get approve {
    return Intl.message('Approva', name: 'approve', desc: '', args: []);
  }

  /// `Respingi`
  String get reject {
    return Intl.message('Respingi', name: 'reject', desc: '', args: []);
  }

  /// `Respingere la richiesta?`
  String get rejectDialogTitle {
    return Intl.message(
      'Respingere la richiesta?',
      name: 'rejectDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Motivazione (facoltativa)`
  String get rejectReasonHint {
    return Intl.message(
      'Motivazione (facoltativa)',
      name: 'rejectReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `Richiesta approvata`
  String get requestApprovedMessage {
    return Intl.message(
      'Richiesta approvata',
      name: 'requestApprovedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Richiesta respinta`
  String get requestRejectedMessage {
    return Intl.message(
      'Richiesta respinta',
      name: 'requestRejectedMessage',
      desc: '',
      args: [],
    );
  }

  /// `In attesa`
  String get statusPending {
    return Intl.message('In attesa', name: 'statusPending', desc: '', args: []);
  }

  /// `Approvata`
  String get statusApproved {
    return Intl.message(
      'Approvata',
      name: 'statusApproved',
      desc: '',
      args: [],
    );
  }

  /// `Respinta`
  String get statusRejected {
    return Intl.message('Respinta', name: 'statusRejected', desc: '', args: []);
  }

  /// `Apri la prova`
  String get evidenceLink {
    return Intl.message(
      'Apri la prova',
      name: 'evidenceLink',
      desc: '',
      args: [],
    );
  }

  /// `Motivazione: {reason}`
  String rejectionReason(Object reason) {
    return Intl.message(
      'Motivazione: $reason',
      name: 'rejectionReason',
      desc: '',
      args: [reason],
    );
  }

  /// `Catalogo dell'azienda`
  String get companyCatalog {
    return Intl.message(
      'Catalogo dell\'azienda',
      name: 'companyCatalog',
      desc: '',
      args: [],
    );
  }

  /// `I traguardi verificati che puoi ottenere. Se pensi di meritarne uno, chiedilo.`
  String get companyCatalogHint {
    return Intl.message(
      'I traguardi verificati che puoi ottenere. Se pensi di meritarne uno, chiedilo.',
      name: 'companyCatalogHint',
      desc: '',
      args: [],
    );
  }

  /// `Ottenuto`
  String get earnedLabel {
    return Intl.message('Ottenuto', name: 'earnedLabel', desc: '', args: []);
  }

  /// `Richiedi`
  String get requestAction {
    return Intl.message('Richiedi', name: 'requestAction', desc: '', args: []);
  }

  /// `Le tue richieste`
  String get myRequests {
    return Intl.message(
      'Le tue richieste',
      name: 'myRequests',
      desc: '',
      args: [],
    );
  }

  /// `Richiedi un traguardo`
  String get requestDialogTitle {
    return Intl.message(
      'Richiedi un traguardo',
      name: 'requestDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Un admin di {company} valuterà la tua richiesta.`
  String requestDialogSubtitle(Object company) {
    return Intl.message(
      'Un admin di $company valuterà la tua richiesta.',
      name: 'requestDialogSubtitle',
      desc: '',
      args: [company],
    );
  }

  /// `Messaggio`
  String get requestMessage {
    return Intl.message(
      'Messaggio',
      name: 'requestMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cosa hai fatto per meritarlo?`
  String get requestMessageHint {
    return Intl.message(
      'Cosa hai fatto per meritarlo?',
      name: 'requestMessageHint',
      desc: '',
      args: [],
    );
  }

  /// `Scrivi un messaggio`
  String get requestMessageRequired {
    return Intl.message(
      'Scrivi un messaggio',
      name: 'requestMessageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Link a una prova (facoltativo)`
  String get evidenceUrlLabel {
    return Intl.message(
      'Link a una prova (facoltativo)',
      name: 'evidenceUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `Inserisci un link http(s) valido`
  String get invalidUrl {
    return Intl.message(
      'Inserisci un link http(s) valido',
      name: 'invalidUrl',
      desc: '',
      args: [],
    );
  }

  /// `Invia richiesta`
  String get submitRequest {
    return Intl.message(
      'Invia richiesta',
      name: 'submitRequest',
      desc: '',
      args: [],
    );
  }

  /// `Richiesta inviata`
  String get requestSent {
    return Intl.message(
      'Richiesta inviata',
      name: 'requestSent',
      desc: '',
      args: [],
    );
  }

  /// `Solo gli admin dell'azienda possono farlo.`
  String get errorNotAdmin {
    return Intl.message(
      'Solo gli admin dell\'azienda possono farlo.',
      name: 'errorNotAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Compila tutti i campi obbligatori.`
  String get errorMissingFields {
    return Intl.message(
      'Compila tutti i campi obbligatori.',
      name: 'errorMissingFields',
      desc: '',
      args: [],
    );
  }

  /// `Il valore deve essere tra {min} e {max} XP.`
  String errorCatalogPoints(int min, int max) {
    return Intl.message(
      'Il valore deve essere tra $min e $max XP.',
      name: 'errorCatalogPoints',
      desc: '',
      args: [min, max],
    );
  }

  /// `Hai già questo traguardo.`
  String get errorAlreadyOwned {
    return Intl.message(
      'Hai già questo traguardo.',
      name: 'errorAlreadyOwned',
      desc: '',
      args: [],
    );
  }

  /// `Hai già una richiesta in attesa per questo traguardo.`
  String get errorRequestPending {
    return Intl.message(
      'Hai già una richiesta in attesa per questo traguardo.',
      name: 'errorRequestPending',
      desc: '',
      args: [],
    );
  }

  /// `Elemento non trovato.`
  String get errorNotFound {
    return Intl.message(
      'Elemento non trovato.',
      name: 'errorNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Operazione non riuscita. Riprova.`
  String get actionError {
    return Intl.message(
      'Operazione non riuscita. Riprova.',
      name: 'actionError',
      desc: '',
      args: [],
    );
  }

  /// `Esporta`
  String get exportMenu {
    return Intl.message('Esporta', name: 'exportMenu', desc: '', args: []);
  }

  /// `Certificato PDF`
  String get exportPdf {
    return Intl.message(
      'Certificato PDF',
      name: 'exportPdf',
      desc: '',
      args: [],
    );
  }

  /// `Open Badge (JSON)`
  String get exportOpenBadge {
    return Intl.message(
      'Open Badge (JSON)',
      name: 'exportOpenBadge',
      desc: '',
      args: [],
    );
  }

  /// `Credenziale Open Badges 3.0. La firma digitale arriverà con il backend.`
  String get exportOpenBadgeHint {
    return Intl.message(
      'Credenziale Open Badges 3.0. La firma digitale arriverà con il backend.',
      name: 'exportOpenBadgeHint',
      desc: '',
      args: [],
    );
  }

  /// `File salvato`
  String get exportSaved {
    return Intl.message(
      'File salvato',
      name: 'exportSaved',
      desc: '',
      args: [],
    );
  }

  /// `Impossibile salvare il file. Riprova.`
  String get exportError {
    return Intl.message(
      'Impossibile salvare il file. Riprova.',
      name: 'exportError',
      desc: '',
      args: [],
    );
  }

  /// `CERTIFICATO DI TRAGUARDO`
  String get certTitle {
    return Intl.message(
      'CERTIFICATO DI TRAGUARDO',
      name: 'certTitle',
      desc: '',
      args: [],
    );
  }

  /// `Si certifica che`
  String get certPresentedTo {
    return Intl.message(
      'Si certifica che',
      name: 'certPresentedTo',
      desc: '',
      args: [],
    );
  }

  /// `ha ottenuto il traguardo`
  String get certHasEarned {
    return Intl.message(
      'ha ottenuto il traguardo',
      name: 'certHasEarned',
      desc: '',
      args: [],
    );
  }

  /// `Rilasciato da {company} il {date}`
  String certIssuedBy(Object company, Object date) {
    return Intl.message(
      'Rilasciato da $company il $date',
      name: 'certIssuedBy',
      desc: '',
      args: [company, date],
    );
  }

  /// `ID credenziale: {id}`
  String certCredentialId(Object id) {
    return Intl.message(
      'ID credenziale: $id',
      name: 'certCredentialId',
      desc: '',
      args: [id],
    );
  }

  /// `Hai già inviato i {budget} traguardi di questo mese. Il budget si rinnova il primo del mese.`
  String errorBudgetExhausted(int budget) {
    return Intl.message(
      'Hai già inviato i $budget traguardi di questo mese. Il budget si rinnova il primo del mese.',
      name: 'errorBudgetExhausted',
      desc: '',
      args: [budget],
    );
  }

  /// `{remaining} di {budget} invii rimasti questo mese`
  String budgetRemaining(int remaining, int budget) {
    return Intl.message(
      '$remaining di $budget invii rimasti questo mese',
      name: 'budgetRemaining',
      desc: '',
      args: [remaining, budget],
    );
  }

  /// `Privacy`
  String get privacySection {
    return Intl.message('Privacy', name: 'privacySection', desc: '', args: []);
  }

  /// `Mostrami nella classifica Community`
  String get privacyCommunityTitle {
    return Intl.message(
      'Mostrami nella classifica Community',
      name: 'privacyCommunityTitle',
      desc: '',
      args: [],
    );
  }

  /// `I colleghi della tua azienda ti vedono comunque nella classifica del team.`
  String get privacyCommunitySubtitle {
    return Intl.message(
      'I colleghi della tua azienda ti vedono comunque nella classifica del team.',
      name: 'privacyCommunitySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Non compari in questa classifica. Puoi cambiarlo in Impostazioni → Account.`
  String get communityHiddenNotice {
    return Intl.message(
      'Non compari in questa classifica. Puoi cambiarlo in Impostazioni → Account.',
      name: 'communityHiddenNotice',
      desc: '',
      args: [],
    );
  }

  /// `Nascosta`
  String get rankHidden {
    return Intl.message('Nascosta', name: 'rankHidden', desc: '', args: []);
  }

  /// `Cerca tra i tuoi traguardi`
  String get searchAchievementsHint {
    return Intl.message(
      'Cerca tra i tuoi traguardi',
      name: 'searchAchievementsHint',
      desc: '',
      args: [],
    );
  }

  /// `Ordina`
  String get sortLabel {
    return Intl.message('Ordina', name: 'sortLabel', desc: '', args: []);
  }

  /// `Più recenti`
  String get sortNewest {
    return Intl.message('Più recenti', name: 'sortNewest', desc: '', args: []);
  }

  /// `Meno recenti`
  String get sortOldest {
    return Intl.message('Meno recenti', name: 'sortOldest', desc: '', args: []);
  }

  /// `Più XP`
  String get sortPoints {
    return Intl.message('Più XP', name: 'sortPoints', desc: '', args: []);
  }

  /// `Nome (A–Z)`
  String get sortName {
    return Intl.message('Nome (A–Z)', name: 'sortName', desc: '', args: []);
  }

  /// `Il tuo primo traguardo ti aspetta`
  String get achievementsEmptyTitle {
    return Intl.message(
      'Il tuo primo traguardo ti aspetta',
      name: 'achievementsEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Chiedi un traguardo verificato dal catalogo della tua azienda, oppure riconosci il lavoro di un collega: spesso è il modo migliore per iniziare.`
  String get achievementsEmptyBody {
    return Intl.message(
      'Chiedi un traguardo verificato dal catalogo della tua azienda, oppure riconosci il lavoro di un collega: spesso è il modo migliore per iniziare.',
      name: 'achievementsEmptyBody',
      desc: '',
      args: [],
    );
  }

  /// `Apri il catalogo`
  String get emptyOpenCatalog {
    return Intl.message(
      'Apri il catalogo',
      name: 'emptyOpenCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Salta`
  String get onboardingSkip {
    return Intl.message('Salta', name: 'onboardingSkip', desc: '', args: []);
  }

  /// `Avanti`
  String get onboardingNext {
    return Intl.message('Avanti', name: 'onboardingNext', desc: '', args: []);
  }

  /// `Inizia`
  String get onboardingDone {
    return Intl.message('Inizia', name: 'onboardingDone', desc: '', args: []);
  }

  /// `Rivedi l'introduzione`
  String get onboardingReplay {
    return Intl.message(
      'Rivedi l\'introduzione',
      name: 'onboardingReplay',
      desc: '',
      args: [],
    );
  }

  /// `Ti diamo il benvenuto in Scoreboard`
  String get onboardingWelcomeTitle {
    return Intl.message(
      'Ti diamo il benvenuto in Scoreboard',
      name: 'onboardingWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Qui raccogli i traguardi che ottieni al lavoro, sotto forma di card da collezionare. Passaci sopra con il mouse e girale per vedere chi le ha rilasciate.`
  String get onboardingWelcomeBody {
    return Intl.message(
      'Qui raccogli i traguardi che ottieni al lavoro, sotto forma di card da collezionare. Passaci sopra con il mouse e girale per vedere chi le ha rilasciate.',
      name: 'onboardingWelcomeBody',
      desc: '',
      args: [],
    );
  }

  /// `Verificati e tra colleghi`
  String get onboardingKindsTitle {
    return Intl.message(
      'Verificati e tra colleghi',
      name: 'onboardingKindsTitle',
      desc: '',
      args: [],
    );
  }

  /// `I traguardi verificati li rilascia la tua azienda: puoi richiederli dal catalogo. Quelli base li scambi con i colleghi, fino a {budget} al mese.`
  String onboardingKindsBody(int budget) {
    return Intl.message(
      'I traguardi verificati li rilascia la tua azienda: puoi richiederli dal catalogo. Quelli base li scambi con i colleghi, fino a $budget al mese.',
      name: 'onboardingKindsBody',
      desc: '',
      args: [budget],
    );
  }

  /// `Festeggiate insieme`
  String get onboardingFeedTitle {
    return Intl.message(
      'Festeggiate insieme',
      name: 'onboardingFeedTitle',
      desc: '',
      args: [],
    );
  }

  /// `In bacheca vedi i traguardi dei colleghi e puoi reagire e commentare. Le notifiche ti avvisano quando succede qualcosa che ti riguarda.`
  String get onboardingFeedBody {
    return Intl.message(
      'In bacheca vedi i traguardi dei colleghi e puoi reagire e commentare. Le notifiche ti avvisano quando succede qualcosa che ti riguarda.',
      name: 'onboardingFeedBody',
      desc: '',
      args: [],
    );
  }

  /// `Vai veloce`
  String get onboardingFastTitle {
    return Intl.message(
      'Vai veloce',
      name: 'onboardingFastTitle',
      desc: '',
      args: [],
    );
  }

  /// `Premi {shortcut} per inviare un traguardo da qualsiasi schermata, oppure usa l'icona nella barra dei menu.`
  String onboardingFastBody(Object shortcut) {
    return Intl.message(
      'Premi $shortcut per inviare un traguardo da qualsiasi schermata, oppure usa l\'icona nella barra dei menu.',
      name: 'onboardingFastBody',
      desc: '',
      args: [shortcut],
    );
  }

  /// `Scorciatoie da tastiera`
  String get shortcutsSection {
    return Intl.message(
      'Scorciatoie da tastiera',
      name: 'shortcutsSection',
      desc: '',
      args: [],
    );
  }

  /// `Vai alla pagina 1–8`
  String get shortcutGoToPage {
    return Intl.message(
      'Vai alla pagina 1–8',
      name: 'shortcutGoToPage',
      desc: '',
      args: [],
    );
  }

  /// `Apri Scoreboard`
  String get trayOpen {
    return Intl.message(
      'Apri Scoreboard',
      name: 'trayOpen',
      desc: '',
      args: [],
    );
  }

  /// `Esci da Scoreboard`
  String get trayQuit {
    return Intl.message(
      'Esci da Scoreboard',
      name: 'trayQuit',
      desc: '',
      args: [],
    );
  }

  /// `Aggiornamenti`
  String get updatesSection {
    return Intl.message(
      'Aggiornamenti',
      name: 'updatesSection',
      desc: '',
      args: [],
    );
  }

  /// `Verifica aggiornamenti`
  String get checkForUpdates {
    return Intl.message(
      'Verifica aggiornamenti',
      name: 'checkForUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Hai l'ultima versione.`
  String get upToDate {
    return Intl.message(
      'Hai l\'ultima versione.',
      name: 'upToDate',
      desc: '',
      args: [],
    );
  }

  /// `È disponibile la versione {version}`
  String updateAvailableTitle(Object version) {
    return Intl.message(
      'È disponibile la versione $version',
      name: 'updateAvailableTitle',
      desc: '',
      args: [version],
    );
  }

  /// `Scaricala dalla pagina della release su GitHub.`
  String get updateAvailableBody {
    return Intl.message(
      'Scaricala dalla pagina della release su GitHub.',
      name: 'updateAvailableBody',
      desc: '',
      args: [],
    );
  }

  /// `Scarica`
  String get updateDownload {
    return Intl.message('Scarica', name: 'updateDownload', desc: '', args: []);
  }

  /// `Più tardi`
  String get updateLater {
    return Intl.message('Più tardi', name: 'updateLater', desc: '', args: []);
  }

  /// `Impossibile verificare gli aggiornamenti.`
  String get updateCheckError {
    return Intl.message(
      'Impossibile verificare gli aggiornamenti.',
      name: 'updateCheckError',
      desc: '',
      args: [],
    );
  }

  /// `Statistiche`
  String get consoleStats {
    return Intl.message(
      'Statistiche',
      name: 'consoleStats',
      desc: '',
      args: [],
    );
  }

  /// `Verificati questo mese`
  String get statsIssuedThisMonth {
    return Intl.message(
      'Verificati questo mese',
      name: 'statsIssuedThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Tra colleghi questo mese`
  String get statsPeerThisMonth {
    return Intl.message(
      'Tra colleghi questo mese',
      name: 'statsPeerThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Persone che riconoscono`
  String get statsActiveSenders {
    return Intl.message(
      'Persone che riconoscono',
      name: 'statsActiveSenders',
      desc: '',
      args: [],
    );
  }

  /// `Riconosciuti negli ultimi 30 giorni`
  String get statsCoverage {
    return Intl.message(
      'Riconosciuti negli ultimi 30 giorni',
      name: 'statsCoverage',
      desc: '',
      args: [],
    );
  }

  /// `{percent}%`
  String percentValue(int percent) {
    return Intl.message(
      '$percent%',
      name: 'percentValue',
      desc: '',
      args: [percent],
    );
  }

  /// `Traguardi negli ultimi 6 mesi`
  String get statsMonthlyChart {
    return Intl.message(
      'Traguardi negli ultimi 6 mesi',
      name: 'statsMonthlyChart',
      desc: '',
      args: [],
    );
  }

  /// `Tra colleghi`
  String get legendPeer {
    return Intl.message('Tra colleghi', name: 'legendPeer', desc: '', args: []);
  }

  /// `Da riconoscere`
  String get statsUnderRecognized {
    return Intl.message(
      'Da riconoscere',
      name: 'statsUnderRecognized',
      desc: '',
      args: [],
    );
  }

  /// `Chi ha ricevuto meno traguardi negli ultimi 90 giorni.`
  String get statsUnderRecognizedHint {
    return Intl.message(
      'Chi ha ricevuto meno traguardi negli ultimi 90 giorni.',
      name: 'statsUnderRecognizedHint',
      desc: '',
      args: [],
    );
  }

  /// `Chi riconosce di più`
  String get statsTopSenders {
    return Intl.message(
      'Chi riconosce di più',
      name: 'statsTopSenders',
      desc: '',
      args: [],
    );
  }

  /// `Traguardi base inviati negli ultimi 90 giorni.`
  String get statsTopSendersHint {
    return Intl.message(
      'Traguardi base inviati negli ultimi 90 giorni.',
      name: 'statsTopSendersHint',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 inviato} other{{count} inviati}}`
  String sentCount(int count) {
    return Intl.plural(
      count,
      one: '1 inviato',
      other: '$count inviati',
      name: 'sentCount',
      desc: '',
      args: [count],
    );
  }

  /// `Più assegnati`
  String get statsTopCatalog {
    return Intl.message(
      'Più assegnati',
      name: 'statsTopCatalog',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one{1 volta} other{{count} volte}}`
  String issuedTimes(int count) {
    return Intl.plural(
      count,
      one: '1 volta',
      other: '$count volte',
      name: 'issuedTimes',
      desc: '',
      args: [count],
    );
  }

  /// `Nessun dato, per ora.`
  String get statsNoData {
    return Intl.message(
      'Nessun dato, per ora.',
      name: 'statsNoData',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
