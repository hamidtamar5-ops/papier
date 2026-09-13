// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Vencimientos';

  @override
  String get settings => 'Ajustes';

  @override
  String get addDocument => 'Añadir un documento';

  @override
  String errorWithMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get noDocsForPerson => 'Ningún documento para esta persona.';

  @override
  String get sectionRenew => 'Por renovar';

  @override
  String get sectionWatch => 'Próximos';

  @override
  String get sectionOk => 'Al día';

  @override
  String get deleteConfirmTitle => '¿Eliminar?';

  @override
  String deleteDocumentBody(String label) {
    return 'Quitar «$label» de la lista.';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get nextDeadline => 'Próximo vencimiento';

  @override
  String get filterAll => 'Todos';

  @override
  String get emptyTitle => 'Aún no hay documentos';

  @override
  String get emptySubtitle =>
      'Añada una fecha (DNI, pasaporte, ITV, seguro…). No se pide ninguna foto.';

  @override
  String get statusOk => 'OK';

  @override
  String get statusSoon => 'Pronto';

  @override
  String get statusOverdue => 'Vencido';

  @override
  String get expiredYesterday => 'caducó ayer';

  @override
  String expiredDays(int count) {
    return 'caducó hace $count días';
  }

  @override
  String get expiresToday => 'caduca hoy';

  @override
  String get inOneDay => 'en 1 día';

  @override
  String inDays(int count) {
    return 'en $count días';
  }

  @override
  String get digestTitleRenew => 'Documentos por renovar';

  @override
  String get digestTitleToday => 'Vence hoy';

  @override
  String get digestTitleSoon => 'Vencimiento próximo';

  @override
  String digestBodyOneOverdue(String label) {
    return '$label está vencido.';
  }

  @override
  String digestBodyOneToday(String label) {
    return '$label caduca hoy.';
  }

  @override
  String digestBodyOneSoon(String label) {
    return '$label caduca en menos de 7 días.';
  }

  @override
  String get digestPartOneOverdue => '1 documento vencido';

  @override
  String digestPartManyOverdue(int count) {
    return '$count documentos vencidos';
  }

  @override
  String get digestPartOneToday => '1 hoy';

  @override
  String digestPartManyToday(int count) {
    return '$count hoy';
  }

  @override
  String get digestPartOneSoon => '1 en menos de 7 días';

  @override
  String digestPartManySoon(int count) {
    return '$count en menos de 7 días';
  }

  @override
  String get aDocument => 'Un documento';

  @override
  String get addPaper => 'Añadir un documento';

  @override
  String get edit => 'Editar';

  @override
  String get documentType => 'Tipo de documento';

  @override
  String get details => 'Detalles';

  @override
  String get labelField => 'Nombre';

  @override
  String get holder => 'Titular';

  @override
  String get computeFromStart => 'Calcular desde una fecha de inicio';

  @override
  String get startDate => 'Fecha de inicio';

  @override
  String get expirationDate => 'Fecha de caducidad';

  @override
  String get choose => 'Elegir';

  @override
  String get alertsAndReminders => 'Alertas y recordatorios';

  @override
  String get reminderHint =>
      'Notificación a las 9:00, más una alerta el día del vencimiento.';

  @override
  String get notes => 'Notas';

  @override
  String get notesHint => 'Notas (opcional, sin número de documento)';

  @override
  String get save => 'Guardar';

  @override
  String get chooseHolderAndDate => 'Elija un titular y una fecha.';

  @override
  String get kindCni => 'Documento de identidad';

  @override
  String get kindPasseport => 'Pasaporte';

  @override
  String get kindPermis => 'Permiso de conducir';

  @override
  String get kindCarteVitale => 'Tarjeta sanitaria';

  @override
  String get kindCarteGrise => 'Permiso de circulación';

  @override
  String get kindControleTechnique => 'Inspección técnica';

  @override
  String get kindAssuranceAuto => 'Seguro del coche';

  @override
  String get kindPersonnalise => 'Otro documento';

  @override
  String get hintCni =>
      'Introduzca la fecha de caducidad impresa en la tarjeta. Duración habitual: 10 años tras la emisión — compruebe siempre la tarjeta.';

  @override
  String get hintPasseport =>
      'Fecha de caducidad del pasaporte. Suele ser 10 años (adulto) o 5 años (menor).';

  @override
  String get hintPermis =>
      'Introduzca la fecha que figura en el título. No se inventa ninguna duración.';

  @override
  String get hintCarteVitale =>
      'Introduzca la fecha que desea vigilar, si la conoce.';

  @override
  String get hintCarteGrise =>
      'Introduzca la fecha a vigilar (sin escanear el certificado).';

  @override
  String get hintControleTechnique =>
      'Fecha de validez, o cálculo desde la última inspección (+2 años, o +4 años si el vehículo es nuevo).';

  @override
  String get hintAssuranceAuto =>
      'Fecha de vencimiento, o +1 año desde el inicio del contrato.';

  @override
  String get hintPersonnalise =>
      'Nombre libre y fecha. Sin foto, sin número de documento.';

  @override
  String get offset2Years => '+ 2 años (ya en circulación)';

  @override
  String get offset4Years => '+ 4 años (vehículo nuevo)';

  @override
  String get offset1Year => '+ 1 año';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Idioma del teléfono';

  @override
  String get languageFr => 'Français';

  @override
  String get languageEn => 'English';

  @override
  String get languageEs => 'Español';

  @override
  String get languageDe => 'Deutsch';

  @override
  String get languageAr => 'العربية';

  @override
  String get alertsAndNotifications => 'Alertas y notificaciones';

  @override
  String get householdHolders => 'Titulares del hogar';

  @override
  String get addHolder => 'Añadir un titular';

  @override
  String get iapNote =>
      'Hogar ilimitado y exportación PDF están previstos como compra única. En la v1, todo está abierto.';

  @override
  String get backup => 'Copia de seguridad';

  @override
  String get exportJson => 'Exportar JSON';

  @override
  String get exportJsonSubtitle => 'Archivo local, sin fotos.';

  @override
  String get importJson => 'Importar JSON';

  @override
  String get importDone => 'Importación terminada.';

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyText =>
      'Las fechas permanecen en este dispositivo. Sin cuenta, sin analítica, sin foto de documento. Esta app no es un servicio administrativo. Pueden mostrarse anuncios de Google AdMob; en el Espacio Económico Europeo se solicita su consentimiento.';

  @override
  String get privacyAdsTitle => 'Publicidad';

  @override
  String get privacyAdsBody =>
      'Puede aparecer un banner abajo en Inicio. Un intersticial solo se ofrece tras guardar, nunca al iniciar ni al salir.';

  @override
  String get manageAdsConsent => 'Gestionar el consentimiento publicitario';

  @override
  String get deleteHolderTitle => '¿Eliminar este titular?';

  @override
  String deleteHolderBody(String name) {
    return 'Se eliminarán «$name» y sus documentos.';
  }

  @override
  String get newHolder => 'Nuevo titular';

  @override
  String get firstName => 'Nombre';

  @override
  String get ok => 'OK';

  @override
  String get deviceAlerts => 'Alertas del dispositivo';

  @override
  String get deviceAlertsSubtitle =>
      'Recordatorios a las 9:00 y alerta el día del vencimiento.';

  @override
  String get notifsDisabled =>
      'Las notificaciones están desactivadas para esta aplicación.';

  @override
  String get allowAlerts => 'Permitir alertas';

  @override
  String get defaultReminders => 'Recordatorios predeterminados';

  @override
  String get testNotifSent => 'Notificación de prueba enviada.';

  @override
  String get sendTestNotif => 'Enviar una notificación de prueba';

  @override
  String notifExpiresToday(String date) {
    return 'Caduca hoy ($date).';
  }

  @override
  String notifDueInDays(int days, String date) {
    return 'Vence en $days días ($date).';
  }

  @override
  String get testNotifTitle => 'Alertas de vencimientos';

  @override
  String get testNotifBody =>
      'Las notificaciones funcionan. Se le avisará antes de cada fecha.';

  @override
  String get widgetNoDeadline => 'Sin vencimiento';

  @override
  String get widgetAddPaper => 'Añada un documento';

  @override
  String get deleteTooltip => 'Eliminar';
}
