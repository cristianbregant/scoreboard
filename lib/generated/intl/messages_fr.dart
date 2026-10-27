// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 succès', other: '${count} succès')}";

  static String m1(count, subject) =>
      "${Intl.plural(count, one: 'a décerné « ${subject} » à 1 personne', other: 'a décerné « ${subject} » à ${count} personnes')}";

  static String m2(subject) => "a nommé ${subject} administrateur";

  static String m3(subject) =>
      "a retiré les droits d’administrateur à ${subject}";

  static String m4(subject) => "a archivé « ${subject} »";

  static String m5(subject) => "a ajouté « ${subject} » au catalogue";

  static String m6(subject) => "a restauré « ${subject} »";

  static String m7(subject) => "a modifié « ${subject} »";

  static String m8(subject) => "a révoqué l’invitation de ${subject}";

  static String m9(subject) => "a invité ${subject}";

  static String m10(subject, target) => "a déplacé ${subject} vers ${target}";

  static String m11(subject) => "a retiré ${subject} de son équipe";

  static String m12(subject, target) =>
      "a proposé « ${subject} » pour ${target}";

  static String m13(target) =>
      "a exporté les données personnelles de ${target}";

  static String m14(target) => "a exporté le rapport des succès (${target})";

  static String m15(target) => "a exporté le rapport par personne (${target})";

  static String m16(subject, target) =>
      "a approuvé « ${subject} » pour ${target}";

  static String m17(subject, target) =>
      "a refusé « ${subject} » pour ${target}";

  static String m18(subject) => "a créé la saison ${subject}";

  static String m19(subject) => "a supprimé la saison ${subject}";

  static String m20(subject) => "a modifié la saison ${subject}";

  static String m21(subject) => "a créé l’équipe ${subject}";

  static String m22(subject) => "a supprimé l’équipe ${subject}";

  static String m23(subject) => "a modifié l’équipe ${subject}";

  static String m24(company) => "Admin · ${company}";

  static String m25(name) => "${name} est maintenant administrateur";

  static String m26(name) => "${name} n’est plus administrateur";

  static String m27(points) => "${points} XP";

  static String m28(years) =>
      "${Intl.plural(years, one: '1 an', other: '${years} ans')}";

  static String m29(count) =>
      "${Intl.plural(count, zero: 'Décerner', one: 'Décerner à 1 personne', other: 'Décerner à ${count} personnes')}";

  static String m30(maxPoints) =>
      "Les succès de base s’envoient entre collègues et valent jusqu’à ${maxPoints} XP. Les succès vérifiés sont décernés uniquement par votre entreprise. Vous pouvez envoyer chaque succès de base une seule fois à un même collègue.";

  static String m31(company) =>
      "Votre couleur et votre logo remplacent l’or de Scoreboard pour tout ${company}. La couleur est ajustée pour que les textes restent lisibles.";

  static String m32(remaining, budget) =>
      "Encore ${remaining} envois sur ${budget} ce mois-ci";

  static String m33(name) => "De ${name}";

  static String m34(date) => "Décerné le ${date}";

  static String m35(date) => "Reçu le ${date}";

  static String m36(id) => "ID de l’attestation : ${id}";

  static String m37(company, date) => "Décerné par ${company} le ${date}";

  static String m38(count) =>
      "${Intl.plural(count, zero: 'Commenter', one: '1 commentaire', other: '${count} commentaires')}";

  static String m39(year) => "Depuis ${year}";

  static String m40(company) =>
      "Les succès vérifiés que ${company} peut décerner. Cliquez sur une carte pour la modifier.";

  static String m41(company) =>
      "L\'image de ${company} dans Scoreboard, et ce qu\'elle célèbre";

  static String m42(company) =>
      "Comment circule la reconnaissance chez ${company}, et où elle bloque.";

  static String m43(count) => "Demandes · ${count}";

  static String m44(name) => "Par ${name}";

  static String m45(name) => "Supprimer ${name} ?";

  static String m46(name) => "Supprimer ${name} ?";

  static String m47(name) => "Supprimer « ${name} » ?";

  static String m48(email, password) =>
      "Compte de démonstration : ${email} / ${password}";

  static String m49(id) => "ID ${id}";

  static String m50(template, colleague) =>
      "Vous avez déjà envoyé « ${template} » à ${colleague}.";

  static String m51(budget) =>
      "Vous avez envoyé les ${budget} succès de ce mois. Le quota se renouvelle le 1er.";

  static String m52(min, max) =>
      "La valeur doit être comprise entre ${min} et ${max} XP.";

  static String m53(values) =>
      "Les succès de base peuvent valoir ${values} XP.";

  static String m54(min) =>
      "Le mot de passe doit contenir au moins ${min} caractères.";

  static String m55(count) => "Tous · ${count}";

  static String m56(tier, count) => "${tier} · ${count}";

  static String m57(code) => "Code ${code}";

  static String m58(name, date) => "Invité par ${name} · expire le ${date}";

  static String m59(company) =>
      "Cette personne recevra par e-mail un code pour rejoindre ${company}. Le code est valable 7 jours.";

  static String m60(email) => "Révoquer l’invitation de ${email} ?";

  static String m61(email) => "Invitation envoyée à ${email}";

  static String m62(email, code) =>
      "Mode démo, aucun e-mail envoyé : donnez à ${email} le code ${code}";

  static String m63(count) =>
      "${Intl.plural(count, one: 'Décerné à 1 personne', other: 'Décerné à ${count} personnes')}";

  static String m64(count) =>
      "${Intl.plural(count, one: 'une fois', other: '${count} fois')}";

  static String m65(level, points) => "Niveau ${level} · ${points} XP";

  static String m66(level) => "Niveau ${level}";

  static String m67(count) => "Bibliothèque · ${count}";

  static String m68(date) => "Membre depuis le ${date}";

  static String m69(name) => "Équipe de ${name}";

  static String m70(count) =>
      "${Intl.plural(count, one: '1 membre', other: '${count} membres')}";

  static String m71(name) =>
      "Pour ${name}. Un administrateur examinera votre proposition.";

  static String m72(achievement) =>
      "« ${achievement} » a été approuvé et figure maintenant dans vos succès";

  static String m73(actor, achievement, text) =>
      "${actor} a commenté « ${achievement} » : ${text}";

  static String m74(level) => "Vous avez atteint le niveau ${level}";

  static String m75(actor, achievement) =>
      "${actor} a demandé « ${achievement} »";

  static String m76(actor, achievement, member) =>
      "${actor} propose « ${achievement} » pour ${member}";

  static String m77(actor, achievement) =>
      "${actor} vous a envoyé « ${achievement} »";

  static String m78(actor, achievement) =>
      "${actor} a réagi à « ${achievement} »";

  static String m79(xp, rank) =>
      "Cette semaine : +${xp} XP · classement #${rank}";

  static String m80(achievement) => "« ${achievement} » n’a pas été approuvé";

  static String m81(achievement, reason) =>
      "« ${achievement} » n’a pas été approuvé : ${reason}";

  static String m82(company, achievement) =>
      "${company} vous a décerné « ${achievement} »";

  static String m83(count) =>
      "${Intl.plural(count, zero: 'Aucune notification non lue', one: '1 notification non lue', other: '${count} notifications non lues')}";

  static String m84(shortcut) =>
      "Appuyez sur ${shortcut} pour envoyer un succès depuis n’importe où, ou utilisez l’icône de la barre des menus.";

  static String m85(budget) =>
      "Les succès vérifiés viennent de votre entreprise : vous pouvez les demander depuis le catalogue. Les succès de base s’échangent entre collègues, jusqu’à ${budget} par mois.";

  static String m86(min) => "Au moins ${min} caractères";

  static String m87(percent) => "${percent} %";

  static String m88(rank) => "#${rank}";

  static String m89(reason) => "Motif : ${reason}";

  static String m90(company) =>
      "Un administrateur de ${company} examinera votre demande.";

  static String m91(name) => "Proposé par ${name}";

  static String m92(role, company) => "${role} chez ${company}";

  static String m93(days) =>
      "${Intl.plural(days, one: 'Encore 1 jour', other: 'Encore ${days} jours')}";

  static String m94(start, end) => "${start} – ${end}";

  static String m95(rank, points) => "Vous êtes #${rank} avec ${points} XP";

  static String m96(name) => "Succès envoyé à ${name}";

  static String m97(count) => "Envoyés par vous · ${count}";

  static String m98(count) => "${count} envoyés";

  static String m99(company) =>
      "L’ajoute à Licences et certifications, avec ${company} comme organisme émetteur.";

  static String m100(company) => "Décerné par ${company}";

  static String m101(sender, name, description) =>
      "🤝 ${sender} a salué mon travail avec le succès « ${name} ».\n\n${description}\n\n#Scoreboard";

  static String m102(name, company, description) =>
      "🏆 Je viens d’obtenir le succès « ${name} », décerné par ${company}.\n\n${description}\n\n#Scoreboard";

  static String m103(time) => "Dernière reconnaissance : ${time}";

  static String m104(received, sent) =>
      "${received} reçus · ${sent} envoyés en 90 jours";

  static String m105(name) => "« ${name} » ajouté à la bibliothèque";

  static String m106(name) => "« ${name} » supprimé";

  static String m107(count) =>
      "${Intl.plural(count, one: 'Hier', other: 'il y a ${count} jours')}";

  static String m108(count) => "il y a ${count} h";

  static String m109(count) => "il y a ${count} min";

  static String m110(version) => "La version ${version} est disponible";

  static String m111(count) => "${count} vérifiés";

  static String m112(version) => "Version ${version}";

  static String m113(points, level) => "${points} XP avant le niveau ${level}";

  static String m114(points) => "${points} XP";

  static String m115(name) => "${name} (vous)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountSubtitle": MessageLookupByLibrary.simpleMessage(
          "Identifiants de connexion. Votre nom, votre photo et votre couverture sont dans Profil.",
        ),
        "achievementDetailTitle":
            MessageLookupByLibrary.simpleMessage("Succès"),
        "achievementNamePlaceholder": MessageLookupByLibrary.simpleMessage(
          "Nom du succès",
        ),
        "achievementsCount": m0,
        "achievementsEmptyBody": MessageLookupByLibrary.simpleMessage(
          "Demandez un succès vérifié dans le catalogue de votre entreprise, ou saluez le travail d’un collègue : c’est souvent la meilleure façon de commencer.",
        ),
        "achievementsEmptyTitle": MessageLookupByLibrary.simpleMessage(
          "Votre premier succès vous attend",
        ),
        "achievementsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Tout votre travail, noir sur blanc",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage("Vos succès"),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "Cela n’a pas fonctionné. Réessayez.",
        ),
        "activityAchievementsIssued": m1,
        "activityAdminGranted": m2,
        "activityAdminRevoked": m3,
        "activityAnniversariesUpdated": MessageLookupByLibrary.simpleMessage(
          "a modifié les anniversaires d’ancienneté",
        ),
        "activityBrandUpdated": MessageLookupByLibrary.simpleMessage(
          "a changé la couleur ou le logo de l’entreprise",
        ),
        "activityCatalogArchived": m4,
        "activityCatalogCreated": m5,
        "activityCatalogRestored": m6,
        "activityCatalogUpdated": m7,
        "activityEmpty": MessageLookupByLibrary.simpleMessage(
          "Aucune activité enregistrée pour l’instant.",
        ),
        "activityHint": MessageLookupByLibrary.simpleMessage(
          "Ce qu’ont fait les administrateurs et les responsables, du plus récent au plus ancien. Il ne peut pas être modifié.",
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
        "adminGroupCompany": MessageLookupByLibrary.simpleMessage("ENTREPRISE"),
        "adminGroupData": MessageLookupByLibrary.simpleMessage("DONNÉES"),
        "adminGroupPeople": MessageLookupByLibrary.simpleMessage("PERSONNES"),
        "adminGroupRecognition": MessageLookupByLibrary.simpleMessage(
          "RECONNAISSANCE",
        ),
        "adminMode":
            MessageLookupByLibrary.simpleMessage("Mode administrateur"),
        "adminModeHint": MessageLookupByLibrary.simpleMessage(
          "Gérez les succès vérifiés de votre entreprise",
        ),
        "adminRevokeSelfAction":
            MessageLookupByLibrary.simpleMessage("Renoncer"),
        "adminRevokeSelfBody": MessageLookupByLibrary.simpleMessage(
          "Vous quitterez la console et ne pourrez plus gérer l’entreprise. Un autre administrateur pourra vous rendre ces droits.",
        ),
        "adminRevokeSelfTitle": MessageLookupByLibrary.simpleMessage(
          "Renoncer à vos droits d’administrateur ?",
        ),
        "adminRevokedMessage": m26,
        "adminRole": MessageLookupByLibrary.simpleMessage("Administrateur"),
        "adminRoleTooltip": MessageLookupByLibrary.simpleMessage(
          "Peut utiliser la console et gérer l’entreprise",
        ),
        "alreadyHasIt": MessageLookupByLibrary.simpleMessage("L’a déjà"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Déjà envoyé à ce collègue",
        ),
        "anniversariesBody": MessageLookupByLibrary.simpleMessage(
          "Un succès vérifié à chaque anniversaire d’ancienneté que vous célébrez, décerné automatiquement.",
        ),
        "anniversariesEnabled": MessageLookupByLibrary.simpleMessage(
          "Célébrer les anniversaires d’ancienneté",
        ),
        "anniversariesTitle": MessageLookupByLibrary.simpleMessage(
          "Anniversaires d’ancienneté",
        ),
        "anniversaryXp": m27,
        "anniversaryYears": m28,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Choisissez l’apparence de Scoreboard",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Approuver"),
        "archive": MessageLookupByLibrary.simpleMessage("Archiver"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archivé"),
        "assignButton": m29,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "Un message pour les destinataires",
        ),
        "assignNoteLabel": MessageLookupByLibrary.simpleMessage(
          "Note (facultative)",
        ),
        "authCreateCompanySubtitle": MessageLookupByLibrary.simpleMessage(
          "Configurez Scoreboard pour votre entreprise. Vous en serez l’administrateur.",
        ),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Rejoignez le tableau des scores de votre entreprise.",
        ),
        "authCreateTitle": MessageLookupByLibrary.simpleMessage(
          "Créez votre compte",
        ),
        "authJoinSubtitle": MessageLookupByLibrary.simpleMessage(
          "Utilisez le code d’invitation reçu par e-mail.",
        ),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Rassemblez les succès décernés par votre entreprise et saluez les collègues qui font la différence.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Vos trophées s\'ennuyaient de vous.",
        ),
        "authTagline": MessageLookupByLibrary.simpleMessage(
          "Chaque réussite,\nbien notée.",
        ),
        "authWelcomeBack": MessageLookupByLibrary.simpleMessage("Bon retour"),
        "bannerClay": MessageLookupByLibrary.simpleMessage("Argile"),
        "bannerForest": MessageLookupByLibrary.simpleMessage("Forêt"),
        "bannerGold": MessageLookupByLibrary.simpleMessage("Or"),
        "bannerGraphite": MessageLookupByLibrary.simpleMessage("Graphite"),
        "bannerOcean": MessageLookupByLibrary.simpleMessage("Océan"),
        "bannerSand": MessageLookupByLibrary.simpleMessage("Sable"),
        "baseExplanation": m30,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "De petits mercis, XP compris",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Une phrase sur vous et ce que vous faites",
        ),
        "brandBody": m31,
        "brandColor": MessageLookupByLibrary.simpleMessage("Couleur"),
        "brandDefault":
            MessageLookupByLibrary.simpleMessage("Or de Scoreboard"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Aperçu"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Marque"),
        "budgetRemaining": m32,
        "cardBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Succès de base",
        ),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Retourner la carte"),
        "cardFrom": m33,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("DÉCERNÉ PAR"),
        "cardIssuedOn": m34,
        "cardReceivedOn": m35,
        "cardSentBy": MessageLookupByLibrary.simpleMessage("ENVOYÉ PAR"),
        "cardVerifiedAchievement": MessageLookupByLibrary.simpleMessage(
          "Succès vérifié",
        ),
        "catalogDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Seuls les administrateurs peuvent le décerner, et il apparaît comme vérifié pour ceux qui le reçoivent.",
        ),
        "catalogEmpty": MessageLookupByLibrary.simpleMessage(
          "Le catalogue est vide. Créez le premier succès.",
        ),
        "catalogPointsHint": MessageLookupByLibrary.simpleMessage(
          "La valeur fixe le rang : Bronze en dessous de 100 XP, Argent à partir de 100, Or à partir de 120, Platine à partir de 140.",
        ),
        "catalogSaved": MessageLookupByLibrary.simpleMessage(
          "Catalogue mis à jour",
        ),
        "certCredentialId": m36,
        "certHasEarned":
            MessageLookupByLibrary.simpleMessage("a obtenu le succès"),
        "certIssuedBy": m37,
        "certPresentedTo": MessageLookupByLibrary.simpleMessage(
          "Nous certifions que",
        ),
        "certTitle":
            MessageLookupByLibrary.simpleMessage("CERTIFICAT DE RÉUSSITE"),
        "changePassword": MessageLookupByLibrary.simpleMessage(
          "Changer le mot de passe",
        ),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Rechercher des mises à jour",
        ),
        "commentHint": MessageLookupByLibrary.simpleMessage(
          "Écrivez un commentaire…",
        ),
        "commentsCount": m38,
        "commonBack": MessageLookupByLibrary.simpleMessage("Retour"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Annuler"),
        "commonClose": MessageLookupByLibrary.simpleMessage("Fermer"),
        "commonCreate": MessageLookupByLibrary.simpleMessage("Créer"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Supprimer"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Modifier"),
        "commonPreview": MessageLookupByLibrary.simpleMessage("APERÇU"),
        "commonRemove": MessageLookupByLibrary.simpleMessage("Retirer"),
        "commonRetry": MessageLookupByLibrary.simpleMessage("Réessayer"),
        "commonSave": MessageLookupByLibrary.simpleMessage("Enregistrer"),
        "commonSend": MessageLookupByLibrary.simpleMessage("Envoyer"),
        "communityCompanies":
            MessageLookupByLibrary.simpleMessage("Entreprises"),
        "communityHiddenNotice": MessageLookupByLibrary.simpleMessage(
          "Vous n’apparaissez pas dans ce classement. Vous pouvez changer cela dans Réglages → Compte.",
        ),
        "communityPeople": MessageLookupByLibrary.simpleMessage("Personnes"),
        "communitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Tout le monde, partout, classé. Aucune pression.",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Communauté"),
        "companyCatalog": MessageLookupByLibrary.simpleMessage(
          "Catalogue de l’entreprise",
        ),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "Les succès vérifiés que vous pouvez obtenir. Si vous pensez en mériter un, demandez-le.",
        ),
        "companyIndustryLabel": MessageLookupByLibrary.simpleMessage(
          "Secteur (facultatif)",
        ),
        "companyLocationLabel": MessageLookupByLibrary.simpleMessage(
          "Ville (facultatif)",
        ),
        "companyNameLabel": MessageLookupByLibrary.simpleMessage(
          "Nom de l’entreprise",
        ),
        "companyNameRequired": MessageLookupByLibrary.simpleMessage(
          "Saisissez le nom de l’entreprise",
        ),
        "companySince": m39,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirmation"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Confirmez le nouveau mot de passe",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage(
          "Journal d’activité",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Décerner"),
        "consoleAssignSubtitle": MessageLookupByLibrary.simpleMessage(
          "Choisissez un succès, choisissez les personnes, illuminez leur journée.",
        ),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catalogue"),
        "consoleCatalogSubtitle": m40,
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Entreprise"),
        "consoleCompanySubtitle": m41,
        "consoleInsightsSubtitle": m42,
        "consoleMembers": MessageLookupByLibrary.simpleMessage("Membres"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Rapports"),
        "consoleRequests": m43,
        "consoleRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Des personnes qui demandent une reconnaissance qu\'elles pensent mériter. À vous de décider.",
        ),
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Saisons"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Statistiques"),
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Équipes"),
        "createAccount":
            MessageLookupByLibrary.simpleMessage("Créer un compte"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Tout le monde dans votre entreprise peut l’envoyer à un collègue.",
        ),
        "createdBy": m44,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Créé par vous"),
        "currentPassword": MessageLookupByLibrary.simpleMessage(
          "Mot de passe actuel",
        ),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Saisissez votre mot de passe actuel",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Traitées"),
        "deleteSeasonBody": MessageLookupByLibrary.simpleMessage(
          "Son classement disparaît. Les succès sont conservés.",
        ),
        "deleteSeasonTitle": m45,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "Ses membres n’auront plus d’équipe. Leurs succès sont conservés.",
        ),
        "deleteTeamTitle": m46,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Il sera retiré de la bibliothèque. Les collègues qui l’ont déjà reçu conservent leur succès.",
        ),
        "deleteTemplateTitle": m47,
        "demoAccount": m48,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "Que faut-il faire pour le mériter ?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Ajoutez une courte description",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Entreprise"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Obtenu le"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Expérience"),
        "detailId": m49,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Envoyé par"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Rang"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Obtenu"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Modifier le succès",
        ),
        "editProfile":
            MessageLookupByLibrary.simpleMessage("Modifier le profil"),
        "editSeason":
            MessageLookupByLibrary.simpleMessage("Modifier la saison"),
        "editTeam": MessageLookupByLibrary.simpleMessage("Modifier l’équipe"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossible d’enregistrer votre e-mail. Réessayez.",
        ),
        "emailUpdated":
            MessageLookupByLibrary.simpleMessage("E-mail mis à jour"),
        "emptyOpenCatalog": MessageLookupByLibrary.simpleMessage(
          "Ouvrir le catalogue",
        ),
        "errorAlreadyMember": MessageLookupByLibrary.simpleMessage(
          "Cette personne a déjà un compte Scoreboard.",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "Vous avez déjà ce succès.",
        ),
        "errorAlreadySent": m50,
        "errorBudgetExhausted": m51,
        "errorCatalogPoints": m52,
        "errorCompanyNameTaken": MessageLookupByLibrary.simpleMessage(
          "Une entreprise portant ce nom est déjà sur Scoreboard. Demandez à l’un de ses administrateurs de vous inviter.",
        ),
        "errorEmailNotSent": MessageLookupByLibrary.simpleMessage(
          "L’e-mail d’invitation n’a pas pu être envoyé. Réessayez plus tard.",
        ),
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "Un compte existe déjà avec cet e-mail.",
        ),
        "errorInvalidDates": MessageLookupByLibrary.simpleMessage(
          "La date de fin ne peut pas précéder la date de début.",
        ),
        "errorInvalidInviteCode": MessageLookupByLibrary.simpleMessage(
          "Ce code n’est pas valable pour cette adresse e-mail ou il a expiré. Demandez une nouvelle invitation à un administrateur.",
        ),
        "errorInvalidPoints": m53,
        "errorLastAdmin": MessageLookupByLibrary.simpleMessage(
          "L’entreprise doit avoir au moins un administrateur.",
        ),
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Saisissez votre e-mail et votre mot de passe.",
        ),
        "errorMissingFields": MessageLookupByLibrary.simpleMessage(
          "Remplissez tous les champs obligatoires.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Saisissez votre nom et votre poste.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "Vous ne pouvez envoyer des succès qu’aux collègues de votre entreprise.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Seuls les administrateurs de l’entreprise peuvent le faire.",
        ),
        "errorNotFound": MessageLookupByLibrary.simpleMessage("Introuvable."),
        "errorNotInTeam": MessageLookupByLibrary.simpleMessage(
          "Cette personne ne fait pas partie de votre équipe.",
        ),
        "errorNotManager": MessageLookupByLibrary.simpleMessage(
          "Seuls les responsables d’équipe peuvent le faire.",
        ),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "Vous n’êtes pas connecté.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "Vous ne pouvez supprimer que les succès de base que vous avez créés.",
        ),
        "errorPasswordTooShort": m54,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Vous avez déjà une demande en attente pour ce succès.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "Ces dates chevauchent une autre saison.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "Ce succès de base n’existe plus.",
        ),
        "errorWrongCredentials": MessageLookupByLibrary.simpleMessage(
          "E-mail ou mot de passe incorrect.",
        ),
        "errorWrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
          "Le mot de passe actuel est incorrect.",
        ),
        "evidenceLink":
            MessageLookupByLibrary.simpleMessage("Ouvrir la preuve"),
        "evidenceUrlLabel": MessageLookupByLibrary.simpleMessage(
          "Lien vers une preuve (facultatif)",
        ),
        "experienceNote": MessageLookupByLibrary.simpleMessage(
          "Les succès de base valent moins que les succès vérifiés décernés par votre entreprise.",
        ),
        "exportCsv": MessageLookupByLibrary.simpleMessage("Exporter en CSV"),
        "exportError": MessageLookupByLibrary.simpleMessage(
          "Impossible d’enregistrer le fichier. Réessayez.",
        ),
        "exportJson": MessageLookupByLibrary.simpleMessage("Exporter en JSON"),
        "exportMenu": MessageLookupByLibrary.simpleMessage("Exporter"),
        "exportOpenBadge": MessageLookupByLibrary.simpleMessage(
          "Open Badge (JSON)",
        ),
        "exportOpenBadgeHint": MessageLookupByLibrary.simpleMessage(
          "Attestation Open Badges 3.0. La signature numérique arrivera avec le backend.",
        ),
        "exportPdf": MessageLookupByLibrary.simpleMessage("Certificat PDF"),
        "exportSaved":
            MessageLookupByLibrary.simpleMessage("Fichier enregistré"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("a obtenu"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Tout est calme. Le prochain succès reçu brisera le silence.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "Les réussites de vos collègues, en direct. Applaudissements bienvenus.",
        ),
        "feedTitle":
            MessageLookupByLibrary.simpleMessage("Fil de l’entreprise"),
        "fieldAchievement": MessageLookupByLibrary.simpleMessage("Succès"),
        "fieldBio": MessageLookupByLibrary.simpleMessage("Bio"),
        "fieldColleague": MessageLookupByLibrary.simpleMessage("Collègue"),
        "fieldCover": MessageLookupByLibrary.simpleMessage("Couverture"),
        "fieldDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "fieldEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "fieldExperience": MessageLookupByLibrary.simpleMessage("Expérience"),
        "fieldFullName": MessageLookupByLibrary.simpleMessage("Nom complet"),
        "fieldIcon": MessageLookupByLibrary.simpleMessage("Icône"),
        "fieldMessageOptional": MessageLookupByLibrary.simpleMessage(
          "Message (facultatif)",
        ),
        "fieldName": MessageLookupByLibrary.simpleMessage("Nom"),
        "fieldPhoto": MessageLookupByLibrary.simpleMessage("Photo"),
        "fieldRole": MessageLookupByLibrary.simpleMessage("Poste"),
        "filterAll": m55,
        "filterTier": m56,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Cliquez sur la carte pour la retourner",
        ),
        "fromAColleague": MessageLookupByLibrary.simpleMessage("D’un collègue"),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Un problème est survenu. Réessayez.",
        ),
        "hapticsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Maintenez une carte enfoncée pour la retourner, et sentez-la s’enclencher sur le trackpad Force Touch.",
        ),
        "hapticsTitle": MessageLookupByLibrary.simpleMessage("Retour haptique"),
        "hidePassword": MessageLookupByLibrary.simpleMessage(
          "Masquer le mot de passe",
        ),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Saisissez une adresse e-mail valide",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Saisissez un lien http(s) valide",
        ),
        "inviteCodeChip": m57,
        "inviteCodeLabel": MessageLookupByLibrary.simpleMessage(
          "Code d’invitation",
        ),
        "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
          "Saisissez le code reçu",
        ),
        "inviteDetails": m58,
        "inviteDialogBody": m59,
        "inviteDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Inviter un collègue",
        ),
        "inviteEmailHint": MessageLookupByLibrary.simpleMessage(
          "L’adresse e-mail qui a reçu l’invitation",
        ),
        "inviteExpired": MessageLookupByLibrary.simpleMessage("Expirée"),
        "inviteMember": MessageLookupByLibrary.simpleMessage("Inviter"),
        "inviteResend": MessageLookupByLibrary.simpleMessage("Renvoyer"),
        "inviteRevoke": MessageLookupByLibrary.simpleMessage("Révoquer"),
        "inviteRevokeBody": MessageLookupByLibrary.simpleMessage(
          "Le code ne fonctionnera plus. Vous pourrez réinviter cette personne plus tard.",
        ),
        "inviteRevokeTitle": m60,
        "inviteRevoked": MessageLookupByLibrary.simpleMessage(
          "Invitation révoquée",
        ),
        "inviteSend":
            MessageLookupByLibrary.simpleMessage("Envoyer l’invitation"),
        "inviteSent": m61,
        "inviteSentDemo": m62,
        "invitesEmpty": MessageLookupByLibrary.simpleMessage(
          "Aucune invitation en attente.",
        ),
        "issuedCount": m63,
        "issuedTimes": m64,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Vérifié"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("Système"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Langue"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Classement"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Entre collègues"),
        "levelAndXp": m65,
        "levelN": m66,
        "libraryCount": m67,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "La bibliothèque est vide. Il faut bien que quelqu\'un commence : pourquoi pas vous ?",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Un problème est survenu lors du chargement des données.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Tout marquer comme lu",
        ),
        "memberSince": m68,
        "memberTeamLabel": m69,
        "membersCount": m70,
        "membersHint": MessageLookupByLibrary.simpleMessage(
          "Invitez des personnes dans l’entreprise et choisissez qui peut la gérer.",
        ),
        "membersWithoutTeam":
            MessageLookupByLibrary.simpleMessage("Sans équipe"),
        "messageHint": MessageLookupByLibrary.simpleMessage(
          "Dites-lui pourquoi il le mérite",
        ),
        "myRequests": MessageLookupByLibrary.simpleMessage("Vos demandes"),
        "nameHint":
            MessageLookupByLibrary.simpleMessage("p. ex. Esprit d’équipe"),
        "nameRequired":
            MessageLookupByLibrary.simpleMessage("Saisissez votre nom"),
        "navAchievements": MessageLookupByLibrary.simpleMessage("Succès"),
        "navBaseAchievements": MessageLookupByLibrary.simpleMessage(
          "Succès de base",
        ),
        "navCommunity": MessageLookupByLibrary.simpleMessage("Communauté"),
        "navConsole": MessageLookupByLibrary.simpleMessage(
          "Console de l’entreprise",
        ),
        "navFeed": MessageLookupByLibrary.simpleMessage("Fil"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
        "navRequests": MessageLookupByLibrary.simpleMessage("Demandes"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Réglages"),
        "navTeam": MessageLookupByLibrary.simpleMessage("Mon équipe"),
        "navYourCompany":
            MessageLookupByLibrary.simpleMessage("Votre entreprise"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Nouveau succès de base",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Nouveau succès vérifié",
        ),
        "newPassword":
            MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
        "newSeason": MessageLookupByLibrary.simpleMessage("Nouvelle saison"),
        "newTeam": MessageLookupByLibrary.simpleMessage("Nouvelle équipe"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "Rien dans cette catégorie pour l\'instant. Ça viendra.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Aucun succès pour l’instant.",
        ),
        "noManager": MessageLookupByLibrary.simpleMessage("Aucun responsable"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Aucun résultat. Essayez avec moins de lettres, ou une autre intuition.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("Aucune équipe"),
        "nominateDialogSubtitle": m71,
        "nominateDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Proposer un succès vérifié",
        ),
        "nominateMessageHint": MessageLookupByLibrary.simpleMessage(
          "Pourquoi le mérite-t-il ?",
        ),
        "nominateSent": MessageLookupByLibrary.simpleMessage(
          "Proposition envoyée aux administrateurs",
        ),
        "noteAuthorFallback":
            MessageLookupByLibrary.simpleMessage("Un collègue"),
        "notifApprovedBody": m72,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Demande approuvée",
        ),
        "notifCommentBody": m73,
        "notifCommentTitle": MessageLookupByLibrary.simpleMessage(
          "Nouveau commentaire",
        ),
        "notifLevelUpBody": m74,
        "notifLevelUpTitle": MessageLookupByLibrary.simpleMessage(
          "Niveau supérieur !",
        ),
        "notifNewRequestBody": m75,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Nouvelle demande",
        ),
        "notifNominationBody": m76,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "Nouvelle proposition",
        ),
        "notifPeerBody": m77,
        "notifPeerTitle":
            MessageLookupByLibrary.simpleMessage("Nouveau succès"),
        "notifReactionBody": m78,
        "notifReactionTitle": MessageLookupByLibrary.simpleMessage(
          "Nouvelle réaction",
        ),
        "notifRecapBody": m79,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Votre bilan de la semaine",
        ),
        "notifRejectedBody": m80,
        "notifRejectedBodyReason": m81,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Demande refusée",
        ),
        "notifVerifiedBody": m82,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Succès vérifié",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "Vous êtes à jour. Rien ne vous attend pour l\'instant.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Ouvrir les notifications",
        ),
        "notificationsTitle":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "notificationsUnread": m83,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("C’est parti"),
        "onboardingFastBody": m84,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Allez vite"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "Le fil montre les succès de vos collègues pour que vous puissiez réagir et commenter. Les notifications vous préviennent quand quelque chose vous concerne.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Célébrez ensemble",
        ),
        "onboardingKindsBody": m85,
        "onboardingKindsTitle": MessageLookupByLibrary.simpleMessage(
          "Succès vérifiés et entre collègues",
        ),
        "onboardingNext": MessageLookupByLibrary.simpleMessage("Suivant"),
        "onboardingReplay": MessageLookupByLibrary.simpleMessage(
          "Revoir l’introduction",
        ),
        "onboardingSkip": MessageLookupByLibrary.simpleMessage("Passer"),
        "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
          "Vous rassemblez ici, sous forme de cartes, les succès obtenus au travail. Survolez-les et retournez-les pour voir qui les a décernés.",
        ),
        "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
          "Bienvenue dans Scoreboard",
        ),
        "passwordChangeError": MessageLookupByLibrary.simpleMessage(
          "Impossible de changer votre mot de passe. Réessayez.",
        ),
        "passwordChanged": MessageLookupByLibrary.simpleMessage(
          "Mot de passe modifié",
        ),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "passwordMinLength": m86,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Saisissez votre mot de passe",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Les mots de passe ne correspondent pas",
        ),
        "pendingInvites": MessageLookupByLibrary.simpleMessage(
          "Invitations en attente",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("En attente"),
        "percentValue": m87,
        "periodAll": MessageLookupByLibrary.simpleMessage("Depuis toujours"),
        "periodLast30":
            MessageLookupByLibrary.simpleMessage("30 derniers jours"),
        "periodQuarter": MessageLookupByLibrary.simpleMessage("Ce trimestre"),
        "periodYear": MessageLookupByLibrary.simpleMessage("Cette année"),
        "personalDataBody": MessageLookupByLibrary.simpleMessage(
          "Tout ce que Scoreboard conserve sur une personne, en JSON, pour les demandes liées à la protection des données.",
        ),
        "personalDataPerson": MessageLookupByLibrary.simpleMessage("Personne"),
        "personalDataTitle": MessageLookupByLibrary.simpleMessage(
          "Données personnelles",
        ),
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Choisissez un succès dans le catalogue.",
        ),
        "pickDates": MessageLookupByLibrary.simpleMessage("Choisir les dates"),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Vos collègues vous voient toujours dans le classement de l’équipe.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "M’afficher dans le classement de la Communauté",
        ),
        "privacySection":
            MessageLookupByLibrary.simpleMessage("Confidentialité"),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossible d’enregistrer votre profil. Réessayez.",
        ),
        "profileUpdated":
            MessageLookupByLibrary.simpleMessage("Profil mis à jour"),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Masqué"),
        "rankValue": m88,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Bravo"),
        "reactionInsightful":
            MessageLookupByLibrary.simpleMessage("Instructif"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("J’aime"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("J’adore"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Succès récents",
        ),
        "registerCreateCompany": MessageLookupByLibrary.simpleMessage(
          "Créer une entreprise",
        ),
        "registerJoin": MessageLookupByLibrary.simpleMessage(
          "Rejoindre une entreprise",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Refuser"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Refuser la demande ?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Motif (facultatif)",
        ),
        "rejectionReason": m89,
        "replaceImage":
            MessageLookupByLibrary.simpleMessage("Remplacer l’image"),
        "reportAchievementsBody": MessageLookupByLibrary.simpleMessage(
          "Une ligne par succès reçu : date, personne, équipe, type, XP et qui l’a donné.",
        ),
        "reportAchievementsTitle":
            MessageLookupByLibrary.simpleMessage("Succès"),
        "reportPeopleBody": MessageLookupByLibrary.simpleMessage(
          "Une ligne par personne : succès reçus et envoyés, XP et dernière reconnaissance.",
        ),
        "reportPeopleTitle": MessageLookupByLibrary.simpleMessage("Personnes"),
        "reportPeriod": MessageLookupByLibrary.simpleMessage("Période"),
        "reportSaved":
            MessageLookupByLibrary.simpleMessage("Rapport enregistré"),
        "reportsHint": MessageLookupByLibrary.simpleMessage(
          "Pour les évaluations et les outils RH. Chaque export est inscrit au journal d’activité.",
        ),
        "requestAction": MessageLookupByLibrary.simpleMessage("Demander"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Demande approuvée",
        ),
        "requestDialogSubtitle": m90,
        "requestDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Demander un succès",
        ),
        "requestMessage": MessageLookupByLibrary.simpleMessage("Message"),
        "requestMessageHint": MessageLookupByLibrary.simpleMessage(
          "Qu’avez-vous fait pour le mériter ?",
        ),
        "requestMessageRequired": MessageLookupByLibrary.simpleMessage(
          "Écrivez un message",
        ),
        "requestNominatedBy": m91,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Demande refusée",
        ),
        "requestSent": MessageLookupByLibrary.simpleMessage("Demande envoyée"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage(
          "Aucune demande. Soit tout va très bien, soit tout le monde est modeste.",
        ),
        "restore": MessageLookupByLibrary.simpleMessage("Restaurer"),
        "roleAtCompany": m92,
        "roleRequired": MessageLookupByLibrary.simpleMessage(
          "Saisissez votre poste",
        ),
        "saveProfile": MessageLookupByLibrary.simpleMessage(
          "Enregistrer le profil",
        ),
        "searchAchievementsHint": MessageLookupByLibrary.simpleMessage(
          "Rechercher dans vos succès",
        ),
        "searchCompaniesHint": MessageLookupByLibrary.simpleMessage(
          "Rechercher par nom ou secteur",
        ),
        "searchPeopleHint": MessageLookupByLibrary.simpleMessage(
          "Rechercher par nom, poste ou entreprise",
        ),
        "seasonActive": MessageLookupByLibrary.simpleMessage("En cours"),
        "seasonCurrent":
            MessageLookupByLibrary.simpleMessage("Saison en cours"),
        "seasonDates": MessageLookupByLibrary.simpleMessage("Dates"),
        "seasonDaysLeft": m93,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Saison supprimée",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Terminée"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Nom"),
        "seasonNameHint": MessageLookupByLibrary.simpleMessage(
          "p. ex. Automne 2026",
        ),
        "seasonRange": m94,
        "seasonSaved":
            MessageLookupByLibrary.simpleMessage("Saison enregistrée"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("À venir"),
        "seasonYourRank": m95,
        "seasonsEmpty": MessageLookupByLibrary.simpleMessage(
          "Aucune saison pour l’instant.",
        ),
        "seasonsHint": MessageLookupByLibrary.simpleMessage(
          "Chaque saison a son propre classement, qui compte les XP obtenus entre ses dates. Les saisons ne peuvent pas se chevaucher.",
        ),
        "selectAll": MessageLookupByLibrary.simpleMessage("Tout sélectionner"),
        "sendAchievement": MessageLookupByLibrary.simpleMessage(
          "Envoyer un succès",
        ),
        "sendAnAchievement": MessageLookupByLibrary.simpleMessage(
          "Envoyer un succès",
        ),
        "sendDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Saluez le travail d’un collègue avec l’un de vos succès de base.",
        ),
        "sendError": MessageLookupByLibrary.simpleMessage(
          "Impossible d’envoyer le succès. Réessayez.",
        ),
        "sendLoadError": MessageLookupByLibrary.simpleMessage(
          "Impossible de charger vos collègues. Réessayez.",
        ),
        "sendNoColleagues": MessageLookupByLibrary.simpleMessage(
          "Il n’y a pas encore d’autres collègues dans votre entreprise.",
        ),
        "sendNoTemplates": MessageLookupByLibrary.simpleMessage(
          "Créez d’abord un succès de base.",
        ),
        "sendPreviewHint": MessageLookupByLibrary.simpleMessage(
          "Choisissez un succès : sa carte apparaîtra ici, prête à partir.",
        ),
        "sendSuccess": m96,
        "sentByYouCount": m97,
        "sentCount": m98,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "Vous n’avez encore envoyé aucun succès. Choisissez-en un dans la bibliothèque et faites plaisir à un collègue.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("à"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Session"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("À propos"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Compte"),
        "settingsAppearance": MessageLookupByLibrary.simpleMessage("Apparence"),
        "settingsSavedMessage": MessageLookupByLibrary.simpleMessage(
          "Réglages enregistrés",
        ),
        "shareAddToProfile": MessageLookupByLibrary.simpleMessage(
          "Ajouter au profil",
        ),
        "shareAddToProfileHint": m99,
        "shareCopyText":
            MessageLookupByLibrary.simpleMessage("Copier le texte"),
        "shareDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Publiez-le, ou ajoutez-le à votre profil LinkedIn.",
        ),
        "shareImageHeadline": MessageLookupByLibrary.simpleMessage(
          "SUCCÈS DÉBLOQUÉ",
        ),
        "shareImageHint": MessageLookupByLibrary.simpleMessage(
          "Les liens LinkedIn ne peuvent pas joindre d’images : enregistrez celle-ci et ajoutez-la à votre publication.",
        ),
        "shareImageIssuedBy": m100,
        "shareImageSaved": MessageLookupByLibrary.simpleMessage(
          "Image enregistrée",
        ),
        "shareOnLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Partager sur LinkedIn",
        ),
        "shareOpenError": MessageLookupByLibrary.simpleMessage(
          "Impossible d’ouvrir LinkedIn.",
        ),
        "shareOpenLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Publier sur LinkedIn",
        ),
        "shareOpened": MessageLookupByLibrary.simpleMessage(
          "Texte copié : si LinkedIn ne le remplit pas, collez-le dans la publication.",
        ),
        "sharePostLabel": MessageLookupByLibrary.simpleMessage(
          "Texte de la publication",
        ),
        "sharePostPeer": m101,
        "sharePostVerified": m102,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "Impossible d’enregistrer l’image. Réessayez.",
        ),
        "shareSaveImage": MessageLookupByLibrary.simpleMessage(
          "Enregistrer l’image",
        ),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Texte copié dans le presse-papiers",
        ),
        "shortcutFlipCard": MessageLookupByLibrary.simpleMessage(
          "Retourner la carte sélectionnée",
        ),
        "shortcutGoToPage": MessageLookupByLibrary.simpleMessage(
          "Aller à la page 1–8",
        ),
        "shortcutsSection": MessageLookupByLibrary.simpleMessage(
          "Raccourcis clavier",
        ),
        "showArchived": MessageLookupByLibrary.simpleMessage(
          "Afficher les archives",
        ),
        "showPassword": MessageLookupByLibrary.simpleMessage(
          "Afficher le mot de passe",
        ),
        "signIn": MessageLookupByLibrary.simpleMessage("Se connecter"),
        "signOut": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
        "signOutDescription": MessageLookupByLibrary.simpleMessage(
          "Se déconnecter de Scoreboard sur cet ordinateur.",
        ),
        "signOutError": MessageLookupByLibrary.simpleMessage(
          "Impossible de se déconnecter. Réessayez.",
        ),
        "sortLabel": MessageLookupByLibrary.simpleMessage("Trier"),
        "sortName": MessageLookupByLibrary.simpleMessage("Nom (A–Z)"),
        "sortNewest": MessageLookupByLibrary.simpleMessage("Plus récents"),
        "sortOldest": MessageLookupByLibrary.simpleMessage("Plus anciens"),
        "sortPoints": MessageLookupByLibrary.simpleMessage("Plus d’XP"),
        "statAchievements": MessageLookupByLibrary.simpleMessage("Succès"),
        "statCompanyRank": MessageLookupByLibrary.simpleMessage(
          "Classement dans l’entreprise",
        ),
        "statGlobalRank": MessageLookupByLibrary.simpleMessage(
          "Classement général",
        ),
        "statMembers": MessageLookupByLibrary.simpleMessage("Membres"),
        "statTotalXp": MessageLookupByLibrary.simpleMessage("XP total"),
        "statVerified": MessageLookupByLibrary.simpleMessage("Vérifiés"),
        "statYourRank":
            MessageLookupByLibrary.simpleMessage("Votre classement"),
        "statsActiveSenders": MessageLookupByLibrary.simpleMessage(
          "Personnes qui saluent les autres",
        ),
        "statsCoverage": MessageLookupByLibrary.simpleMessage(
          "Reconnus ces 30 derniers jours",
        ),
        "statsIssuedThisMonth": MessageLookupByLibrary.simpleMessage(
          "Vérifiés ce mois-ci",
        ),
        "statsMonthlyChart": MessageLookupByLibrary.simpleMessage(
          "Succès des 6 derniers mois",
        ),
        "statsNoData": MessageLookupByLibrary.simpleMessage(
          "Aucune donnée pour l’instant.",
        ),
        "statsPeerThisMonth": MessageLookupByLibrary.simpleMessage(
          "Entre collègues ce mois-ci",
        ),
        "statsTopCatalog": MessageLookupByLibrary.simpleMessage(
          "Les plus décernés",
        ),
        "statsTopSenders": MessageLookupByLibrary.simpleMessage(
          "Ceux qui saluent le plus",
        ),
        "statsTopSendersHint": MessageLookupByLibrary.simpleMessage(
          "Succès de base envoyés ces 90 derniers jours.",
        ),
        "statsUnderRecognized": MessageLookupByLibrary.simpleMessage(
          "Mériteraient un peu de reconnaissance",
        ),
        "statsUnderRecognizedHint": MessageLookupByLibrary.simpleMessage(
          "Les personnes qui ont reçu le moins de succès ces 90 derniers jours.",
        ),
        "statusApproved": MessageLookupByLibrary.simpleMessage("Approuvée"),
        "statusPending": MessageLookupByLibrary.simpleMessage("En attente"),
        "statusRejected": MessageLookupByLibrary.simpleMessage("Refusée"),
        "submitRequest":
            MessageLookupByLibrary.simpleMessage("Envoyer la demande"),
        "teamDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Équipe supprimée",
        ),
        "teamEmpty": MessageLookupByLibrary.simpleMessage(
          "Personne dans votre équipe pour l’instant.",
        ),
        "teamLastRecognized": m103,
        "teamLeaderboard": MessageLookupByLibrary.simpleMessage(
          "Classement de l’équipe",
        ),
        "teamManager": MessageLookupByLibrary.simpleMessage("Responsable"),
        "teamMemberActivity": m104,
        "teamName": MessageLookupByLibrary.simpleMessage("Nom de l’équipe"),
        "teamNeverRecognized": MessageLookupByLibrary.simpleMessage(
          "Pas encore de reconnaissance",
        ),
        "teamNoRecent": MessageLookupByLibrary.simpleMessage(
          "Rien depuis plus de 30 jours",
        ),
        "teamNominate": MessageLookupByLibrary.simpleMessage("Proposer"),
        "teamNominateTooltip": MessageLookupByLibrary.simpleMessage(
          "Proposer un succès vérifié",
        ),
        "teamSaved": MessageLookupByLibrary.simpleMessage("Équipe enregistrée"),
        "teamStatNeedAttention":
            MessageLookupByLibrary.simpleMessage("À suivre"),
        "teamStatReceived30": MessageLookupByLibrary.simpleMessage(
          "Reçus en 30 jours",
        ),
        "teamSubtitle": MessageLookupByLibrary.simpleMessage(
          "Qui est reconnu, et qui mériterait de l\'être davantage",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "Aucune équipe pour l’instant. Créez la première.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Chaque équipe a un responsable, qui voit comment ses membres sont reconnus et peut proposer pour eux des succès vérifiés.",
        ),
        "templateAdded": m105,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "Impossible de créer le succès. Réessayez.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "Impossible de supprimer le succès. Réessayez.",
        ),
        "templateDeleted": m106,
        "templateNameRequired": MessageLookupByLibrary.simpleMessage(
          "Donnez-lui un nom",
        ),
        "themeDark": MessageLookupByLibrary.simpleMessage("Sombre"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Clair"),
        "themeTitle": MessageLookupByLibrary.simpleMessage("Thème"),
        "tierBronze": MessageLookupByLibrary.simpleMessage("Bronze"),
        "tierGold": MessageLookupByLibrary.simpleMessage("Or"),
        "tierPeer": MessageLookupByLibrary.simpleMessage("Collègues"),
        "tierPlatinum": MessageLookupByLibrary.simpleMessage("Platine"),
        "tierSilver": MessageLookupByLibrary.simpleMessage("Argent"),
        "timeDays": m107,
        "timeHours": m108,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("À l’instant"),
        "timeMinutes": m109,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("Les meilleurs"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Ouvrir Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Quitter Scoreboard"),
        "upToDate": MessageLookupByLibrary.simpleMessage(
          "Vous avez la dernière version.",
        ),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Téléchargez-la depuis la page des versions sur GitHub.",
        ),
        "updateAvailableTitle": m110,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "Impossible de rechercher des mises à jour.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Télécharger"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Plus tard"),
        "updatesSection": MessageLookupByLibrary.simpleMessage("Mises à jour"),
        "uploadImage":
            MessageLookupByLibrary.simpleMessage("Importer une image"),
        "uploadLogo": MessageLookupByLibrary.simpleMessage("Importer un logo"),
        "uploadPhoto":
            MessageLookupByLibrary.simpleMessage("Importer une photo"),
        "useDemo": MessageLookupByLibrary.simpleMessage("L’utiliser"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Vérifié par l’entreprise",
        ),
        "verifiedCount": m111,
        "versionLabel": m112,
        "workEmail":
            MessageLookupByLibrary.simpleMessage("E-mail professionnel"),
        "xpToNextLevel": m113,
        "xpValue": m114,
        "youLabel": MessageLookupByLibrary.simpleMessage("(vous)"),
        "youSuffix": m115,
      };
}
