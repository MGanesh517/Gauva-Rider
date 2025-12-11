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

  static String m0(msg) => "${msg} Todos los derechos reservados.";

  static String m1(msg) =>
      "¿Estás seguro de que quieres ${msg} de la aplicación?";

  static String m2(msg) => "Error: ${msg}";

  static String m3(length) => "Debe tener al menos ${length} caracteres";

  static String m4(secondsRemaining) =>
      "Reenviar código en 00:${secondsRemaining}";

  static String m5(length) => "Utilice al menos ${length} caracteres";

  static String m6(method) =>
      "pagado con ${method}. ¡Esperamos que hayas tenido un gran viaje! No olvides dejar una calificación.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("Cuenta"),
    "activity": MessageLookupByLibrary.simpleMessage("Actividad"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "Agrega saldo a tu billetera",
    ),
    "add_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Agregar código de cupón",
    ),
    "add_new": MessageLookupByLibrary.simpleMessage("Agregar nuevo"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage(
      "Agregar pasarela de pago",
    ),
    "add_wallet": MessageLookupByLibrary.simpleMessage(
      "Agregar a la billetera",
    ),
    "affordableConvenient": MessageLookupByLibrary.simpleMessage(
      "Asequible y conveniente",
    ),
    "all_rights_reserved": m0,
    "allow": MessageLookupByLibrary.simpleMessage("Permitir"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "La aplicación encontró un error inesperado y tuvo que cerrarse. Esto podría deberse a memoria insuficiente del dispositivo, un error en la aplicación o un archivo dañado. Por favor, reinicie la aplicación o vuelva a instalarla si el problema continúa.",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Aplicar"),
    "are_you_sure_msg": m1,
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Certificado inválido con el servidor API",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("Solicitud incorrecta"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("Cancelar viaje"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage(
      "Cuéntanos la razón por la que cancelaste tu viaje.",
    ),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage(
      "Cancelar el viaje",
    ),
    "cancel_title": MessageLookupByLibrary.simpleMessage(
      "Dinos por qué estás cancelando el viaje",
    ),
    "card_number": MessageLookupByLibrary.simpleMessage("Número de tarjeta"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Nombre del titular de la tarjeta",
    ),
    "change_password": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "choose_ride_title": MessageLookupByLibrary.simpleMessage(
      "Elige un viaje que se adapte a ti",
    ),
    "close": MessageLookupByLibrary.simpleMessage("CERRAR"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("Completar viaje"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirmar"),
    "confirm_destination": MessageLookupByLibrary.simpleMessage(
      "Confirmar destino",
    ),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage(
      "Confirmar nueva contraseña",
    ),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("Confirmar pago"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage(
      "Confirmar recogida",
    ),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Error de conexión con el servidor API",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Tiempo de conexión agotado con el servidor API",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage(
      "Contactar Soporte",
    ),
    "country": MessageLookupByLibrary.simpleMessage("País"),
    "coupon_description": MessageLookupByLibrary.simpleMessage(
      "Ingresa un código de cupón válido para aplicar descuentos a tu viaje.",
    ),
    "current_password": MessageLookupByLibrary.simpleMessage(
      "Contraseña actual",
    ),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
    "delete_account": MessageLookupByLibrary.simpleMessage("Eliminar cuenta"),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "¿Está seguro de que desea eliminar su cuenta?",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "Esta acción es permanente y no se puede deshacer.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destino"),
    "details": MessageLookupByLibrary.simpleMessage("Detalles"),
    "discount": MessageLookupByLibrary.simpleMessage("Descuento"),
    "downloadReceipt": MessageLookupByLibrary.simpleMessage("Descargar recibo"),
    "drag_map_adjust_location": MessageLookupByLibrary.simpleMessage(
      "Arrastra el mapa para ajustar la ubicación",
    ),
    "driver_arrived": MessageLookupByLibrary.simpleMessage(
      "Tu conductor ha llegado al punto de recogida. Dirígete allí ahora.",
    ),
    "driver_heading_to_you": MessageLookupByLibrary.simpleMessage(
      "Tu conductor se dirige a tu ubicación. Por favor, prepárate.",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage(
          "Número de teléfono vacío o contraseña vacía",
        ),
    "email": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "email_label": MessageLookupByLibrary.simpleMessage("Correo electrónico"),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "Ingresa tu número de teléfono para continuar tu viaje y mantenerte informado.",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Ingrese el número de teléfono",
    ),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage(
      "Ingrese el CVV de 3 dígitos",
    ),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage(
      "Ingrese un monto válido",
    ),
    "enter_amount": MessageLookupByLibrary.simpleMessage("Ingrese monto"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Ingrese el nombre del titular de la tarjeta",
    ),
    "enter_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Ingresa el código de cupón",
    ),
    "enter_destination": MessageLookupByLibrary.simpleMessage(
      "Ingrese destino",
    ),
    "enter_experience": MessageLookupByLibrary.simpleMessage(
      "¡Escribe tu experiencia!",
    ),
    "enter_pickup_point": MessageLookupByLibrary.simpleMessage(
      "Ingrese punto de recogida",
    ),
    "enter_stop_point": MessageLookupByLibrary.simpleMessage(
      "Ingrese punto de parada",
    ),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage(
      "Ingrese un número de tarjeta válido",
    ),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("Tiempo estimado"),
    "exit": MessageLookupByLibrary.simpleMessage("Salir"),
    "exp_date": MessageLookupByLibrary.simpleMessage("Fecha de expiración"),
    "fetching_address": MessageLookupByLibrary.simpleMessage(
      "Obteniendo dirección...",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "Este campo es obligatorio",
    ),
    "find_you_faster": MessageLookupByLibrary.simpleMessage(
      "¡Vamos a encontrarte más rápido!",
    ),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "Activa la ubicación para conectarte con conductores cercanos fácilmente.",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "Acceso prohibido. Por favor inicia sesión nuevamente.",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage(
      "El formulario no es válido",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Nombre completo"),
    "gender": MessageLookupByLibrary.simpleMessage("Género"),
    "gender_female": MessageLookupByLibrary.simpleMessage("Femenino"),
    "gender_label": MessageLookupByLibrary.simpleMessage("Género"),
    "gender_male": MessageLookupByLibrary.simpleMessage("Masculino"),
    "gender_other": MessageLookupByLibrary.simpleMessage("Otro"),
    "gender_required": MessageLookupByLibrary.simpleMessage(
      "El género es obligatorio",
    ),
    "gender_select": MessageLookupByLibrary.simpleMessage("Seleccionar género"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Empezar"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage("Volver al viaje"),
    "grant_permission": MessageLookupByLibrary.simpleMessage(
      "Conceder permiso",
    ),
    "helloText": MessageLookupByLibrary.simpleMessage("Hola..."),
    "home": MessageLookupByLibrary.simpleMessage("Inicio"),
    "initializing": MessageLookupByLibrary.simpleMessage("Inicializando..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage(
      "Por favor ingrese todos los datos",
    ),
    "inside_car": MessageLookupByLibrary.simpleMessage(
      "Estás dentro del coche. Siéntate cómodamente.",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "Error interno del servidor",
    ),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage(
      "Tu problema se envió con éxito",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "letsGo": MessageLookupByLibrary.simpleMessage("Vamos"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "Por favor, habilita el acceso a la ubicación para usar esta función.",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "Permiso de ubicación necesario",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage(
      "Iniciando sesión en otro lugar",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar sesión"),
    "loginSignup": MessageLookupByLibrary.simpleMessage(
      "Iniciar sesión / Registrarse",
    ),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "Iniciar sesión con su contraseña",
    ),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("Número de móvil"),
    "my_profile": MessageLookupByLibrary.simpleMessage("Mi perfil"),
    "name_label": MessageLookupByLibrary.simpleMessage("Nombre"),
    "new_password": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "no_address_found": MessageLookupByLibrary.simpleMessage(
      "No se encontró dirección",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "¡Aún no hay tarjetas!",
    ),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "Sin conexión a Internet.",
    ),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "Sin conexión a Internet. Por favor verifica tu conexión.",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "No hay métodos de pago disponibles",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage("Aún no hay viajes."),
    "no_service_available": MessageLookupByLibrary.simpleMessage(
      "No hay servicio disponible",
    ),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage(
      "No hay datos de la billetera disponibles",
    ),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage(
      "O seleccione un avatar de la lista a continuación:",
    ),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage("Introduce tu OTP"),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage("Escribe tu OTP"),
    "otp_resend": MessageLookupByLibrary.simpleMessage("Reenviar"),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("Guardar"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "Hemos enviado un código OTP a tu número de teléfono",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("OTP"),
    "password_hint": MessageLookupByLibrary.simpleMessage(
      "Establece una contraseña segura",
    ),
    "password_label": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden.",
    ),
    "password_requirements": m5,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Método de pago"),
    "payment_completed": MessageLookupByLibrary.simpleMessage(
      "¡Gracias! Pago completado",
    ),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage("Pasarela de pago"),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "El número de teléfono debe tener al menos 6 dígitos",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("Número de teléfono"),
    "pick_a_date": MessageLookupByLibrary.simpleMessage("Elija una fecha"),
    "pickup": MessageLookupByLibrary.simpleMessage("Recogida"),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "Por favor selecciona un tipo de pago",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage("Por favor espera..."),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad",
    ),
    "proceedNext": MessageLookupByLibrary.simpleMessage(
      "Proceder al siguiente",
    ),
    "profile_info_description": MessageLookupByLibrary.simpleMessage(
      "Ingresa tus datos para completar tu perfil y mejorar tu experiencia.",
    ),
    "profile_info_subtitle": MessageLookupByLibrary.simpleMessage(
      "Agregar información del perfil",
    ),
    "profile_info_title": MessageLookupByLibrary.simpleMessage(
      "Información del perfil",
    ),
    "reason_changed_mind": MessageLookupByLibrary.simpleMessage(
      "Cambié de opinión.",
    ),
    "reason_driver_late": MessageLookupByLibrary.simpleMessage(
      "El conductor está tardando demasiado.",
    ),
    "reason_mismatch_info": MessageLookupByLibrary.simpleMessage(
      "La información del conductor/vehículo no coincide.",
    ),
    "reason_other": MessageLookupByLibrary.simpleMessage("Otro"),
    "reason_wrong_location": MessageLookupByLibrary.simpleMessage(
      "Ubicación de recogida incorrecta.",
    ),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Tiempo de espera agotado al recibir datos del servidor API",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage(
          "Se recibió una respuesta inválida del servidor.",
        ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("Reportar un problema"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "Cuéntanos qué ocurrió. Lo revisaremos de inmediato.",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage(
      "¿Algo salió mal? Reporta un problema",
    ),
    "reportType": MessageLookupByLibrary.simpleMessage("Tipo de reporte"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage(
      "Entidad de solicitud demasiado grande",
    ),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "La solicitud expiró. Por favor intenta de nuevo.",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "Solicitud al servidor API fue cancelada",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage(
      "Recurso no encontrado.",
    ),
    "rideBookingEase": MessageLookupByLibrary.simpleMessage(
      "Disfruta de tarifas competitivas, múltiples opciones de viaje y una reserva perfecta con solo un toque.",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("Tarifa del viaje"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("Detalles del viaje"),
    "rideFeatures": MessageLookupByLibrary.simpleMessage(
      "Seguimiento en tiempo real, conductores verificados y pagos seguros garantizan una experiencia sin preocupaciones.",
    ),
    "rideYourWay": MessageLookupByLibrary.simpleMessage(
      "Tu viaje, a tu manera",
    ),
    "ride_complete": MessageLookupByLibrary.simpleMessage(
      "Tu viaje ha terminado",
    ),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "Esperamos que hayas tenido un buen viaje. Por favor, completa el pago y califica tu experiencia.",
    ),
    "ride_in_progress": MessageLookupByLibrary.simpleMessage(
      "Relájate. Tu conductor te lleva a tu destino.",
    ),
    "ride_on_the_way": MessageLookupByLibrary.simpleMessage(
      "Tu viaje está en camino",
    ),
    "ride_preferences": MessageLookupByLibrary.simpleMessage(
      "Preferencias de viaje",
    ),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "Selecciona el tipo de viaje que mejor se adapte a tus necesidades.",
    ),
    "ride_ready": MessageLookupByLibrary.simpleMessage("¡Tu viaje está listo!"),
    "ride_requested": MessageLookupByLibrary.simpleMessage("Viaje solicitado"),
    "ride_started": MessageLookupByLibrary.simpleMessage(
      "Tu viaje ha comenzado",
    ),
    "safeSecure": MessageLookupByLibrary.simpleMessage(
      "Viajes seguros y protegidos",
    ),
    "safetyPriority": MessageLookupByLibrary.simpleMessage(
      "Tu seguridad, nuestra prioridad",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Guardar"),
    "search_destination": MessageLookupByLibrary.simpleMessage(
      "Buscar destino",
    ),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage(
      "Buscando un conductor en línea..",
    ),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage(
      "¡Esperamos verte pronto en tu próximo viaje!",
    ),
    "selectReportType": MessageLookupByLibrary.simpleMessage(
      "Selecciona el tipo de reporte",
    ),
    "select_a_country": MessageLookupByLibrary.simpleMessage(
      "Seleccione un país",
    ),
    "select_card_type": MessageLookupByLibrary.simpleMessage(
      "Selecciona tipo de tarjeta",
    ),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "Seleccionar método de pago",
    ),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage(
      "Seleccionar lugar de recogida",
    ),
    "select_profile_image": MessageLookupByLibrary.simpleMessage(
      "Seleccionar imagen de perfil",
    ),
    "select_service": MessageLookupByLibrary.simpleMessage(
      "¡Selecciona un servicio!",
    ),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Tiempo de espera agotado al enviar datos al servidor API",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage(
      "Cargo por servicio",
    ),
    "services": MessageLookupByLibrary.simpleMessage("Servicios"),
    "share_experience": MessageLookupByLibrary.simpleMessage(
      "¡Comparte tu experiencia!",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Saltar"),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("Saltar por ahora"),
    "smartRideSavings": MessageLookupByLibrary.simpleMessage(
      "Viajes inteligentes, ahorros inteligentes.",
    ),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage(
      "Algo salió mal",
    ),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "¡Algo salió mal!",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Iniciar viaje"),
    "status": MessageLookupByLibrary.simpleMessage("Estado"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "Permanecer en este dispositivo",
    ),
    "stop_point": MessageLookupByLibrary.simpleMessage("Punto de parada"),
    "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage(
      "Términos y condiciones",
    ),
    "textCopied": MessageLookupByLibrary.simpleMessage("Texto copiado"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "Gracias por reportar. Nuestro equipo revisará tu problema y se pondrá en contacto contigo pronto.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "today": MessageLookupByLibrary.simpleMessage("Hoy"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage(
          "Recarga tu billetera de forma segura y disfruta de pagos sin interrupciones.",
        ),
    "total_amount": MessageLookupByLibrary.simpleMessage("Importe total"),
    "trips": MessageLookupByLibrary.simpleMessage("Viajes"),
    "type_a_message": MessageLookupByLibrary.simpleMessage(
      "Escribe un mensaje",
    ),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage(
          "Acceso no autorizado. Por favor inicia sesión nuevamente.",
        ),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "Fallo inesperado de la aplicación",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Ocurrió un error inesperado",
    ),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "Formato de respuesta inesperado",
    ),
    "upload_image": MessageLookupByLibrary.simpleMessage("Subir imagen"),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage(
      "Usar OTP en su lugar",
    ),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage(
      "Use su contraseña aquí",
    ),
    "validation_error": MessageLookupByLibrary.simpleMessage(
      "Error de validación",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Ver detalles"),
    "wait_message": MessageLookupByLibrary.simpleMessage(
      "Espere mientras lo conectamos con el conductor disponible más cercano.",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Billetera"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage(
      "Saldo de la billetera",
    ),
    "welcomeBack": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenido de nuevo!",
    ),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Viajes sin esfuerzo al alcance de tu mano. Experimenta un transporte rápido, confiable y seguro en cualquier momento y lugar.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Bienvenido a Ready Ride",
    ),
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage(
      "Escribe los detalles del problema",
    ),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "Su cuenta ya está activa en otro dispositivo. Para usarla aquí, se cerrará la sesión en el otro dispositivo.",
    ),
  };
}
