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

  static String m0(msg) => "${msg} Alle Rechte vorbehalten.";

  static String m1(msg) =>
      "Sind Sie sicher, dass Sie ${msg} aus der App möchten?";

  static String m2(msg) => "Fehler: ${msg}";

  static String m3(length) => "Muss mindestens ${length} Zeichen enthalten";

  static String m4(secondsRemaining) =>
      "Code erneut senden in 00:${secondsRemaining}";

  static String m5(length) => "Verwenden Sie mindestens ${length} Zeichen";

  static String m6(method) =>
      "bezahlt mit ${method}. Wir hoffen, Sie hatten eine tolle Fahrt! Bitte vergessen Sie nicht zu bewerten.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("Konto"),
    "activity": MessageLookupByLibrary.simpleMessage("Aktivität"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "Guthaben zu Ihrer Wallet hinzufügen",
    ),
    "add_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Gutscheincode hinzufügen",
    ),
    "add_new": MessageLookupByLibrary.simpleMessage("Neu hinzufügen"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage(
      "Zahlungsgateway hinzufügen",
    ),
    "add_wallet": MessageLookupByLibrary.simpleMessage("Wallet hinzufügen"),
    "affordableConvenient": MessageLookupByLibrary.simpleMessage(
      "Erschwinglich & bequem",
    ),
    "all_rights_reserved": m0,
    "allow": MessageLookupByLibrary.simpleMessage("Zulassen"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "Die App hat einen unerwarteten Fehler festgestellt und musste geschlossen werden. Dies kann durch unzureichenden Gerätespeicher, einen Fehler in der App oder eine beschädigte Datei verursacht werden. Bitte starten Sie die App neu oder installieren Sie sie erneut, falls das Problem weiterhin besteht.",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Anwenden"),
    "are_you_sure_msg": m1,
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Ungültiges Zertifikat beim API-Server",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("Ungültige Anfrage"),
    "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("Fahrt abbrechen"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage(
      "Teilen Sie uns den Grund für Ihre Stornierung mit.",
    ),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage("Fahrt stornieren"),
    "cancel_title": MessageLookupByLibrary.simpleMessage(
      "Sagen Sie uns, warum Sie die Fahrt stornieren",
    ),
    "card_number": MessageLookupByLibrary.simpleMessage("Kartennummer"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Name des Karteninhabers",
    ),
    "change_password": MessageLookupByLibrary.simpleMessage("Passwort ändern"),
    "choose_ride_title": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie eine passende Fahrt",
    ),
    "close": MessageLookupByLibrary.simpleMessage("SCHLIESSEN"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("Fahrt abschließen"),
    "confirm": MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "confirm_destination": MessageLookupByLibrary.simpleMessage(
      "Ziel bestätigen",
    ),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage(
      "Neues Passwort bestätigen",
    ),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Passwort bestätigen",
    ),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("Bezahlung bestätigen"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage(
      "Abholung bestätigen",
    ),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Verbindungsfehler mit dem API-Server",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Zeitüberschreitung bei der Verbindung mit dem API-Server",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage(
      "Support kontaktieren",
    ),
    "country": MessageLookupByLibrary.simpleMessage("Land"),
    "coupon_description": MessageLookupByLibrary.simpleMessage(
      "Geben Sie einen gültigen Gutscheincode ein, um Rabatte auf Ihre Fahrt zu erhalten.",
    ),
    "current_password": MessageLookupByLibrary.simpleMessage(
      "Aktuelles Passwort",
    ),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "delete": MessageLookupByLibrary.simpleMessage("Löschen"),
    "delete_account": MessageLookupByLibrary.simpleMessage("Konto löschen"),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "Sind Sie sicher, dass Sie Ihr Konto löschen möchten?",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "Diese Aktion ist dauerhaft und kann nicht rückgängig gemacht werden.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Zielort"),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "discount": MessageLookupByLibrary.simpleMessage("Rabatt"),
    "downloadReceipt": MessageLookupByLibrary.simpleMessage(
      "Beleg herunterladen",
    ),
    "drag_map_adjust_location": MessageLookupByLibrary.simpleMessage(
      "Karte ziehen, um den Standort anzupassen",
    ),
    "driver_arrived": MessageLookupByLibrary.simpleMessage(
      "Ihr Fahrer ist am Abholort angekommen. Bitte gehen Sie jetzt dorthin.",
    ),
    "driver_heading_to_you": MessageLookupByLibrary.simpleMessage(
      "Ihr Fahrer ist auf dem Weg zu Ihnen. Bitte seien Sie bereit.",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage(
          "Telefonnummer ist leer oder Passwort ist leer",
        ),
    "email": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "email_label": MessageLookupByLibrary.simpleMessage("E-Mail"),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "Gib deine Telefonnummer ein, um weiterzufahren und auf dem Laufenden zu bleiben.",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Telefonnummer eingeben",
    ),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage(
      "3-stellige CVV eingeben",
    ),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage(
      "Geben Sie einen gültigen Betrag ein",
    ),
    "enter_amount": MessageLookupByLibrary.simpleMessage("Betrag eingeben"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Name des Karteninhabers eingeben",
    ),
    "enter_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Gutscheincode eingeben",
    ),
    "enter_destination": MessageLookupByLibrary.simpleMessage(
      "Zielort eingeben",
    ),
    "enter_experience": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihre Erfahrung ein!",
    ),
    "enter_pickup_point": MessageLookupByLibrary.simpleMessage(
      "Abholort eingeben",
    ),
    "enter_stop_point": MessageLookupByLibrary.simpleMessage(
      "Zwischenstopp eingeben",
    ),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage(
      "Gültige Kartennummer eingeben",
    ),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("Geschätzte Zeit"),
    "exit": MessageLookupByLibrary.simpleMessage("Beenden"),
    "exp_date": MessageLookupByLibrary.simpleMessage("Ablaufdatum"),
    "fetching_address": MessageLookupByLibrary.simpleMessage(
      "Adresse wird abgerufen...",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "Dieses Feld ist erforderlich",
    ),
    "find_you_faster": MessageLookupByLibrary.simpleMessage(
      "Lassen Sie uns Sie schneller finden!",
    ),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "Standortzugriff aktivieren, um schnell Fahrer in der Nähe zu finden.",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "Zugriff verboten. Bitte erneut anmelden.",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage(
      "Formular ist ungültig",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Vollständiger Name"),
    "gender": MessageLookupByLibrary.simpleMessage("Geschlecht"),
    "gender_female": MessageLookupByLibrary.simpleMessage("Weiblich"),
    "gender_label": MessageLookupByLibrary.simpleMessage("Geschlecht"),
    "gender_male": MessageLookupByLibrary.simpleMessage("Männlich"),
    "gender_other": MessageLookupByLibrary.simpleMessage("Andere"),
    "gender_required": MessageLookupByLibrary.simpleMessage(
      "Geschlecht ist erforderlich",
    ),
    "gender_select": MessageLookupByLibrary.simpleMessage(
      "Geschlecht auswählen",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Loslegen"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage("Zurück zur Fahrt"),
    "grant_permission": MessageLookupByLibrary.simpleMessage(
      "Berechtigung erteilen",
    ),
    "helloText": MessageLookupByLibrary.simpleMessage("Hallo..."),
    "home": MessageLookupByLibrary.simpleMessage("Startseite"),
    "initializing": MessageLookupByLibrary.simpleMessage("Initialisierung..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage(
      "Bitte alle Daten eingeben",
    ),
    "inside_car": MessageLookupByLibrary.simpleMessage(
      "Sie befinden sich im Auto. Machen Sie es sich bequem.",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "Interner Serverfehler",
    ),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage(
      "Ihr Problem wurde erfolgreich eingereicht",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Sprache"),
    "letsGo": MessageLookupByLibrary.simpleMessage("Los geht\'s"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "Bitte aktivieren Sie den Standortzugriff, um diese Funktion zu nutzen.",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "Standortberechtigung erforderlich",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage(
      "Anmeldung auf einem anderen Gerät",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "loginSignup": MessageLookupByLibrary.simpleMessage(
      "Einloggen / Registrieren",
    ),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "Mit Ihrem Passwort anmelden",
    ),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("Handynummer"),
    "my_profile": MessageLookupByLibrary.simpleMessage("Mein Profil"),
    "name_label": MessageLookupByLibrary.simpleMessage("Name"),
    "new_password": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "no_address_found": MessageLookupByLibrary.simpleMessage(
      "Keine Adresse gefunden",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage("Noch keine Karten!"),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "Keine Internetverbindung.",
    ),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "Keine Internetverbindung. Bitte überprüfen Sie Ihre Internetverbindung.",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "Keine Zahlungsmethoden verfügbar",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage("Noch keine Fahrten."),
    "no_service_available": MessageLookupByLibrary.simpleMessage(
      "Kein Service verfügbar",
    ),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage(
      "Keine Wallet-Daten verfügbar",
    ),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage(
      "Oder wählen Sie einen Avatar aus der Liste unten:",
    ),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihr OTP ein",
    ),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihr OTP ein",
    ),
    "otp_resend": MessageLookupByLibrary.simpleMessage("Erneut senden"),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("Speichern"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "Wir haben einen OTP-Code an Ihre Telefonnummer gesendet",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("OTP"),
    "password_hint": MessageLookupByLibrary.simpleMessage(
      "Legen Sie ein sicheres Passwort fest",
    ),
    "password_label": MessageLookupByLibrary.simpleMessage("Passwort"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage(
      "Passwörter stimmen nicht überein.",
    ),
    "password_requirements": m5,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Zahlungsmethode"),
    "payment_completed": MessageLookupByLibrary.simpleMessage(
      "Vielen Dank! Zahlung abgeschlossen",
    ),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage("Zahlungsgateway"),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Die Telefonnummer muss mindestens 6 Ziffern enthalten",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("Telefonnummer"),
    "pick_a_date": MessageLookupByLibrary.simpleMessage("Datum auswählen"),
    "pickup": MessageLookupByLibrary.simpleMessage("Abholung"),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "Bitte wählen Sie eine Zahlungsart",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage("Bitte warten..."),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Datenschutzrichtlinie",
    ),
    "proceedNext": MessageLookupByLibrary.simpleMessage("Weiter"),
    "profile_info_description": MessageLookupByLibrary.simpleMessage(
      "Geben Sie Ihre Daten ein, um Ihr Profil zu vervollständigen und Ihre Erfahrung zu verbessern.",
    ),
    "profile_info_subtitle": MessageLookupByLibrary.simpleMessage(
      "Profilinformationen hinzufügen",
    ),
    "profile_info_title": MessageLookupByLibrary.simpleMessage(
      "Profilinformationen",
    ),
    "reason_changed_mind": MessageLookupByLibrary.simpleMessage(
      "Ich habe es mir anders überlegt.",
    ),
    "reason_driver_late": MessageLookupByLibrary.simpleMessage(
      "Der Fahrer braucht zu lange.",
    ),
    "reason_mismatch_info": MessageLookupByLibrary.simpleMessage(
      "Fahrer-/Fahrzeuginformationen stimmen nicht überein.",
    ),
    "reason_other": MessageLookupByLibrary.simpleMessage("Andere"),
    "reason_wrong_location": MessageLookupByLibrary.simpleMessage(
      "Falscher Abholort.",
    ),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Zeitüberschreitung beim Empfang vom API-Server",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage(
          "Ungültige Antwort vom Server erhalten.",
        ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("Problem melden"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "Teilen Sie uns mit, was passiert ist. Wir kümmern uns sofort darum.",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage(
      "Etwas ist schiefgelaufen? Melden Sie ein Problem",
    ),
    "reportType": MessageLookupByLibrary.simpleMessage("Berichtstyp"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage(
      "Anforderungsentität zu groß",
    ),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "Zeitüberschreitung der Anfrage. Bitte versuchen Sie es erneut.",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "Anfrage an API-Server wurde abgebrochen",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage(
      "Ressource nicht gefunden.",
    ),
    "rideBookingEase": MessageLookupByLibrary.simpleMessage(
      "Genießen Sie wettbewerbsfähige Preise, mehrere Fahrmöglichkeiten und eine nahtlose Buchung mit nur einem Fingertipp.",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("Fahrpreis"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("Fahrtdetails"),
    "rideFeatures": MessageLookupByLibrary.simpleMessage(
      "Echtzeitverfolgung, verifizierte Fahrer und sichere Zahlungen sorgen für eine sorgenfreie Fahrt.",
    ),
    "rideYourWay": MessageLookupByLibrary.simpleMessage(
      "Deine Fahrt, dein Weg",
    ),
    "ride_complete": MessageLookupByLibrary.simpleMessage(
      "Ihre Fahrt ist abgeschlossen",
    ),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "Wir hoffen, dass Ihre Fahrt reibungslos war. Bitte bezahlen Sie und bewerten Sie Ihre Erfahrung.",
    ),
    "ride_in_progress": MessageLookupByLibrary.simpleMessage(
      "Lehnen Sie sich zurück und entspannen Sie sich. Ihr Fahrer bringt Sie zu Ihrem Ziel.",
    ),
    "ride_on_the_way": MessageLookupByLibrary.simpleMessage(
      "Ihre Fahrt ist unterwegs",
    ),
    "ride_preferences": MessageLookupByLibrary.simpleMessage(
      "Fahrtpräferenzen",
    ),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie den Fahrttyp, der am besten zu Ihren Bedürfnissen passt.",
    ),
    "ride_ready": MessageLookupByLibrary.simpleMessage(
      "Ihre Fahrt ist bereit!",
    ),
    "ride_requested": MessageLookupByLibrary.simpleMessage("Fahrt angefordert"),
    "ride_started": MessageLookupByLibrary.simpleMessage(
      "Ihre Fahrt hat begonnen",
    ),
    "safeSecure": MessageLookupByLibrary.simpleMessage(
      "Sichere und geschützte Fahrten",
    ),
    "safetyPriority": MessageLookupByLibrary.simpleMessage(
      "Deine Sicherheit, unsere Priorität",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Speichern"),
    "search_destination": MessageLookupByLibrary.simpleMessage("Ziel suchen"),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage(
      "Suche nach einem verfügbaren Fahrer..",
    ),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage(
      "Wir hoffen, Sie bald wieder für Ihre nächste Fahrt zu sehen!",
    ),
    "selectReportType": MessageLookupByLibrary.simpleMessage(
      "Berichtstyp auswählen",
    ),
    "select_a_country": MessageLookupByLibrary.simpleMessage("Land auswählen"),
    "select_card_type": MessageLookupByLibrary.simpleMessage(
      "Kartentyp auswählen",
    ),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "Zahlungsmethode auswählen",
    ),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage(
      "Abholort auswählen",
    ),
    "select_profile_image": MessageLookupByLibrary.simpleMessage(
      "Profilbild auswählen",
    ),
    "select_service": MessageLookupByLibrary.simpleMessage(
      "Service auswählen!",
    ),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Zeitüberschreitung beim Senden an den API-Server",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage("Servicegebühr"),
    "services": MessageLookupByLibrary.simpleMessage("Dienstleistungen"),
    "share_experience": MessageLookupByLibrary.simpleMessage(
      "Teilen Sie Ihre Erfahrung!",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Überspringen"),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("Jetzt überspringen"),
    "smartRideSavings": MessageLookupByLibrary.simpleMessage(
      "Smarte Fahrten, smarte Ersparnisse.",
    ),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage(
      "Etwas ist schiefgelaufen",
    ),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "Etwas ist schiefgelaufen!",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Fahrt starten"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "Auf diesem Gerät bleiben",
    ),
    "stop_point": MessageLookupByLibrary.simpleMessage("Zwischenstopp"),
    "submit": MessageLookupByLibrary.simpleMessage("Absenden"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage(
      "Allgemeine Geschäftsbedingungen",
    ),
    "textCopied": MessageLookupByLibrary.simpleMessage("Text kopiert"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "Vielen Dank für Ihre Meldung. Unser Team wird Ihr Problem prüfen und sich bald mit Ihnen in Verbindung setzen.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Thema"),
    "today": MessageLookupByLibrary.simpleMessage("Heute"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage(
          "Laden Sie Ihre Wallet sicher auf und genießen Sie nahtlose Zahlungen.",
        ),
    "total_amount": MessageLookupByLibrary.simpleMessage("Gesamtbetrag"),
    "trips": MessageLookupByLibrary.simpleMessage("Fahrten"),
    "type_a_message": MessageLookupByLibrary.simpleMessage(
      "Nachricht eingeben",
    ),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage(
          "Unbefugter Zugriff. Bitte erneut anmelden.",
        ),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "Unerwarteter Anwendungsabsturz",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Ein unerwarteter Fehler ist aufgetreten",
    ),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "Unerwartetes Antwortformat",
    ),
    "upload_image": MessageLookupByLibrary.simpleMessage("Bild hochladen"),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage(
      "Verwenden Sie stattdessen OTP",
    ),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage(
      "Verwenden Sie hier Ihr Passwort",
    ),
    "validation_error": MessageLookupByLibrary.simpleMessage(
      "Validierungsfehler",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Details anzeigen"),
    "wait_message": MessageLookupByLibrary.simpleMessage(
      "Bitte warten Sie, während wir Sie mit dem nächstgelegenen verfügbaren Fahrer verbinden.",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Brieftasche"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage("Wallet-Guthaben"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Willkommen zurück!"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Mühelose Fahrten auf Knopfdruck. Erleben Sie jederzeit und überall schnelle, zuverlässige und sichere Transportmittel.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Willkommen bei Ready Ride",
    ),
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage(
      "Problemdetails eingeben",
    ),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "Ihr Konto ist bereits auf einem anderen Gerät aktiv. Um es hier zu verwenden, wird das andere Gerät abgemeldet.",
    ),
  };
}
