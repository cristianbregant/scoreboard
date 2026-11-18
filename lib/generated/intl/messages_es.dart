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

  static String m2(subject) => "hizo administrador a ${subject}";

  static String m3(subject) =>
      "quitó los permisos de administrador a ${subject}";

  static String m4(subject) => "archivó «${subject}»";

  static String m5(subject) => "añadió «${subject}» al catálogo";

  static String m6(subject) => "restauró «${subject}»";

  static String m7(subject) => "editó «${subject}»";

  static String m8(subject) => "revocó la invitación de ${subject}";

  static String m9(subject) => "invitó a ${subject}";

  static String m10(subject, target) => "movió a ${subject} a ${target}";

  static String m11(subject) => "sacó a ${subject} de su equipo";

  static String m12(count) =>
      "${Intl.plural(count, one: 'invitó a 1 persona desde un archivo', other: 'invitó a ${count} personas desde un archivo')}";

  static String m13(subject, target) => "propuso «${subject}» para ${target}";

  static String m14(target) => "exportó los datos personales de ${target}";

  static String m15(target) => "exportó el informe de logros (${target})";

  static String m16(target) => "exportó el informe por persona (${target})";

  static String m17(subject, target) => "aprobó «${subject}» para ${target}";

  static String m18(subject, target) => "rechazó «${subject}» para ${target}";

  static String m19(subject) => "creó la temporada ${subject}";

  static String m20(subject) => "eliminó la temporada ${subject}";

  static String m21(subject) => "editó la temporada ${subject}";

  static String m22(subject) => "creó el equipo ${subject}";

  static String m23(subject) => "eliminó el equipo ${subject}";

  static String m24(subject) => "editó el equipo ${subject}";

  static String m25(company) => "Admin · ${company}";

  static String m26(name) => "${name} ahora es administrador";

  static String m27(name) => "${name} ya no es administrador";

  static String m28(points) => "${points} XP";

  static String m29(years) =>
      "${Intl.plural(years, one: '1 año', other: '${years} años')}";

  static String m30(count) =>
      "${Intl.plural(count, zero: 'Asignar', one: 'Asignar a 1 persona', other: 'Asignar a ${count} personas')}";

  static String m31(maxPoints) =>
      "Los logros básicos se envían entre compañeros y valen hasta ${maxPoints} XP. Los logros verificados solo los emite tu empresa. Puedes enviar cada logro básico al mismo compañero una sola vez.";

  static String m32(company) =>
      "Vuestro color y vuestro logo sustituyen al oro de Scoreboard para todo ${company}. El color se ajusta para que los textos sigan siendo legibles.";

  static String m33(remaining, budget) =>
      "Te quedan ${remaining} de ${budget} envíos este mes";

  static String m34(name) => "De ${name}";

  static String m35(date) => "Emitido el ${date}";

  static String m36(date) => "Recibido el ${date}";

  static String m37(id) => "ID de la credencial: ${id}";

  static String m38(company, date) => "Emitido por ${company} el ${date}";

  static String m39(name) => "Conectar ${name}";

  static String m40(name) => "${name} conectado";

  static String m41(hint) => "Conectado · ${hint}";

  static String m42(name) => "¿Desconectar ${name}?";

  static String m43(channel, date) =>
      "El último envío a ${channel} falló (${date}). Revisa la conexión y envía una prueba.";

  static String m44(name) => "Mensaje de prueba enviado a ${name}";

  static String m45(count) =>
      "${Intl.plural(count, zero: 'Comentar', one: '1 comentario', other: '${count} comentarios')}";

  static String m46(year) => "Desde ${year}";

  static String m47(company) =>
      "Los logros verificados que ${company} puede otorgar. Haz clic en una carta para editarla.";

  static String m48(company) =>
      "Cómo se ve y qué celebra ${company} en Scoreboard";

  static String m49(company) =>
      "Cómo fluye el reconocimiento en ${company}, y dónde se atasca.";

  static String m50(count) => "Solicitudes · ${count}";

  static String m51(name) => "De ${name}";

  static String m52(name) => "¿Eliminar ${name}?";

  static String m53(name) => "¿Eliminar ${name}?";

  static String m54(name) => "¿Eliminar «${name}»?";

  static String m55(email, password) =>
      "Cuenta de demostración: ${email} / ${password}";

  static String m56(id) => "ID ${id}";

  static String m57(template, colleague) =>
      "Ya enviaste «${template}» a ${colleague}.";

  static String m58(budget) =>
      "Ya has enviado los ${budget} logros de este mes. El presupuesto se renueva el día 1.";

  static String m59(min, max) =>
      "El valor debe estar entre ${min} y ${max} XP.";

  static String m60(values) => "Los logros básicos pueden valer ${values} XP.";

  static String m61(min) =>
      "La contraseña debe tener al menos ${min} caracteres.";

  static String m62(max) =>
      "Como máximo ${max} personas por importación: divide el archivo.";

  static String m63(company) =>
      "Firmada por ${company}: cualquiera puede comprobarla en su página pública.";

  static String m64(count) => "Todos · ${count}";

  static String m65(tier, count) => "${tier} · ${count}";

  static String m66(count) =>
      "${Intl.plural(count, one: 'Invitar a 1 persona', other: 'Invitar a ${count} personas')}";

  static String m67(created, skipped) =>
      "Invitaciones enviadas: ${created}. Excluidas: ${skipped}.";

  static String m68(count) =>
      "${Intl.plural(count, one: '1 línea excluida', other: '${count} líneas excluidas')}";

  static String m69(value) => "${value} ya aparece más arriba en el archivo";

  static String m70(value) => "“${value}” no es un email válido";

  static String m71(line, reason) => "Línea ${line}: ${reason}";

  static String m72(value) => "${value} ya tiene una cuenta";

  static String m73(value) => "ningún equipo se llama “${value}”";

  static String m74(count) =>
      "${Intl.plural(count, zero: 'Nadie a quien invitar', one: '1 persona recibirá una invitación', other: '${count} personas recibirán una invitación')}";

  static String m75(count) =>
      "${Intl.plural(count, one: '1 entrará directamente en su equipo.', other: '${count} entrarán directamente en su equipo.')}";

  static String m76(code) => "Código ${code}";

  static String m77(name, date) => "Invitado por ${name} · caduca el ${date}";

  static String m78(company) =>
      "Recibirá por correo un código para unirse a ${company}. El código es válido durante 7 días.";

  static String m79(email) => "¿Revocar la invitación de ${email}?";

  static String m80(email) => "Invitación enviada a ${email}";

  static String m81(email, code) =>
      "Modo demo, no se ha enviado ningún correo: dale a ${email} el código ${code}";

  static String m82(count) =>
      "${Intl.plural(count, one: 'Emitido a 1 persona', other: 'Emitido a ${count} personas')}";

  static String m83(count) =>
      "${Intl.plural(count, one: 'una vez', other: '${count} veces')}";

  static String m84(level, points) => "Nivel ${level} · ${points} XP";

  static String m85(level) => "Nivel ${level}";

  static String m86(count) => "Biblioteca · ${count}";

  static String m87(date) => "Miembro desde ${date}";

  static String m88(name) => "Equipo de ${name}";

  static String m89(count) =>
      "${Intl.plural(count, one: '1 miembro', other: '${count} miembros')}";

  static String m90(name) =>
      "Para ${name}. Un administrador revisará tu propuesta.";

  static String m91(achievement) =>
      "«${achievement}» se ha aprobado y ya está en tus logros";

  static String m92(actor, achievement, text) =>
      "${actor} ha comentado «${achievement}»: ${text}";

  static String m93(level) => "Has alcanzado el nivel ${level}";

  static String m94(actor, achievement) =>
      "${actor} ha solicitado «${achievement}»";

  static String m95(actor, achievement, member) =>
      "${actor} propone «${achievement}» para ${member}";

  static String m96(actor, achievement) =>
      "${actor} te ha enviado «${achievement}»";

  static String m97(actor, achievement) =>
      "${actor} ha reaccionado a «${achievement}»";

  static String m98(xp, rank) => "Esta semana: +${xp} XP · posición #${rank}";

  static String m99(xp) => "Esta semana: +${xp} XP";

  static String m100(achievement) => "«${achievement}» no se ha aprobado";

  static String m101(achievement, reason) =>
      "«${achievement}» no se ha aprobado: ${reason}";

  static String m102(company, achievement) =>
      "${company} te ha emitido «${achievement}»";

  static String m103(count) =>
      "${Intl.plural(count, zero: 'No hay notificaciones sin leer', one: '1 notificación sin leer', other: '${count} notificaciones sin leer')}";

  static String m104(shortcut) =>
      "Pulsa ${shortcut} para enviar un logro desde cualquier sitio, o usa el icono de la barra de menús.";

  static String m105(budget) =>
      "Los logros verificados vienen de tu empresa: puedes solicitarlos desde el catálogo. Los logros básicos se intercambian entre compañeros, hasta ${budget} al mes.";

  static String m106(min) => "Al menos ${min} caracteres";

  static String m107(percent) => "${percent} %";

  static String m108(rank) => "#${rank}";

  static String m109(reason) => "Motivo: ${reason}";

  static String m110(company) =>
      "Un administrador de ${company} revisará tu solicitud.";

  static String m111(name) => "Propuesto por ${name}";

  static String m112(role, company) => "${role} en ${company}";

  static String m113(days) =>
      "${Intl.plural(days, one: 'Queda 1 día', other: 'Quedan ${days} días')}";

  static String m114(start, end) => "${start} – ${end}";

  static String m115(rank, points) => "Vas #${rank} con ${points} XP";

  static String m116(name) => "Logro enviado a ${name}";

  static String m117(count) => "Enviados por ti · ${count}";

  static String m118(count) => "${count} enviados";

  static String m119(company) =>
      "Lo añade a Licencias y certificaciones, con ${company} como emisor.";

  static String m120(company) => "Emitido por ${company}";

  static String m121(sender, name, description) =>
      "🤝 ${sender} me ha reconocido con el logro «${name}».\n\n${description}\n\n#Scoreboard";

  static String m122(name, company, description) =>
      "🏆 Acabo de conseguir el logro «${name}», emitido por ${company}.\n\n${description}\n\n#Scoreboard";

  static String m123(provider) => "Continuar con ${provider}";

  static String m124(time) => "Último reconocimiento: ${time}";

  static String m125(received, sent) =>
      "${received} recibidos · ${sent} enviados en 90 días";

  static String m126(name) => "«${name}» añadido a la biblioteca";

  static String m127(name) => "«${name}» eliminado";

  static String m128(count) =>
      "${Intl.plural(count, one: 'Ayer', other: 'hace ${count} días')}";

  static String m129(count) => "hace ${count} h";

  static String m130(count) => "hace ${count} min";

  static String m131(version) => "Ya está disponible la versión ${version}";

  static String m132(count) => "${count} verificados";

  static String m133(version) => "Versión ${version}";

  static String m134(points, level) => "${points} XP para el nivel ${level}";

  static String m135(points) => "${points} XP";

  static String m136(name) => "${name} (tú)";

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
          "Las pruebas de todo tu esfuerzo",
        ),
        "achievementsTitle": MessageLookupByLibrary.simpleMessage("Tus logros"),
        "actionError": MessageLookupByLibrary.simpleMessage(
          "No ha funcionado. Inténtalo de nuevo.",
        ),
        "activityAchievementsIssued": m1,
        "activityAdminGranted": m2,
        "activityAdminRevoked": m3,
        "activityAnniversariesUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió los aniversarios laborales",
        ),
        "activityBrandUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió el color o el logo de la empresa",
        ),
        "activityCatalogArchived": m4,
        "activityCatalogCreated": m5,
        "activityCatalogRestored": m6,
        "activityCatalogUpdated": m7,
        "activityEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay actividad registrada.",
        ),
        "activityHint": MessageLookupByLibrary.simpleMessage(
          "Lo que han hecho administradores y responsables, de lo más reciente a lo más antiguo. No se puede modificar.",
        ),
        "activityIntegrationsUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió las integraciones",
        ),
        "activityInviteRevoked": m8,
        "activityMemberInvited": m9,
        "activityMemberMoved": m10,
        "activityMemberRemoved": m11,
        "activityMembersImported": m12,
        "activityNominationSubmitted": m13,
        "activityPersonalDataExported": m14,
        "activityPrivacyUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió los ajustes de privacidad",
        ),
        "activityReportAchievements": m15,
        "activityReportPeople": m16,
        "activityRequestApproved": m17,
        "activityRequestRejected": m18,
        "activitySeasonCreated": m19,
        "activitySeasonDeleted": m20,
        "activitySeasonUpdated": m21,
        "activitySsoUpdated": MessageLookupByLibrary.simpleMessage(
          "cambió el inicio de sesión único",
        ),
        "activityTeamCreated": m22,
        "activityTeamDeleted": m23,
        "activityTeamUpdated": m24,
        "adminBadge": m25,
        "adminGrantedMessage": m26,
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
        "adminRevokeSelfAction":
            MessageLookupByLibrary.simpleMessage("Renunciar"),
        "adminRevokeSelfBody": MessageLookupByLibrary.simpleMessage(
          "Saldrás de la consola y ya no podrás gestionar la empresa. Otro administrador podrá devolverte estos permisos.",
        ),
        "adminRevokeSelfTitle": MessageLookupByLibrary.simpleMessage(
          "¿Renunciar a tus permisos de administrador?",
        ),
        "adminRevokedMessage": m27,
        "adminRole": MessageLookupByLibrary.simpleMessage("Administrador"),
        "adminRoleTooltip": MessageLookupByLibrary.simpleMessage(
          "Puede usar la consola y gestionar la empresa",
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
        "anniversaryXp": m28,
        "anniversaryYears": m29,
        "appearanceSubtitle": MessageLookupByLibrary.simpleMessage(
          "Elige cómo se ve Scoreboard",
        ),
        "approve": MessageLookupByLibrary.simpleMessage("Aprobar"),
        "archive": MessageLookupByLibrary.simpleMessage("Archivar"),
        "archivedLabel": MessageLookupByLibrary.simpleMessage("Archivado"),
        "assignButton": m30,
        "assignNoteHint": MessageLookupByLibrary.simpleMessage(
          "Un mensaje para quienes lo reciben",
        ),
        "assignNoteLabel":
            MessageLookupByLibrary.simpleMessage("Nota (opcional)"),
        "authCreateCompanySubtitle": MessageLookupByLibrary.simpleMessage(
          "Configura Scoreboard para tu empresa. Serás su administrador.",
        ),
        "authCreateSubtitle": MessageLookupByLibrary.simpleMessage(
          "Únete al marcador de tu empresa.",
        ),
        "authCreateTitle":
            MessageLookupByLibrary.simpleMessage("Crea tu cuenta"),
        "authJoinSubtitle": MessageLookupByLibrary.simpleMessage(
          "Usa el código de la invitación que recibiste por correo.",
        ),
        "authOr": MessageLookupByLibrary.simpleMessage("o"),
        "authPitch": MessageLookupByLibrary.simpleMessage(
          "Reúne los logros que emite tu empresa y reconoce a los compañeros que marcan la diferencia.",
        ),
        "authSignInSubtitle": MessageLookupByLibrary.simpleMessage(
          "Tus trofeos te echaban de menos.",
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
        "baseExplanation": m31,
        "baseSubtitle": MessageLookupByLibrary.simpleMessage(
          "Pequeños agradecimientos, XP incluidos",
        ),
        "bioHint": MessageLookupByLibrary.simpleMessage(
          "Una línea sobre ti y lo que haces",
        ),
        "brandBody": m32,
        "brandColor": MessageLookupByLibrary.simpleMessage("Color"),
        "brandDefault":
            MessageLookupByLibrary.simpleMessage("Oro de Scoreboard"),
        "brandLogo": MessageLookupByLibrary.simpleMessage("Logo"),
        "brandPreview": MessageLookupByLibrary.simpleMessage("Vista previa"),
        "brandTitle": MessageLookupByLibrary.simpleMessage("Marca"),
        "budgetRemaining": m33,
        "cardBaseAchievement":
            MessageLookupByLibrary.simpleMessage("Logro básico"),
        "cardFlip": MessageLookupByLibrary.simpleMessage("Dar la vuelta"),
        "cardFrom": m34,
        "cardIssuedBy": MessageLookupByLibrary.simpleMessage("EMITIDO POR"),
        "cardIssuedOn": m35,
        "cardReceivedOn": m36,
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
        "certCredentialId": m37,
        "certHasEarned": MessageLookupByLibrary.simpleMessage(
          "ha conseguido el logro",
        ),
        "certIssuedBy": m38,
        "certPresentedTo":
            MessageLookupByLibrary.simpleMessage("Se certifica que"),
        "certTitle":
            MessageLookupByLibrary.simpleMessage("CERTIFICADO DE LOGRO"),
        "certVerify": MessageLookupByLibrary.simpleMessage(
          "Verifica este certificado",
        ),
        "changePassword": MessageLookupByLibrary.simpleMessage(
          "Cambiar contraseña",
        ),
        "chatBody": MessageLookupByLibrary.simpleMessage(
          "Cada reconocimiento aparece también en el canal que elijas, donde el equipo lo ve de verdad. Las notas personales se quedan en Scoreboard.",
        ),
        "chatConnect": MessageLookupByLibrary.simpleMessage("Conectar"),
        "chatConnectTitle": m39,
        "chatConnected": m40,
        "chatConnectedTo": m41,
        "chatDisconnect": MessageLookupByLibrary.simpleMessage("Desconectar"),
        "chatDisconnectBody": MessageLookupByLibrary.simpleMessage(
          "No llegarán más reconocimientos al canal. Puedes volver a conectarlo cuando quieras.",
        ),
        "chatDisconnectTitle": m42,
        "chatLanguage": MessageLookupByLibrary.simpleMessage(
          "Idioma de los mensajes",
        ),
        "chatLastError": m43,
        "chatNotConnected":
            MessageLookupByLibrary.simpleMessage("No conectado"),
        "chatPostPeer": MessageLookupByLibrary.simpleMessage(
          "Publicar también los de compañeros",
        ),
        "chatPostPeerHint": MessageLookupByLibrary.simpleMessage(
          "Más frecuentes: útiles en un canal propio, ruidosos en el general.",
        ),
        "chatPostVerified": MessageLookupByLibrary.simpleMessage(
          "Publicar los logros verificados",
        ),
        "chatSendTest":
            MessageLookupByLibrary.simpleMessage("Enviar una prueba"),
        "chatSlackHowTo": MessageLookupByLibrary.simpleMessage(
          "En Slack, crea una app en api.slack.com/apps, activa «Incoming Webhooks» y añade uno para el canal. Pega aquí la URL que empieza por https://hooks.slack.com.",
        ),
        "chatTeamsHowTo": MessageLookupByLibrary.simpleMessage(
          "En Teams, abre el canal, elige «Flujos de trabajo» y la plantilla «Publicar en un canal cuando se reciba una solicitud de webhook». Pega aquí la URL que te da.",
        ),
        "chatTestSent": m44,
        "chatTitle": MessageLookupByLibrary.simpleMessage("Teams y Slack"),
        "chatWebhookUrl":
            MessageLookupByLibrary.simpleMessage("URL del webhook"),
        "checkForUpdates": MessageLookupByLibrary.simpleMessage(
          "Buscar actualizaciones",
        ),
        "colleaguesTitle": MessageLookupByLibrary.simpleMessage("Compañeros"),
        "commentHint": MessageLookupByLibrary.simpleMessage(
          "Escribe un comentario…",
        ),
        "commentsCount": m45,
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
          "Todos, en todas partes, en un ranking. Sin presión.",
        ),
        "communityTitle": MessageLookupByLibrary.simpleMessage("Comunidad"),
        "companyCatalog": MessageLookupByLibrary.simpleMessage(
          "Catálogo de la empresa",
        ),
        "companyCatalogHint": MessageLookupByLibrary.simpleMessage(
          "Los logros verificados que puedes conseguir. Si crees que te mereces uno, solicítalo.",
        ),
        "companyIndustryLabel": MessageLookupByLibrary.simpleMessage(
          "Sector (opcional)",
        ),
        "companyLocationLabel": MessageLookupByLibrary.simpleMessage(
          "Ciudad (opcional)",
        ),
        "companyNameLabel": MessageLookupByLibrary.simpleMessage(
          "Nombre de la empresa",
        ),
        "companyNameRequired": MessageLookupByLibrary.simpleMessage(
          "Introduce el nombre de la empresa",
        ),
        "companySince": m46,
        "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
          "Confirma la nueva contraseña",
        ),
        "consoleActivity": MessageLookupByLibrary.simpleMessage(
          "Registro de actividad",
        ),
        "consoleAssign": MessageLookupByLibrary.simpleMessage("Asignar"),
        "consoleAssignSubtitle": MessageLookupByLibrary.simpleMessage(
          "Elige un logro, elige a las personas y alégrales el día.",
        ),
        "consoleCatalog": MessageLookupByLibrary.simpleMessage("Catálogo"),
        "consoleCatalogSubtitle": m47,
        "consoleCompany": MessageLookupByLibrary.simpleMessage("Empresa"),
        "consoleCompanySubtitle": m48,
        "consoleInsightsSubtitle": m49,
        "consoleIntegrations": MessageLookupByLibrary.simpleMessage(
          "Integraciones",
        ),
        "consoleIntegrationsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Scoreboard dentro de las herramientas que ya usáis: chat y cuentas de trabajo.",
        ),
        "consoleMembers": MessageLookupByLibrary.simpleMessage("Miembros"),
        "consoleReports": MessageLookupByLibrary.simpleMessage("Informes"),
        "consoleRequests": m50,
        "consoleRequestsSubtitle": MessageLookupByLibrary.simpleMessage(
          "Personas que piden un reconocimiento que creen haberse ganado. Tú decides.",
        ),
        "consoleSeasons": MessageLookupByLibrary.simpleMessage("Temporadas"),
        "consoleStats": MessageLookupByLibrary.simpleMessage("Estadísticas"),
        "consoleTeams": MessageLookupByLibrary.simpleMessage("Equipos"),
        "copyVerifyLink": MessageLookupByLibrary.simpleMessage(
          "Copiar el enlace de verificación",
        ),
        "createAccount": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
        "createDialogSubtitle": MessageLookupByLibrary.simpleMessage(
          "Cualquiera de tu empresa puede enviárselo a un compañero.",
        ),
        "createdBy": m51,
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
        "deleteSeasonTitle": m52,
        "deleteTeamBody": MessageLookupByLibrary.simpleMessage(
          "Sus miembros se quedarán sin equipo. Sus logros se conservan.",
        ),
        "deleteTeamTitle": m53,
        "deleteTemplateBody": MessageLookupByLibrary.simpleMessage(
          "Se quitará de la biblioteca. Los compañeros que ya lo recibieron conservan su logro.",
        ),
        "deleteTemplateTitle": m54,
        "demoAccount": m55,
        "descriptionHint": MessageLookupByLibrary.simpleMessage(
          "¿Qué hay que hacer para merecerlo?",
        ),
        "descriptionRequired": MessageLookupByLibrary.simpleMessage(
          "Añade una descripción breve",
        ),
        "detailCompany": MessageLookupByLibrary.simpleMessage("Empresa"),
        "detailEarnedOn": MessageLookupByLibrary.simpleMessage("Conseguido el"),
        "detailExperience": MessageLookupByLibrary.simpleMessage("Experiencia"),
        "detailId": m56,
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
        "errorAlreadyMember": MessageLookupByLibrary.simpleMessage(
          "Esta persona ya tiene una cuenta de Scoreboard.",
        ),
        "errorAlreadyOwned": MessageLookupByLibrary.simpleMessage(
          "Ya tienes este logro.",
        ),
        "errorAlreadySent": m57,
        "errorBudgetExhausted": m58,
        "errorCatalogPoints": m59,
        "errorCompanyNameTaken": MessageLookupByLibrary.simpleMessage(
          "Ya hay una empresa con este nombre en Scoreboard. Pide a uno de sus administradores que te invite.",
        ),
        "errorEmailNotSent": MessageLookupByLibrary.simpleMessage(
          "No se ha podido enviar el correo de invitación. Inténtalo más tarde.",
        ),
        "errorEmailTaken": MessageLookupByLibrary.simpleMessage(
          "Ya existe una cuenta con este correo.",
        ),
        "errorInvalidDates": MessageLookupByLibrary.simpleMessage(
          "La fecha de fin no puede ser anterior a la de inicio.",
        ),
        "errorInvalidInviteCode": MessageLookupByLibrary.simpleMessage(
          "El código no es válido para este correo o ha caducado. Pide una nueva invitación a un administrador.",
        ),
        "errorInvalidPoints": m60,
        "errorInvalidSsoDomain": MessageLookupByLibrary.simpleMessage(
          "No es un dominio válido, por ejemplo empresa.es.",
        ),
        "errorInvalidSsoTenant": MessageLookupByLibrary.simpleMessage(
          "No es un ID de inquilino de Microsoft: lo encontrarás en el portal de Entra, en Información general.",
        ),
        "errorInvalidWebhook": MessageLookupByLibrary.simpleMessage(
          "No es un webhook de Teams o Slack. Comprueba que has copiado la URL completa.",
        ),
        "errorLastAdmin": MessageLookupByLibrary.simpleMessage(
          "La empresa necesita al menos un administrador.",
        ),
        "errorMissingCredentials": MessageLookupByLibrary.simpleMessage(
          "Escribe tu correo y tu contraseña.",
        ),
        "errorMissingFields": MessageLookupByLibrary.simpleMessage(
          "Rellena todos los campos obligatorios.",
        ),
        "errorMissingNameOrRole": MessageLookupByLibrary.simpleMessage(
          "Escribe tu nombre y tu puesto.",
        ),
        "errorNeedsBackend": MessageLookupByLibrary.simpleMessage(
          "Disponible con el servidor de Scoreboard: esta demo no envía mensajes.",
        ),
        "errorNotAColleague": MessageLookupByLibrary.simpleMessage(
          "Solo puedes enviar logros a compañeros de tu empresa.",
        ),
        "errorNotAdmin": MessageLookupByLibrary.simpleMessage(
          "Solo los administradores de la empresa pueden hacerlo.",
        ),
        "errorNotConfigured": MessageLookupByLibrary.simpleMessage(
          "Este canal no está conectado.",
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
        "errorPasswordTooShort": m61,
        "errorRequestPending": MessageLookupByLibrary.simpleMessage(
          "Ya tienes una solicitud pendiente para este logro.",
        ),
        "errorSeasonOverlap": MessageLookupByLibrary.simpleMessage(
          "Estas fechas se solapan con otra temporada.",
        ),
        "errorSsoCancelled": MessageLookupByLibrary.simpleMessage(
          "Inicio de sesión cancelado.",
        ),
        "errorSsoFailed": MessageLookupByLibrary.simpleMessage(
          "No se ha podido entrar con tu cuenta de trabajo. Inténtalo de nuevo.",
        ),
        "errorSsoInUse": MessageLookupByLibrary.simpleMessage(
          "Otra empresa ya usa este acceso: un inquilino o dominio pertenece a una sola empresa.",
        ),
        "errorSsoNoAccount": MessageLookupByLibrary.simpleMessage(
          "Esta cuenta aún no está en Scoreboard: pide a un administrador de tu empresa que te invite.",
        ),
        "errorSsoNotConfigured": MessageLookupByLibrary.simpleMessage(
          "Tu empresa no ha activado el acceso con esta cuenta. Usa email y contraseña, o pregunta a tu administrador.",
        ),
        "errorTemplateNotFound": MessageLookupByLibrary.simpleMessage(
          "Este logro básico ya no existe.",
        ),
        "errorTooManyAttempts": MessageLookupByLibrary.simpleMessage(
          "Demasiados intentos con este correo. Vuelve a intentarlo dentro de unos minutos.",
        ),
        "errorTooManyInvites": m62,
        "errorWebhookFailed": MessageLookupByLibrary.simpleMessage(
          "El servicio rechazó el mensaje. Puede que el webhook se haya eliminado: vuelve a conectarlo.",
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
        "exportOpenBadgeSigned": MessageLookupByLibrary.simpleMessage(
          "Open Badge firmado",
        ),
        "exportOpenBadgeSignedHint": m63,
        "exportPdf": MessageLookupByLibrary.simpleMessage("Certificado PDF"),
        "exportSaved": MessageLookupByLibrary.simpleMessage("Archivo guardado"),
        "feedEarned": MessageLookupByLibrary.simpleMessage("ha conseguido"),
        "feedEmpty": MessageLookupByLibrary.simpleMessage(
          "Todo en calma. El próximo logro que alguien reciba romperá el silencio.",
        ),
        "feedSubtitle": MessageLookupByLibrary.simpleMessage(
          "Los logros de tus compañeros, al momento. Se agradecen los aplausos.",
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
        "filterAll": m64,
        "filterTier": m65,
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
        "importConfirm": m66,
        "importCsv": MessageLookupByLibrary.simpleMessage("Importar CSV"),
        "importDone": m67,
        "importEmpty": MessageLookupByLibrary.simpleMessage(
          "No hay direcciones de email en este archivo.",
        ),
        "importFormatHint": MessageLookupByLibrary.simpleMessage(
          "Una columna de emails, y si quieres rol y equipo. Coma o punto y coma, cabecera opcional: sirve una exportación de Excel.",
        ),
        "importLeftOut": m68,
        "importProblemDuplicate": m69,
        "importProblemInvalidEmail": m70,
        "importProblemLine": m71,
        "importProblemMember": m72,
        "importProblemTeam": m73,
        "importSummary": m74,
        "importTitle":
            MessageLookupByLibrary.simpleMessage("Importar personas"),
        "importWithTeams": m75,
        "individualRankingsBody": MessageLookupByLibrary.simpleMessage(
          "Podio, clasificación del equipo, puestos en el perfil y en las temporadas, clasificación de la Comunidad. Desactivadas, solo quedan los totales de la empresa.",
        ),
        "individualRankingsTitle": MessageLookupByLibrary.simpleMessage(
          "Clasificaciones individuales",
        ),
        "invalidEmail": MessageLookupByLibrary.simpleMessage(
          "Escribe una dirección de correo válida",
        ),
        "invalidUrl": MessageLookupByLibrary.simpleMessage(
          "Escribe un enlace http(s) válido",
        ),
        "inviteCodeChip": m76,
        "inviteCodeLabel": MessageLookupByLibrary.simpleMessage(
          "Código de invitación",
        ),
        "inviteCodeRequired": MessageLookupByLibrary.simpleMessage(
          "Introduce el código que recibiste",
        ),
        "inviteDetails": m77,
        "inviteDialogBody": m78,
        "inviteDialogTitle": MessageLookupByLibrary.simpleMessage(
          "Invitar a un compañero",
        ),
        "inviteEmailHint": MessageLookupByLibrary.simpleMessage(
          "El correo al que llegó la invitación",
        ),
        "inviteExpired": MessageLookupByLibrary.simpleMessage("Caducada"),
        "inviteMember": MessageLookupByLibrary.simpleMessage("Invitar"),
        "inviteResend": MessageLookupByLibrary.simpleMessage("Volver a enviar"),
        "inviteRevoke": MessageLookupByLibrary.simpleMessage("Revocar"),
        "inviteRevokeBody": MessageLookupByLibrary.simpleMessage(
          "El código dejará de funcionar. Podrás volver a invitar a esta persona más adelante.",
        ),
        "inviteRevokeTitle": m79,
        "inviteRevoked": MessageLookupByLibrary.simpleMessage(
          "Invitación revocada",
        ),
        "inviteSend": MessageLookupByLibrary.simpleMessage("Enviar invitación"),
        "inviteSent": m80,
        "inviteSentDemo": m81,
        "invitesEmpty": MessageLookupByLibrary.simpleMessage(
          "No hay invitaciones pendientes.",
        ),
        "issuedCount": m82,
        "issuedTimes": m83,
        "labelVerified": MessageLookupByLibrary.simpleMessage("Verificado"),
        "languageSystem": MessageLookupByLibrary.simpleMessage("Sistema"),
        "languageTitle": MessageLookupByLibrary.simpleMessage("Idioma"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("Clasificación"),
        "legendPeer": MessageLookupByLibrary.simpleMessage("Entre compañeros"),
        "levelAndXp": m84,
        "levelN": m85,
        "libraryCount": m86,
        "libraryEmpty": MessageLookupByLibrary.simpleMessage(
          "La biblioteca está vacía. Alguien tiene que empezar: ¿por qué no tú?",
        ),
        "loadError": MessageLookupByLibrary.simpleMessage(
          "Algo salió mal al cargar los datos.",
        ),
        "markAllRead": MessageLookupByLibrary.simpleMessage(
          "Marcar todo como leído",
        ),
        "memberSince": m87,
        "memberTeamLabel": m88,
        "membersCount": m89,
        "membersHint": MessageLookupByLibrary.simpleMessage(
          "Invita a personas a la empresa y elige quién puede gestionarla.",
        ),
        "membersWithoutTeam":
            MessageLookupByLibrary.simpleMessage("Sin equipo"),
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
          "Todavía nada en esta categoría. Dale tiempo.",
        ),
        "noAchievementsYet": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay logros.",
        ),
        "noManager": MessageLookupByLibrary.simpleMessage("Sin responsable"),
        "noSearchResults": MessageLookupByLibrary.simpleMessage(
          "Nada coincide. Prueba con menos letras, o con otra corazonada.",
        ),
        "noTeam": MessageLookupByLibrary.simpleMessage("Sin equipo"),
        "nominateDialogSubtitle": m90,
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
        "notifApprovedBody": m91,
        "notifApprovedTitle": MessageLookupByLibrary.simpleMessage(
          "Solicitud aprobada",
        ),
        "notifCommentBody": m92,
        "notifCommentTitle": MessageLookupByLibrary.simpleMessage(
          "Nuevo comentario",
        ),
        "notifLevelUpBody": m93,
        "notifLevelUpTitle": MessageLookupByLibrary.simpleMessage(
          "¡Subes de nivel!",
        ),
        "notifNewRequestBody": m94,
        "notifNewRequestTitle": MessageLookupByLibrary.simpleMessage(
          "Nueva solicitud",
        ),
        "notifNominationBody": m95,
        "notifNominationTitle": MessageLookupByLibrary.simpleMessage(
          "Nueva propuesta",
        ),
        "notifPeerBody": m96,
        "notifPeerTitle": MessageLookupByLibrary.simpleMessage("Nuevo logro"),
        "notifReactionBody": m97,
        "notifReactionTitle": MessageLookupByLibrary.simpleMessage(
          "Nueva reacción",
        ),
        "notifRecapBody": m98,
        "notifRecapBodyNoRank": m99,
        "notifRecapTitle": MessageLookupByLibrary.simpleMessage(
          "Tu resumen semanal",
        ),
        "notifRejectedBody": m100,
        "notifRejectedBodyReason": m101,
        "notifRejectedTitle": MessageLookupByLibrary.simpleMessage(
          "Solicitud rechazada",
        ),
        "notifVerifiedBody": m102,
        "notifVerifiedTitle": MessageLookupByLibrary.simpleMessage(
          "Logro verificado",
        ),
        "notificationsEmpty": MessageLookupByLibrary.simpleMessage(
          "Estás al día. Nada te necesita ahora mismo.",
        ),
        "notificationsOpen": MessageLookupByLibrary.simpleMessage(
          "Abrir notificaciones",
        ),
        "notificationsTitle": MessageLookupByLibrary.simpleMessage(
          "Notificaciones",
        ),
        "notificationsUnread": m103,
        "onboardingDone": MessageLookupByLibrary.simpleMessage("Empezar"),
        "onboardingFastBody": m104,
        "onboardingFastTitle":
            MessageLookupByLibrary.simpleMessage("Ve rápido"),
        "onboardingFeedBody": MessageLookupByLibrary.simpleMessage(
          "El muro muestra los logros de tus compañeros para que puedas reaccionar y comentar. Las notificaciones te avisan cuando algo te afecta.",
        ),
        "onboardingFeedTitle": MessageLookupByLibrary.simpleMessage(
          "Celebrad juntos",
        ),
        "onboardingKindsBody": m105,
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
        "passwordMinLength": m106,
        "passwordRequired": MessageLookupByLibrary.simpleMessage(
          "Escribe tu contraseña",
        ),
        "passwordSection": MessageLookupByLibrary.simpleMessage("Contraseña"),
        "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
          "Las contraseñas no coinciden",
        ),
        "pendingInvites": MessageLookupByLibrary.simpleMessage(
          "Invitaciones pendientes",
        ),
        "pendingSection": MessageLookupByLibrary.simpleMessage("Pendientes"),
        "percentValue": m107,
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
        "privacyBody": MessageLookupByLibrary.simpleMessage(
          "Lo que la app muestra de cada persona. Si un acuerdo con la representación de los trabajadores lo exige, desactiva estas opciones: se aplican a toda la empresa.",
        ),
        "privacyCommunitySubtitle": MessageLookupByLibrary.simpleMessage(
          "Tus compañeros te siguen viendo en la clasificación del equipo.",
        ),
        "privacyCommunityTitle": MessageLookupByLibrary.simpleMessage(
          "Mostrarme en la clasificación de la Comunidad",
        ),
        "privacySection": MessageLookupByLibrary.simpleMessage("Privacidad"),
        "privacyTitle": MessageLookupByLibrary.simpleMessage(
          "Privacidad y supervisión",
        ),
        "profileSaveError": MessageLookupByLibrary.simpleMessage(
          "No se pudo guardar tu perfil. Inténtalo de nuevo.",
        ),
        "profileUpdated": MessageLookupByLibrary.simpleMessage(
          "Perfil actualizado",
        ),
        "rankHidden": MessageLookupByLibrary.simpleMessage("Oculto"),
        "rankValue": m108,
        "reactionCelebrate": MessageLookupByLibrary.simpleMessage("Celebrar"),
        "reactionInsightful":
            MessageLookupByLibrary.simpleMessage("Interesante"),
        "reactionLike": MessageLookupByLibrary.simpleMessage("Me gusta"),
        "reactionLove": MessageLookupByLibrary.simpleMessage("Me encanta"),
        "recentAchievements": MessageLookupByLibrary.simpleMessage(
          "Logros recientes",
        ),
        "recognitionGapsBody": MessageLookupByLibrary.simpleMessage(
          "Para los responsables, quién no ha recibido nada en un mes; para los administradores, quién ha recibido menos en los últimos 90 días.",
        ),
        "recognitionGapsTitle": MessageLookupByLibrary.simpleMessage(
          "Señalar a quien recibe poco reconocimiento",
        ),
        "registerCreateCompany": MessageLookupByLibrary.simpleMessage(
          "Crear una empresa",
        ),
        "registerJoin": MessageLookupByLibrary.simpleMessage(
          "Unirse a una empresa",
        ),
        "reject": MessageLookupByLibrary.simpleMessage("Rechazar"),
        "rejectDialogTitle": MessageLookupByLibrary.simpleMessage(
          "¿Rechazar la solicitud?",
        ),
        "rejectReasonHint": MessageLookupByLibrary.simpleMessage(
          "Motivo (opcional)",
        ),
        "rejectionReason": m109,
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
        "requestDialogSubtitle": m110,
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
        "requestNominatedBy": m111,
        "requestRejectedMessage": MessageLookupByLibrary.simpleMessage(
          "Solicitud rechazada",
        ),
        "requestSent":
            MessageLookupByLibrary.simpleMessage("Solicitud enviada"),
        "requestsEmpty": MessageLookupByLibrary.simpleMessage(
          "Ninguna solicitud. O todo va de maravilla, o todos son muy modestos.",
        ),
        "restore": MessageLookupByLibrary.simpleMessage("Restaurar"),
        "roleAtCompany": m112,
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
        "seasonDaysLeft": m113,
        "seasonDeletedMessage": MessageLookupByLibrary.simpleMessage(
          "Temporada eliminada",
        ),
        "seasonEnded": MessageLookupByLibrary.simpleMessage("Terminada"),
        "seasonName": MessageLookupByLibrary.simpleMessage("Nombre"),
        "seasonNameHint":
            MessageLookupByLibrary.simpleMessage("p. ej. Otoño 2026"),
        "seasonRange": m114,
        "seasonSaved":
            MessageLookupByLibrary.simpleMessage("Temporada guardada"),
        "seasonUpcoming": MessageLookupByLibrary.simpleMessage("Próxima"),
        "seasonYourRank": m115,
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
          "Elige un logro y su carta aparecerá aquí, lista para enviar.",
        ),
        "sendSuccess": m116,
        "sentByYouCount": m117,
        "sentCount": m118,
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
        "shareAddToProfileHint": m119,
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
        "shareImageIssuedBy": m120,
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
        "sharePostPeer": m121,
        "sharePostVerified": m122,
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
        "ssoBody": MessageLookupByLibrary.simpleMessage(
          "Las personas entran con su cuenta de trabajo, sin otra contraseña. Solo cuenta el inquilino o dominio indicado aquí, y solo para miembros o personas invitadas.",
        ),
        "ssoBrowserDone": MessageLookupByLibrary.simpleMessage(
          "Has iniciado sesión. Puedes cerrar esta pestaña y volver a Scoreboard.",
        ),
        "ssoBrowserFailed": MessageLookupByLibrary.simpleMessage(
          "No se ha podido iniciar sesión. Vuelve a Scoreboard para ver por qué.",
        ),
        "ssoContinueWith": m123,
        "ssoGoogleDomain": MessageLookupByLibrary.simpleMessage(
          "Dominio de Google Workspace",
        ),
        "ssoGoogleDomainHint": MessageLookupByLibrary.simpleMessage(
          "El de las direcciones de trabajo, por ejemplo empresa.es. Déjalo vacío para no usar Google.",
        ),
        "ssoMicrosoftTenant": MessageLookupByLibrary.simpleMessage(
          "ID de inquilino de Microsoft Entra",
        ),
        "ssoMicrosoftTenantHint": MessageLookupByLibrary.simpleMessage(
          "En el portal de Entra, en Información general. Déjalo vacío para no usar Microsoft.",
        ),
        "ssoTitle":
            MessageLookupByLibrary.simpleMessage("Inicio de sesión único"),
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
        "teamLastRecognized": m124,
        "teamLeaderboard": MessageLookupByLibrary.simpleMessage(
          "Clasificación del equipo",
        ),
        "teamManager": MessageLookupByLibrary.simpleMessage("Responsable"),
        "teamMemberActivity": m125,
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
          "Quién recibe el reconocimiento, y quién merece más",
        ),
        "teamsEmpty": MessageLookupByLibrary.simpleMessage(
          "Todavía no hay equipos. Crea el primero.",
        ),
        "teamsHint": MessageLookupByLibrary.simpleMessage(
          "Cada equipo tiene un responsable, que ve cómo se reconoce a sus miembros y puede proponer logros verificados para ellos.",
        ),
        "templateAdded": m126,
        "templateCreateError": MessageLookupByLibrary.simpleMessage(
          "No se pudo crear el logro. Inténtalo de nuevo.",
        ),
        "templateDeleteError": MessageLookupByLibrary.simpleMessage(
          "No se pudo eliminar el logro. Inténtalo de nuevo.",
        ),
        "templateDeleted": m127,
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
        "timeDays": m128,
        "timeHours": m129,
        "timeJustNow": MessageLookupByLibrary.simpleMessage("Ahora mismo"),
        "timeMinutes": m130,
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
        "updateAvailableTitle": m131,
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
        "verifiedCount": m132,
        "verifyLinkCopied": MessageLookupByLibrary.simpleMessage(
          "Enlace de verificación copiado",
        ),
        "versionLabel": m133,
        "workEmail": MessageLookupByLibrary.simpleMessage("Correo del trabajo"),
        "xpToNextLevel": m134,
        "xpValue": m135,
        "youLabel": MessageLookupByLibrary.simpleMessage("(tú)"),
        "youSuffix": m136,
      };
}
