// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(count) =>
      "${Intl.plural(count, one: '1 logro', other: '${count} logros')}";

  static String m1(count, subject) =>
      "${Intl.plural(count, one: 'asignó «${subject}» a 1 persona', other: 'asignó «${subject}» a ${count} personas')}";

  static String m2(subject) => "archivó «${subject}»";

  static String m3(subject) => "añadió «${subject}» al catálogo";

  static String m4(subject) => "restauró «${subject}»";

  static String m5(subject) => "editó «${subject}»";

  static String m6(subject, target) => "movió a ${subject} a ${target}";

  static String m7(subject) => "sacó a ${subject} de su equipo";

  static String m8(subject, target) => "propuso «${subject}» para ${target}";

  static String m9(target) => "exportó los datos personales de ${target}";

  static String m10(target) => "exportó el informe de logros (${target})";

  static String m11(target) => "exportó el informe por persona (${target})";

  static String m12(subject, target) => "aprobó «${subject}» para ${target}";

  static String m13(subject, target) => "rechazó «${subject}» para ${target}";

  static String m14(subject) => "creó la temporada ${subject}";

  static String m15(subject) => "eliminó la temporada ${subject}";

  static String m16(subject) => "editó la temporada ${subject}";

  static String m17(subject) => "creó el equipo ${subject}";

  static String m18(subject) => "eliminó el equipo ${subject}";

  static String m19(subject) => "editó el equipo ${subject}";

  static String m20(company) => "Admin · ${company}";

  static String m21(points) => "${points} XP";

  static String m22(years) =>
      "${Intl.plural(years, one: '1 año', other: '${years} años')}";

  static String m23(count) =>
      "${Intl.plural(count, zero: 'Asignar', one: 'Asignar a 1 persona', other: 'Asignar a ${count} personas')}";

  static String m24(maxPoints) =>
      "Los logros básicos se envían entre compañeros y valen hasta ${maxPoints} XP. Los logros verificados solo los emite tu empresa. Puedes enviar cada logro básico al mismo compañero una sola vez.";

  static String m25(company) =>
      "Vuestro color y vuestro logo sustituyen al oro de Scoreboard para todo ${company}. El color se ajusta para que los textos sigan siendo legibles.";

  static String m26(remaining, budget) =>
      "Te quedan ${remaining} de ${budget} envíos este mes";

  static String m27(name) => "De ${name}";

  static String m28(date) => "Emitido el ${date}";

  static String m29(date) => "Recibido el ${date}";

  static String m30(id) => "ID de la credencial: ${id}";

  static String m31(company, date) => "Emitido por ${company} el ${date}";

  static String m32(count) =>
      "${Intl.plural(count, zero: 'Comentar', one: '1 comentario', other: '${count} comentarios')}";

  static String m33(year) => "Desde ${year}";

  static String m34(count) => "Solicitudes · ${count}";

  static String m35(company) => "Gestiona los logros verificados de ${company}";

  static String m36(name) => "De ${name}";

  static String m37(name) => "¿Eliminar ${name}?";

  static String m38(name) => "¿Eliminar ${name}?";

  static String m39(name) => "¿Eliminar «${name}»?";

  static String m40(email, password) =>
      "Cuenta de demostración: ${email} / ${password}";

  static String m41(id) => "ID ${id}";

  static String m42(template, colleague) =>
      "Ya enviaste «${template}» a ${colleague}.";

  static String m43(budget) =>
      "Ya has enviado los ${budget} logros de este mes. El presupuesto se renueva el día 1.";

  static String m44(min, max) =>
      "El valor debe estar entre ${min} y ${max} XP.";

  static String m45(values) => "Los logros básicos pueden valer ${values} XP.";

  static String m46(min) =>
      "La contraseña debe tener al menos ${min} caracteres.";

  static String m47(count) => "Todos · ${count}";

  static String m48(tier, count) => "${tier} · ${count}";

  static String m49(count) =>
      "${Intl.plural(count, one: 'Emitido a 1 persona', other: 'Emitido a ${count} personas')}";

  static String m50(count) =>
      "${Intl.plural(count, one: 'una vez', other: '${count} veces')}";

  static String m51(level, points) => "Nivel ${level} · ${points} XP";

  static String m52(level) => "Nivel ${level}";

  static String m53(count) => "Biblioteca · ${count}";

  static String m54(date) => "Miembro desde ${date}";

  static String m55(name) => "Equipo de ${name}";

  static String m56(count) =>
      "${Intl.plural(count, one: '1 miembro', other: '${count} miembros')}";

  static String m57(name) =>
      "Para ${name}. Un administrador revisará tu propuesta.";

  static String m58(achievement) =>
      "«${achievement}» se ha aprobado y ya está en tus logros";

  static String m59(actor, achievement, text) =>
      "${actor} ha comentado «${achievement}»: ${text}";

  static String m60(level) => "Has alcanzado el nivel ${level}";

  static String m61(actor, achievement) =>
      "${actor} ha solicitado «${achievement}»";

  static String m62(actor, achievement, member) =>
      "${actor} propone «${achievement}» para ${member}";

  static String m63(actor, achievement) =>
      "${actor} te ha enviado «${achievement}»";

  static String m64(actor, achievement) =>
      "${actor} ha reaccionado a «${achievement}»";

  static String m65(xp, rank) => "Esta semana: +${xp} XP · posición #${rank}";

  static String m66(achievement) => "«${achievement}» no se ha aprobado";

  static String m67(achievement, reason) =>
      "«${achievement}» no se ha aprobado: ${reason}";

  static String m68(company, achievement) =>
      "${company} te ha emitido «${achievement}»";

  static String m69(count) =>
      "${Intl.plural(count, zero: 'No hay notificaciones sin leer', one: '1 notificación sin leer', other: '${count} notificaciones sin leer')}";

  static String m70(shortcut) =>
      "Pulsa ${shortcut} para enviar un logro desde cualquier sitio, o usa el icono de la barra de menús.";

  static String m71(budget) =>
      "Los logros verificados vienen de tu empresa: puedes solicitarlos desde el catálogo. Los logros básicos se intercambian entre compañeros, hasta ${budget} al mes.";

  static String m72(min) => "Al menos ${min} caracteres";

  static String m73(percent) => "${percent} %";

  static String m74(rank) => "#${rank}";

  static String m75(reason) => "Motivo: ${reason}";

  static String m76(company) =>
      "Un administrador de ${company} revisará tu solicitud.";

  static String m77(name) => "Propuesto por ${name}";

  static String m78(role, company) => "${role} en ${company}";

  static String m79(days) =>
      "${Intl.plural(days, one: 'Queda 1 día', other: 'Quedan ${days} días')}";

  static String m80(start, end) => "${start} – ${end}";

  static String m81(rank, points) => "Vas #${rank} con ${points} XP";

  static String m82(name) => "Logro enviado a ${name}";

  static String m83(count) => "Enviados por ti · ${count}";

  static String m84(count) => "${count} enviados";

  static String m85(company) =>
      "Lo añade a Licencias y certificaciones, con ${company} como emisor.";

  static String m86(company) => "Emitido por ${company}";

  static String m87(sender, name, description) =>
      "🤝 ${sender} me ha reconocido con el logro «${name}».\n\n${description}\n\n#Scoreboard";

  static String m88(name, company, description) =>
      "🏆 Acabo de conseguir el logro «${name}», emitido por ${company}.\n\n${description}\n\n#Scoreboard";

  static String m89(time) => "Último reconocimiento: ${time}";

  static String m90(received, sent) =>
      "${received} recibidos · ${sent} enviados en 90 días";

  static String m91(name) => "«${name}» añadido a la biblioteca";

  static String m92(name) => "«${name}» eliminado";

  static String m93(count) =>
      "${Intl.plural(count, one: 'Ayer', other: 'hace ${count} días')}";

  static String m94(count) => "hace ${count} h";

  static String m95(count) => "hace ${count} min";

  static String m96(version) => "Ya está disponible la versión ${version}";

  static String m97(count) => "${count} verificados";

  static String m98(version) => "Versión ${version}";

  static String m99(points, level) => "${points} XP para el nivel ${level}";

  static String m100(points) => "${points} XP";

  static String m101(name) => "${name} (tú)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accountSubtitle": MessageLookupByLibrary.simpleMessage(
          "Datos de acceso. Tu nombre, foto y portada están en Perfil.",
        ),
        "achievementDetailTitle": MessageLookupByLibrary.simpleMessage("Logro"),
        "achievementNamePlaceholder": MessageLookupByLibrary.simpleMessage(
          "Nombre del logro",
        ),
        "achievementsCount": m0,
        "achievementsEmptyBody": MessageLookupByLibrary.simpleMessage(
          "Solicita un logro verificado del catálogo de tu empresa o reconoce el trabajo de un compañero: suele ser la mejor forma de empezar.",
        ),
        "achievementsEmptyTitle": MessageLookupByLibrary.simpleMessage(
          "Tu primer logro te está esperando",
        ),
        "achievementsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Cada meta que has alcanzado por el camino",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage("Tus logros"),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "No ha funcionado. Inténtalo de nuevo.",
        ),
        "activityAchievementsIssued": m1,
        "activityAnniversariesUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió los aniversarios laborales",
        ),
        "activityBrandUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió el color o el logo de la empresa",
        ),
        "activityCatalogArchived": m2,
        "activityCatalogCreated": m3,
        "activityCatalogRestored": m4,
        "activityCatalogUpdated": m5,
        "activityEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay actividad registrada.",
        ),
        "activityHint": MessageLookupByLibrary.simpleMessage(
          "Lo que han hecho administradores y responsables, de lo más reciente a lo más antiguo. No se puede modificar.",
        ),
        "activityMemberMoved": m6,
        "activityMemberRemoved": m7,
        "activityNominationSubmitted": m8,
        "activityPersonalDataExported": m9,
        "activityReportAchievements": m10,
        "activityReportPeople": m11,
        "activityRequestApproved": m12,
        "activityRequestRejected": m13,
        "activitySeasonCreated": m14,
        "activitySeasonDeleted": m15,
        "activitySeasonUpdated": m16,
        "activityTeamCreated": m17,
        "activityTeamDeleted": m18,
        "activityTeamUpdated": m19,
        "adminBadge": m20,
        "adminGroupCompany": MessageLookupByLibrary.simpleMessage("EMPRESA"),
        "adminGroupData": MessageLookupByLibrary.simpleMessage("DATOS"),
        "adminGroupPeople": MessageLookupByLibrary.simpleMessage("PERSONAS"),
        "adminGroupRecognition": MessageLookupByLibrary.simpleMessage(
          "RECONOCIMIENTOS",
        ),
        "adminMode": MessageLookupByLibrary.simpleMessage("Modo administrador"),
        "adminModeHint": MessageLookupByLibrary.simpleMessage(
          "Gestiona los logros verificados de tu empresa",
        ),
        "alreadyHasIt": MessageLookupByLibrary.simpleMessage("Ya lo tiene"),
        "alreadySentToColleague": MessageLookupByLibrary.simpleMessage(
          "Ya enviado a este compañero",
        ),
        "anniversariesBody": MessageLookupByLibrary.simpleMessage(
          "Un logro verificado en cada aniversario laboral que celebráis, asignado automáticamente.",
        ),
        "anniversariesEnabled": MessageLookupByLibrary.simpleMessage(
          "Celebrar los aniversarios laborales",
        ),
        "anniversariesTitle": MessageLookupByLibrary.simpleMessage(
          "Aniversarios laborales",
        ),
        "anniversaryXp": m21,
        "anniversaryYears": m22,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Elige cómo se ve Scoreboard",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Aprobar"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivar"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archivado"),
        "assignButton": m23,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "Un mensaje para quienes lo reciben",
        ),
        "assignNoteLabel":
            MessageLookupByLibrary.simpleMessage("Nota (opcional)"),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Únete al marcador de tu empresa.",
        ),
        "authCreateTitle":
            MessageLookupByLibrary.simpleMessage("Crea tu cuenta"),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Reúne los logros que emite tu empresa y reconoce a los compañeros que marcan la diferencia.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Inicia sesión para ver tus logros.",
        ),
        "authTagline": MessageLookupByLibrary.simpleMessage(
          "Cada éxito,\nque quede registrado.",
        ),
        "authWelcomeBack":
            MessageLookupByLibrary.simpleMessage("Hola de nuevo"),
        "bannerClay": MessageLookupByLibrary.simpleMessage("Arcilla"),
        "bannerForest": MessageLookupByLibrary.simpleMessage("Bosque"),
        "bannerGold": MessageLookupByLibrary.simpleMessage("Oro"),
        "bannerGraphite": MessageLookupByLibrary.simpleMessage("Grafito"),
        "bannerOcean": MessageLookupByLibrary.simpleMessage("Océano"),
        "bannerSand": MessageLookupByLibrary.simpleMessage("Arena"),
        "baseExplanation": m24,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Crea logros y envíalos a tus compañeros",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Una línea sobre ti y lo que haces",
        ),
        "brandBody": m25,
        "brandColor": MessageLookupByLibrary.simpleMessage("Color"),
        "brandDefault":
            MessageLookupByLibrary.simpleMessage("Oro de Scoreboard"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Vista previa"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Marca"),
        "budgetRemaining": m26,
        "cardBaseAchievement":
            MessageLookupByLibrary.simpleMessage("Logro básico"),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Dar la vuelta"),
        "cardFrom": m27,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("EMITIDO POR"),
        "cardIssuedOn": m28,
        "cardReceivedOn": m29,
        "cardSentBy": MessageLookupByLibrary.simpleMessage("ENVIADO POR"),
        "cardVerifiedAchievement": MessageLookupByLibrary.simpleMessage(
          "Logro verificado",
        ),
        "catalogDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Solo los administradores pueden emitirlo, y aparece como verificado para quien lo recibe.",
        ),
        "catalogEmpty": MessageLookupByLibrary.simpleMessage(
          "El catálogo está vacío. Crea el primer logro.",
        ),
        "catalogPointsHint": MessageLookupByLibrary.simpleMessage(
          "El valor fija el nivel: Bronce por debajo de 100 XP, Plata desde 100, Oro desde 120, Platino desde 140.",
        ),
        "catalogSaved": MessageLookupByLibrary.simpleMessage(
          "Catálogo actualizado",
        ),
        "certCredentialId": m30,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "ha conseguido el logro",
        ),
        "certIssuedBy": m31,
        "certPresentedTo":
            MessageLookupByLibrary.simpleMessage("Se certifica que"),
        "certTitle":
            MessageLookupByLibrary.simpleMessage("CERTIFICADO DE LOGRO"),
        "changePassword": MessageLookupByLibrary.simpleMessage(
          "Cambiar contraseña",
        ),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Buscar actualizaciones",
        ),
        "chooseCompany":
            MessageLookupByLibrary.simpleMessage("Elige tu empresa"),
        "commentHint": MessageLookupByLibrary.simpleMessage(
          "Escribe un comentario…",
        ),
        "commentsCount": m32,
        "commonBack": MessageLookupByLibrary.simpleMessage("Atrás"),
        "commonCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "commonClose": MessageLookupByLibrary.simpleMessage("Cerrar"),
        "commonCreate": MessageLookupByLibrary.simpleMessage("Crear"),
        "commonDelete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "commonEdit": MessageLookupByLibrary.simpleMessage("Editar"),
        "commonPreview": MessageLookupByLibrary.simpleMessage("VISTA PREVIA"),
        "commonRemove": MessageLookupByLibrary.simpleMessage("Quitar"),
        "commonRetry": MessageLookupByLibrary.simpleMessage("Reintentar"),
        "commonSave": MessageLookupByLibrary.simpleMessage("Guardar"),
        "commonSend": MessageLookupByLibrary.simpleMessage("Enviar"),
        "communityCompanies": MessageLookupByLibrary.simpleMessage("Empresas"),
        "communityHiddenNotice": MessageLookupByLibrary.simpleMessage(
          "No apareces en esta clasificación. Puedes cambiarlo en Ajustes → Cuenta.",
        ),
        "communityPeople": MessageLookupByLibrary.simpleMessage("Personas"),
        "communitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Mira en qué posición estás respecto a los demás",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Comunidad"),
        "companyCatalog": MessageLookupByLibrary.simpleMessage(
          "Catálogo de la empresa",
        ),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "Los logros verificados que puedes conseguir. Si crees que te mereces uno, solicítalo.",
        ),
        "companySince": m33,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Confirma la nueva contraseña",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage(
          "Registro de actividad",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Asignar"),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catálogo"),
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Empresa"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Informes"),
        "consoleRequests": m34,
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Temporadas"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Estadísticas"),
        "consoleSubtitle": m35,
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Equipos"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Cualquiera de tu empresa puede enviárselo a un compañero.",
        ),
        "createdBy": m36,
        "createdByYou": MessageLookupByLibrary.simpleMessage("Creado por ti"),
        "currentPassword": MessageLookupByLibrary.simpleMessage(
          "Contraseña actual",
        ),
        "currentPasswordRequired": MessageLookupByLibrary.simpleMessage(
          "Escribe tu contraseña actual",
        ),
        "decidedSection": MessageLookupByLibrary.simpleMessage("Resueltas"),
        "deleteSeasonBody": MessageLookupByLibrary.simpleMessage(
          "Su clasificación desaparece. Los logros se conservan.",
        ),
        "deleteSeasonTitle": m37,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "Sus miembros se quedarán sin equipo. Sus logros se conservan.",
        ),
        "deleteTeamTitle": m38,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Se quitará de la biblioteca. Los compañeros que ya lo recibieron conservan su logro.",
        ),
        "deleteTemplateTitle": m39,
        "demoAccount": m40,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "¿Qué hay que hacer para merecerlo?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Añade una descripción breve",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Empresa"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Conseguido el"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Experiencia"),
        "detailId": m41,
        "detailSentBy": MessageLookupByLibrary.simpleMessage("Enviado por"),
        "detailTier": MessageLookupByLibrary.simpleMessage("Nivel"),
        "earnedLabel": MessageLookupByLibrary.simpleMessage("Conseguido"),
        "editCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Editar logro",
        ),
        "editProfile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
        "editSeason": MessageLookupByLibrary.simpleMessage("Editar temporada"),
        "editTeam": MessageLookupByLibrary.simpleMessage("Editar equipo"),
        "emailSaveError": MessageLookupByLibrary.simpleMessage(
          "No se pudo guardar tu correo. Inténtalo de nuevo.",
        ),
        "emailUpdated":
            MessageLookupByLibrary.simpleMessage("Correo actualizado"),
        "emptyOpenCatalog": MessageLookupByLibrary.simpleMessage(
          "Abrir el catálogo",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "Ya tienes este logro.",
        ),
        "errorAlreadySent": m42,
        "errorBudgetExhausted": m43,
        "errorCatalogPoints": m44,
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "Ya existe una cuenta con este correo.",
        ),
        "errorInvalidDates": MessageLookupByLibrary.simpleMessage(
          "La fecha de fin no puede ser anterior a la de inicio.",
        ),
        "errorInvalidPoints": m45,
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Escribe tu correo y tu contraseña.",
        ),
        "errorMissingFields": MessageLookupByLibrary.simpleMessage(
          "Rellena todos los campos obligatorios.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Escribe tu nombre y tu puesto.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "Solo puedes enviar logros a compañeros de tu empresa.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Solo los administradores de la empresa pueden hacerlo.",
        ),
        "errorNotFound": MessageLookupByLibrary.simpleMessage("No encontrado."),
        "errorNotInTeam": MessageLookupByLibrary.simpleMessage(
          "Esta persona no forma parte de tu equipo.",
        ),
        "errorNotManager": MessageLookupByLibrary.simpleMessage(
          "Solo los responsables de equipo pueden hacerlo.",
        ),
        "errorNotSignedIn": MessageLookupByLibrary.simpleMessage(
          "No has iniciado sesión.",
        ),
        "errorNotTemplateOwner": MessageLookupByLibrary.simpleMessage(
          "Solo puedes eliminar los logros básicos que has creado tú.",
        ),
        "errorPasswordTooShort": m46,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Ya tienes una solicitud pendiente para este logro.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "Estas fechas se solapan con otra temporada.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "Este logro básico ya no existe.",
        ),
        "errorWrongCredentials": MessageLookupByLibrary.simpleMessage(
          "Correo o contraseña incorrectos.",
        ),
        "errorWrongCurrentPassword": MessageLookupByLibrary.simpleMessage(
          "La contraseña actual es incorrecta.",
        ),
        "evidenceLink": MessageLookupByLibrary.simpleMessage("Abrir prueba"),
        "evidenceUrlLabel": MessageLookupByLibrary.simpleMessage(
          "Enlace a una prueba (opcional)",
        ),
        "experienceNote": MessageLookupByLibrary.simpleMessage(
          "Los logros básicos valen menos que los verificados que emite tu empresa.",
        ),
        "exportCsv": MessageLookupByLibrary.simpleMessage("Exportar CSV"),
        "exportError": MessageLookupByLibrary.simpleMessage(
          "No se pudo guardar el archivo. Inténtalo de nuevo.",
        ),
        "exportJson": MessageLookupByLibrary.simpleMessage("Exportar JSON"),
        "exportMenu": MessageLookupByLibrary.simpleMessage("Exportar"),
        "exportOpenBadge": MessageLookupByLibrary.simpleMessage(
          "Open Badge (JSON)",
        ),
        "exportOpenBadgeHint": MessageLookupByLibrary.simpleMessage(
          "Credencial Open Badges 3.0. La firma digital llegará con el backend.",
        ),
        "exportPdf": MessageLookupByLibrary.simpleMessage("Certificado PDF"),
        "exportSaved": MessageLookupByLibrary.simpleMessage("Archivo guardado"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("ha conseguido"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay nada en el muro.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "Los logros de tus compañeros, para celebrarlos juntos",
        ),
        "feedTitle": MessageLookupByLibrary.simpleMessage("Muro de la empresa"),
        "fieldAchievement": MessageLookupByLibrary.simpleMessage("Logro"),
        "fieldBio": MessageLookupByLibrary.simpleMessage("Biografía"),
        "fieldColleague": MessageLookupByLibrary.simpleMessage("Compañero"),
        "fieldCover": MessageLookupByLibrary.simpleMessage("Portada"),
        "fieldDescription": MessageLookupByLibrary.simpleMessage("Descripción"),
        "fieldEmail":
            MessageLookupByLibrary.simpleMessage("Correo electrónico"),
        "fieldExperience": MessageLookupByLibrary.simpleMessage("Experiencia"),
        "fieldFullName":
            MessageLookupByLibrary.simpleMessage("Nombre completo"),
        "fieldIcon": MessageLookupByLibrary.simpleMessage("Icono"),
        "fieldMessageOptional": MessageLookupByLibrary.simpleMessage(
          "Mensaje (opcional)",
        ),
        "fieldName": MessageLookupByLibrary.simpleMessage("Nombre"),
        "fieldPhoto": MessageLookupByLibrary.simpleMessage("Foto"),
        "fieldRole": MessageLookupByLibrary.simpleMessage("Puesto"),
        "filterAll": m47,
        "filterTier": m48,
        "flipHint": MessageLookupByLibrary.simpleMessage(
          "Haz clic en la tarjeta para darle la vuelta",
        ),
        "fromAColleague":
            MessageLookupByLibrary.simpleMessage("De un compañero"),
        "genericError": MessageLookupByLibrary.simpleMessage(
          "Algo salió mal. Inténtalo de nuevo.",
        ),
        "hapticsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Mantén pulsada una tarjeta para darle la vuelta y nota cómo encaja en el trackpad Force Touch.",
        ),
        "hapticsTitle":
            MessageLookupByLibrary.simpleMessage("Respuesta háptica"),
        "hidePassword":
            MessageLookupByLibrary.simpleMessage("Ocultar contraseña"),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Escribe una dirección de correo válida",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Escribe un enlace http(s) válido",
        ),
        "issuedCount": m49,
        "issuedTimes": m50,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verificado"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("Sistema"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Idioma"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Clasificación"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Entre compañeros"),
        "levelAndXp": m51,
        "levelN": m52,
        "libraryCount": m53,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay logros básicos. ¡Crea el primero!",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Algo salió mal al cargar los datos.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Marcar todo como leído",
        ),
        "memberSince": m54,
        "memberTeamLabel": m55,
        "membersCount": m56,
        "membersWithoutTeam":
            MessageLookupByLibrary.simpleMessage("Sin equipo"),
        "menuLabel": MessageLookupByLibrary.simpleMessage("MENÚ"),
        "messageHint": MessageLookupByLibrary.simpleMessage(
          "Cuéntale por qué se lo merece",
        ),
        "myRequests": MessageLookupByLibrary.simpleMessage("Tus solicitudes"),
        "nameHint": MessageLookupByLibrary.simpleMessage(
          "p. ej. Espíritu de equipo",
        ),
        "nameRequired":
            MessageLookupByLibrary.simpleMessage("Escribe tu nombre"),
        "navAchievements": MessageLookupByLibrary.simpleMessage("Logros"),
        "navBaseAchievements": MessageLookupByLibrary.simpleMessage(
          "Logros básicos",
        ),
        "navCommunity": MessageLookupByLibrary.simpleMessage("Comunidad"),
        "navConsole":
            MessageLookupByLibrary.simpleMessage("Consola de empresa"),
        "navFeed": MessageLookupByLibrary.simpleMessage("Muro"),
        "navProfile": MessageLookupByLibrary.simpleMessage("Perfil"),
        "navRequests": MessageLookupByLibrary.simpleMessage("Solicitudes"),
        "navSettings": MessageLookupByLibrary.simpleMessage("Ajustes"),
        "navTeam": MessageLookupByLibrary.simpleMessage("Mi equipo"),
        "navYourCompany": MessageLookupByLibrary.simpleMessage("Tu empresa"),
        "newBaseAchievement": MessageLookupByLibrary.simpleMessage(
          "Nuevo logro básico",
        ),
        "newCatalogAchievement": MessageLookupByLibrary.simpleMessage(
          "Nuevo logro verificado",
        ),
        "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
        "newSeason": MessageLookupByLibrary.simpleMessage("Nueva temporada"),
        "newTeam": MessageLookupByLibrary.simpleMessage("Nuevo equipo"),
        "noAchievementsInTier": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay logros en este nivel.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay logros.",
        ),
        "noManager": MessageLookupByLibrary.simpleMessage("Sin responsable"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Ningún resultado coincide con tu búsqueda.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("Sin equipo"),
        "nominateDialogSubtitle": m57,
        "nominateDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Proponer un logro verificado",
        ),
        "nominateMessageHint": MessageLookupByLibrary.simpleMessage(
          "¿Por qué se lo merece?",
        ),
        "nominateSent": MessageLookupByLibrary.simpleMessage(
          "Propuesta enviada a los administradores",
        ),
        "noteAuthorFallback":
            MessageLookupByLibrary.simpleMessage("Un compañero"),
        "notifApprovedBody": m58,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Solicitud aprobada",
        ),
        "notifCommentBody": m59,
        "notifCommentTitle": MessageLookupByLibrary.simpleMessage(
          "Nuevo comentario",
        ),
        "notifLevelUpBody": m60,
        "notifLevelUpTitle": MessageLookupByLibrary.simpleMessage(
          "¡Subes de nivel!",
        ),
        "notifNewRequestBody": m61,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Nueva solicitud",
        ),
        "notifNominationBody": m62,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "Nueva propuesta",
        ),
        "notifPeerBody": m63,
        "notifPeerTitle": MessageLookupByLibrary.simpleMessage("Nuevo logro"),
        "notifReactionBody": m64,
        "notifReactionTitle": MessageLookupByLibrary.simpleMessage(
          "Nueva reacción",
        ),
        "notifRecapBody": m65,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Tu resumen semanal",
        ),
        "notifRejectedBody": m66,
        "notifRejectedBodyReason": m67,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Solicitud rechazada",
        ),
        "notifVerifiedBody": m68,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Logro verificado",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay notificaciones.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Abrir notificaciones",
        ),
        "notificationsTitle": MessageLookupByLibrary.simpleMessage(
          "Notificaciones",
        ),
        "notificationsUnread": m69,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Empezar"),
        "onboardingFastBody": m70,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Ve rápido"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "El muro muestra los logros de tus compañeros para que puedas reaccionar y comentar. Las notificaciones te avisan cuando algo te afecta.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Celebrad juntos",
        ),
        "onboardingKindsBody": m71,
        "onboardingKindsTitle": MessageLookupByLibrary.simpleMessage(
          "Logros verificados y entre compañeros",
        ),
        "onboardingNext": MessageLookupByLibrary.simpleMessage("Siguiente"),
        "onboardingReplay": MessageLookupByLibrary.simpleMessage(
          "Ver de nuevo la introducción",
        ),
        "onboardingSkip": MessageLookupByLibrary.simpleMessage("Omitir"),
        "onboardingWelcomeBody": MessageLookupByLibrary.simpleMessage(
          "Aquí reúnes, en forma de tarjetas, los logros que consigues en el trabajo. Pasa el cursor por encima y dales la vuelta para ver quién los emitió.",
        ),
        "onboardingWelcomeTitle": MessageLookupByLibrary.simpleMessage(
          "Te damos la bienvenida a Scoreboard",
        ),
        "passwordChangeError": MessageLookupByLibrary.simpleMessage(
          "No se pudo cambiar tu contraseña. Inténtalo de nuevo.",
        ),
        "passwordChanged": MessageLookupByLibrary.simpleMessage(
          "Contraseña cambiada",
        ),
        "passwordLabel": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "passwordMinLength": m72,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Escribe tu contraseña",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Las contraseñas no coinciden",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("Pendientes"),
        "percentValue": m73,
        "periodAll": MessageLookupByLibrary.simpleMessage("Desde siempre"),
        "periodLast30": MessageLookupByLibrary.simpleMessage("Últimos 30 días"),
        "periodQuarter": MessageLookupByLibrary.simpleMessage("Este trimestre"),
        "periodYear": MessageLookupByLibrary.simpleMessage("Este año"),
        "personalDataBody": MessageLookupByLibrary.simpleMessage(
          "Todo lo que Scoreboard guarda sobre una persona, en JSON, para solicitudes de protección de datos.",
        ),
        "personalDataPerson": MessageLookupByLibrary.simpleMessage("Persona"),
        "personalDataTitle": MessageLookupByLibrary.simpleMessage(
          "Datos personales",
        ),
        "pickAchievementHint": MessageLookupByLibrary.simpleMessage(
          "Elige un logro del catálogo.",
        ),
        "pickDates": MessageLookupByLibrary.simpleMessage("Elige las fechas"),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Tus compañeros te siguen viendo en la clasificación del equipo.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "Mostrarme en la clasificación de la Comunidad",
        ),
        "privacySection": MessageLookupByLibrary.simpleMessage("Privacidad"),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "No se pudo guardar tu perfil. Inténtalo de nuevo.",
        ),
        "profileUpdated": MessageLookupByLibrary.simpleMessage(
          "Perfil actualizado",
        ),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Oculto"),
        "rankValue": m74,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Celebrar"),
        "reactionInsightful":
            MessageLookupByLibrary.simpleMessage("Interesante"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Me gusta"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Me encanta"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Logros recientes",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Rechazar"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "¿Rechazar la solicitud?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Motivo (opcional)",
        ),
        "rejectionReason": m75,
        "replaceImage": MessageLookupByLibrary.simpleMessage("Cambiar imagen"),
        "reportAchievementsBody": MessageLookupByLibrary.simpleMessage(
          "Una fila por logro recibido: fecha, persona, equipo, tipo, XP y quién lo dio.",
        ),
        "reportAchievementsTitle":
            MessageLookupByLibrary.simpleMessage("Logros"),
        "reportPeopleBody": MessageLookupByLibrary.simpleMessage(
          "Una fila por persona: logros recibidos y enviados, XP y último reconocimiento.",
        ),
        "reportPeopleTitle": MessageLookupByLibrary.simpleMessage("Personas"),
        "reportPeriod": MessageLookupByLibrary.simpleMessage("Periodo"),
        "reportSaved": MessageLookupByLibrary.simpleMessage("Informe guardado"),
        "reportsHint": MessageLookupByLibrary.simpleMessage(
          "Para evaluaciones y sistemas de RR. HH. Cada exportación queda en el registro de actividad.",
        ),
        "requestAction": MessageLookupByLibrary.simpleMessage("Solicitar"),
        "requestApprovedMessage": MessageLookupByLibrary.simpleMessage(
          "Solicitud aprobada",
        ),
        "requestDialogSubtitle": m76,
        "requestDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Solicitar un logro",
        ),
        "requestMessage": MessageLookupByLibrary.simpleMessage("Mensaje"),
        "requestMessageHint": MessageLookupByLibrary.simpleMessage(
          "¿Qué has hecho para merecerlo?",
        ),
        "requestMessageRequired": MessageLookupByLibrary.simpleMessage(
          "Escribe un mensaje",
        ),
        "requestNominatedBy": m77,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Solicitud rechazada",
        ),
        "requestSent":
            MessageLookupByLibrary.simpleMessage("Solicitud enviada"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage(
          "No hay solicitudes.",
        ),
        "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
        "roleAtCompany": m78,
        "roleRequired":
            MessageLookupByLibrary.simpleMessage("Escribe tu puesto"),
        "saveProfile": MessageLookupByLibrary.simpleMessage("Guardar perfil"),
        "searchAchievementsHint": MessageLookupByLibrary.simpleMessage(
          "Busca en tus logros",
        ),
        "searchCompaniesHint": MessageLookupByLibrary.simpleMessage(
          "Busca por nombre o sector",
        ),
        "searchPeopleHint": MessageLookupByLibrary.simpleMessage(
          "Busca por nombre, puesto o empresa",
        ),
        "seasonActive": MessageLookupByLibrary.simpleMessage("En curso"),
        "seasonCurrent":
            MessageLookupByLibrary.simpleMessage("Temporada en curso"),
        "seasonDates": MessageLookupByLibrary.simpleMessage("Fechas"),
        "seasonDaysLeft": m79,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Temporada eliminada",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Terminada"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Nombre"),
        "seasonNameHint":
            MessageLookupByLibrary.simpleMessage("p. ej. Otoño 2026"),
        "seasonRange": m80,
        "seasonSaved":
            MessageLookupByLibrary.simpleMessage("Temporada guardada"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("Próxima"),
        "seasonYourRank": m81,
        "seasonsEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay temporadas.",
        ),
        "seasonsHint": MessageLookupByLibrary.simpleMessage(
          "Cada temporada tiene su propia clasificación, con los XP obtenidos entre sus fechas. Las temporadas no pueden solaparse.",
        ),
        "selectAll": MessageLookupByLibrary.simpleMessage("Seleccionar todo"),
        "sendAchievement": MessageLookupByLibrary.simpleMessage("Enviar logro"),
        "sendAnAchievement": MessageLookupByLibrary.simpleMessage(
          "Enviar un logro",
        ),
        "sendDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Reconoce a un compañero con uno de tus logros básicos.",
        ),
        "sendError": MessageLookupByLibrary.simpleMessage(
          "No se pudo enviar el logro. Inténtalo de nuevo.",
        ),
        "sendLoadError": MessageLookupByLibrary.simpleMessage(
          "No se pudieron cargar tus compañeros. Inténtalo de nuevo.",
        ),
        "sendNoColleagues": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay compañeros en tu empresa.",
        ),
        "sendNoTemplates": MessageLookupByLibrary.simpleMessage(
          "Primero crea un logro básico.",
        ),
        "sendPreviewHint": MessageLookupByLibrary.simpleMessage(
          "Elige un logro para ver cómo quedará.",
        ),
        "sendSuccess": m82,
        "sentByYouCount": m83,
        "sentCount": m84,
        "sentEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no has enviado ningún logro. Elige uno de la biblioteca y alégrale el día a un compañero.",
        ),
        "sentToConnector": MessageLookupByLibrary.simpleMessage("a"),
        "sessionSection": MessageLookupByLibrary.simpleMessage("Sesión"),
        "settingsAbout": MessageLookupByLibrary.simpleMessage("Acerca de"),
        "settingsAccount": MessageLookupByLibrary.simpleMessage("Cuenta"),
        "settingsAppearance":
            MessageLookupByLibrary.simpleMessage("Apariencia"),
        "settingsSavedMessage": MessageLookupByLibrary.simpleMessage(
          "Ajustes guardados",
        ),
        "shareAddToProfile": MessageLookupByLibrary.simpleMessage(
          "Añadir al perfil",
        ),
        "shareAddToProfileHint": m85,
        "shareCopyText": MessageLookupByLibrary.simpleMessage("Copiar texto"),
        "shareDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Publícalo o añádelo a tu perfil de LinkedIn.",
        ),
        "shareImageHeadline": MessageLookupByLibrary.simpleMessage(
          "LOGRO DESBLOQUEADO",
        ),
        "shareImageHint": MessageLookupByLibrary.simpleMessage(
          "Los enlaces de LinkedIn no pueden adjuntar imágenes: guarda esta y añádela a tu publicación.",
        ),
        "shareImageIssuedBy": m86,
        "shareImageSaved":
            MessageLookupByLibrary.simpleMessage("Imagen guardada"),
        "shareOnLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Compartir en LinkedIn",
        ),
        "shareOpenError": MessageLookupByLibrary.simpleMessage(
          "No se pudo abrir LinkedIn.",
        ),
        "shareOpenLinkedIn": MessageLookupByLibrary.simpleMessage(
          "Publicar en LinkedIn",
        ),
        "shareOpened": MessageLookupByLibrary.simpleMessage(
          "Texto copiado: si LinkedIn no lo rellena, pégalo en la publicación.",
        ),
        "sharePostLabel": MessageLookupByLibrary.simpleMessage(
          "Texto de la publicación",
        ),
        "sharePostPeer": m87,
        "sharePostVerified": m88,
        "shareSaveError": MessageLookupByLibrary.simpleMessage(
          "No se pudo guardar la imagen. Inténtalo de nuevo.",
        ),
        "shareSaveImage":
            MessageLookupByLibrary.simpleMessage("Guardar imagen"),
        "shareTextCopied": MessageLookupByLibrary.simpleMessage(
          "Texto copiado al portapapeles",
        ),
        "shortcutFlipCard": MessageLookupByLibrary.simpleMessage(
          "Dar la vuelta a la tarjeta seleccionada",
        ),
        "shortcutGoToPage": MessageLookupByLibrary.simpleMessage(
          "Ir a la página 1–8",
        ),
        "shortcutsSection": MessageLookupByLibrary.simpleMessage(
          "Atajos de teclado",
        ),
        "showArchived":
            MessageLookupByLibrary.simpleMessage("Mostrar archivados"),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Mostrar contraseña"),
        "signIn": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
        "signOut": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "signOutDescription": MessageLookupByLibrary.simpleMessage(
          "Cierra la sesión de Scoreboard en este ordenador.",
        ),
        "signOutError": MessageLookupByLibrary.simpleMessage(
          "No se pudo cerrar la sesión. Inténtalo de nuevo.",
        ),
        "sortLabel": MessageLookupByLibrary.simpleMessage("Ordenar"),
        "sortName": MessageLookupByLibrary.simpleMessage("Nombre (A–Z)"),
        "sortNewest": MessageLookupByLibrary.simpleMessage("Más recientes"),
        "sortOldest": MessageLookupByLibrary.simpleMessage("Más antiguos"),
        "sortPoints": MessageLookupByLibrary.simpleMessage("Más XP"),
        "statAchievements": MessageLookupByLibrary.simpleMessage("Logros"),
        "statCompanyRank": MessageLookupByLibrary.simpleMessage(
          "Posición en la empresa",
        ),
        "statGlobalRank":
            MessageLookupByLibrary.simpleMessage("Posición global"),
        "statMembers": MessageLookupByLibrary.simpleMessage("Miembros"),
        "statTotalXp": MessageLookupByLibrary.simpleMessage("XP total"),
        "statVerified": MessageLookupByLibrary.simpleMessage("Verificados"),
        "statYourRank": MessageLookupByLibrary.simpleMessage("Tu posición"),
        "statsActiveSenders": MessageLookupByLibrary.simpleMessage(
          "Personas que reconocen a otras",
        ),
        "statsCoverage": MessageLookupByLibrary.simpleMessage(
          "Reconocidos en los últimos 30 días",
        ),
        "statsIssuedThisMonth": MessageLookupByLibrary.simpleMessage(
          "Verificados este mes",
        ),
        "statsMonthlyChart": MessageLookupByLibrary.simpleMessage(
          "Logros de los últimos 6 meses",
        ),
        "statsNoData": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay datos.",
        ),
        "statsPeerThisMonth": MessageLookupByLibrary.simpleMessage(
          "Entre compañeros este mes",
        ),
        "statsTopCatalog":
            MessageLookupByLibrary.simpleMessage("Los más emitidos"),
        "statsTopSenders": MessageLookupByLibrary.simpleMessage(
          "Quienes más reconocen",
        ),
        "statsTopSendersHint": MessageLookupByLibrary.simpleMessage(
          "Logros básicos enviados en los últimos 90 días.",
        ),
        "statsUnderRecognized": MessageLookupByLibrary.simpleMessage(
          "Necesitan algo de reconocimiento",
        ),
        "statsUnderRecognizedHint": MessageLookupByLibrary.simpleMessage(
          "Quién ha recibido menos logros en los últimos 90 días.",
        ),
        "statusApproved": MessageLookupByLibrary.simpleMessage("Aprobada"),
        "statusPending": MessageLookupByLibrary.simpleMessage("Pendiente"),
        "statusRejected": MessageLookupByLibrary.simpleMessage("Rechazada"),
        "submitRequest":
            MessageLookupByLibrary.simpleMessage("Enviar solicitud"),
        "teamDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Equipo eliminado",
        ),
        "teamEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay nadie en tu equipo.",
        ),
        "teamLastRecognized": m89,
        "teamLeaderboard": MessageLookupByLibrary.simpleMessage(
          "Clasificación del equipo",
        ),
        "teamManager": MessageLookupByLibrary.simpleMessage("Responsable"),
        "teamMemberActivity": m90,
        "teamName": MessageLookupByLibrary.simpleMessage("Nombre del equipo"),
        "teamNeverRecognized": MessageLookupByLibrary.simpleMessage(
          "Todavía sin reconocimientos",
        ),
        "teamNoRecent": MessageLookupByLibrary.simpleMessage(
          "Nada en más de 30 días",
        ),
        "teamNominate": MessageLookupByLibrary.simpleMessage("Proponer"),
        "teamNominateTooltip": MessageLookupByLibrary.simpleMessage(
          "Proponer un logro verificado",
        ),
        "teamSaved": MessageLookupByLibrary.simpleMessage("Equipo guardado"),
        "teamStatNeedAttention": MessageLookupByLibrary.simpleMessage(
          "Requieren atención",
        ),
        "teamStatReceived30": MessageLookupByLibrary.simpleMessage(
          "Recibidos en 30 días",
        ),
        "teamSubtitle": MessageLookupByLibrary.simpleMessage(
          "Cómo se reconoce el trabajo de tu equipo",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay equipos. Crea el primero.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Cada equipo tiene un responsable, que ve cómo se reconoce a sus miembros y puede proponer logros verificados para ellos.",
        ),
        "templateAdded": m91,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "No se pudo crear el logro. Inténtalo de nuevo.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "No se pudo eliminar el logro. Inténtalo de nuevo.",
        ),
        "templateDeleted": m92,
        "templateNameRequired": MessageLookupByLibrary.simpleMessage(
          "Ponle un nombre",
        ),
        "themeDark": MessageLookupByLibrary.simpleMessage("Oscuro"),
        "themeLight": MessageLookupByLibrary.simpleMessage("Claro"),
        "themeTitle": MessageLookupByLibrary.simpleMessage("Tema"),
        "tierBronze": MessageLookupByLibrary.simpleMessage("Bronce"),
        "tierGold": MessageLookupByLibrary.simpleMessage("Oro"),
        "tierPeer": MessageLookupByLibrary.simpleMessage("Compañeros"),
        "tierPlatinum": MessageLookupByLibrary.simpleMessage("Platino"),
        "tierSilver": MessageLookupByLibrary.simpleMessage("Plata"),
        "timeDays": m93,
        "timeHours": m94,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Ahora mismo"),
        "timeMinutes": m95,
        "top3": MessageLookupByLibrary.simpleMessage("Top 3"),
        "topPerformers": MessageLookupByLibrary.simpleMessage("Los mejores"),
        "trayOpen": MessageLookupByLibrary.simpleMessage("Abrir Scoreboard"),
        "trayQuit": MessageLookupByLibrary.simpleMessage("Salir de Scoreboard"),
        "upToDate": MessageLookupByLibrary.simpleMessage(
          "Tienes la última versión.",
        ),
        "updateAvailableBody": MessageLookupByLibrary.simpleMessage(
          "Descárgala desde la página de versiones en GitHub.",
        ),
        "updateAvailableTitle": m96,
        "updateCheckError": MessageLookupByLibrary.simpleMessage(
          "No se pudo comprobar si hay actualizaciones.",
        ),
        "updateDownload": MessageLookupByLibrary.simpleMessage("Descargar"),
        "updateLater": MessageLookupByLibrary.simpleMessage("Más tarde"),
        "updatesSection":
            MessageLookupByLibrary.simpleMessage("Actualizaciones"),
        "uploadImage": MessageLookupByLibrary.simpleMessage("Subir imagen"),
        "uploadLogo": MessageLookupByLibrary.simpleMessage("Subir logo"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Subir foto"),
        "useDemo": MessageLookupByLibrary.simpleMessage("Usarla"),
        "verifiedByCompany": MessageLookupByLibrary.simpleMessage(
          "Verificado por la empresa",
        ),
        "verifiedCount": m97,
        "versionLabel": m98,
        "workEmail": MessageLookupByLibrary.simpleMessage("Correo del trabajo"),
        "xpToNextLevel": m99,
        "xpValue": m100,
        "youSuffix": m101,
      };
}
