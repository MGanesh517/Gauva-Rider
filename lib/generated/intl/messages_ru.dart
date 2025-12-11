// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(msg) => "${msg} Все права защищены.";

  static String m1(msg) => "Вы уверены, что хотите ${msg} из приложения?";

  static String m2(msg) => "Ошибка: ${msg}";

  static String m3(length) => "Должно быть не менее ${length} символов";

  static String m4(secondsRemaining) =>
      "Отправить код повторно через 00:${secondsRemaining}";

  static String m5(length) => "Используйте не менее ${length} символов";

  static String m6(method) =>
      "оплачено через ${method}. Надеемся, поездка вам понравилась! Не забудьте оставить отзыв.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "activity": MessageLookupByLibrary.simpleMessage("Активность"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "Добавьте баланс в ваш кошелек",
    ),
    "add_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Добавить промокод",
    ),
    "add_new": MessageLookupByLibrary.simpleMessage("Добавить новый"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage(
      "Добавить платежный шлюз",
    ),
    "add_wallet": MessageLookupByLibrary.simpleMessage("Добавить кошелек"),
    "affordableConvenient": MessageLookupByLibrary.simpleMessage(
      "Доступно и удобно",
    ),
    "all_rights_reserved": m0,
    "allow": MessageLookupByLibrary.simpleMessage("Разрешить"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "Приложение столкнулось с неожиданной ошибкой и было закрыто. Это могло произойти из-за недостаточной памяти устройства, ошибки в приложении или повреждённого файла. Пожалуйста, перезапустите приложение или переустановите его, если проблема продолжится.",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Применить"),
    "are_you_sure_msg": m1,
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Неверный сертификат с API-сервером",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("Неверный запрос"),
    "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("Отменить поездку"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage(
      "Сообщите нам причину отмены поездки.",
    ),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage("Отменить поездку"),
    "cancel_title": MessageLookupByLibrary.simpleMessage(
      "Сообщите, почему вы отменяете поездку",
    ),
    "card_number": MessageLookupByLibrary.simpleMessage("Номер карты"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Имя держателя карты",
    ),
    "change_password": MessageLookupByLibrary.simpleMessage("Сменить пароль"),
    "choose_ride_title": MessageLookupByLibrary.simpleMessage(
      "Выберите подходящую поездку",
    ),
    "close": MessageLookupByLibrary.simpleMessage("ЗАКРЫТЬ"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("Завершить поездку"),
    "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "confirm_destination": MessageLookupByLibrary.simpleMessage(
      "Подтвердить пункт назначения",
    ),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage(
      "Подтвердите новый пароль",
    ),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Подтвердите пароль",
    ),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("Подтвердить оплату"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage(
      "Подтвердить посадку",
    ),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Ошибка соединения с API-сервером",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Превышено время ожидания соединения с API-сервером",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage(
      "Связаться с поддержкой",
    ),
    "country": MessageLookupByLibrary.simpleMessage("Страна"),
    "coupon_description": MessageLookupByLibrary.simpleMessage(
      "Введите действительный промокод для получения скидки на поездку.",
    ),
    "current_password": MessageLookupByLibrary.simpleMessage("Текущий пароль"),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "delete_account": MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить свою учетную запись?",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "Это действие является окончательным и не может быть отменено.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Пункт назначения"),
    "details": MessageLookupByLibrary.simpleMessage("Детали"),
    "discount": MessageLookupByLibrary.simpleMessage("Скидка"),
    "downloadReceipt": MessageLookupByLibrary.simpleMessage(
      "Скачать квитанцию",
    ),
    "drag_map_adjust_location": MessageLookupByLibrary.simpleMessage(
      "Перетащите карту, чтобы отрегулировать местоположение",
    ),
    "driver_arrived": MessageLookupByLibrary.simpleMessage(
      "Водитель прибыл на место подачи. Пожалуйста, подойдите.",
    ),
    "driver_heading_to_you": MessageLookupByLibrary.simpleMessage(
      "Ваш водитель едет к вам. Пожалуйста, будьте готовы.",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage(
          "Номер телефона пустой или пароль пустой",
        ),
    "email": MessageLookupByLibrary.simpleMessage("Электронная почта"),
    "email_label": MessageLookupByLibrary.simpleMessage("Эл. почта"),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "Введите номер телефона, чтобы продолжить поездку и оставаться в курсе.",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Введите номер телефона",
    ),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage(
      "Введите 3-значный CVV",
    ),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage(
      "Введите допустимую сумму",
    ),
    "enter_amount": MessageLookupByLibrary.simpleMessage("Введите сумму"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage(
      "Введите имя держателя карты",
    ),
    "enter_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Введите промокод",
    ),
    "enter_destination": MessageLookupByLibrary.simpleMessage(
      "Введите пункт назначения",
    ),
    "enter_experience": MessageLookupByLibrary.simpleMessage(
      "Опишите ваш опыт!",
    ),
    "enter_pickup_point": MessageLookupByLibrary.simpleMessage(
      "Введите место посадки",
    ),
    "enter_stop_point": MessageLookupByLibrary.simpleMessage(
      "Введите точку остановки",
    ),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage(
      "Введите действительный номер карты",
    ),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("Примерное время"),
    "exit": MessageLookupByLibrary.simpleMessage("Выход"),
    "exp_date": MessageLookupByLibrary.simpleMessage("Срок действия"),
    "fetching_address": MessageLookupByLibrary.simpleMessage(
      "Получение адреса...",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "Это поле обязательно для заполнения",
    ),
    "find_you_faster": MessageLookupByLibrary.simpleMessage(
      "Давайте найдем вас быстрее!",
    ),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "Включите доступ к геолокации, чтобы быстро найти ближайших водителей.",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "Доступ запрещён. Пожалуйста, войдите снова.",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage(
      "Форма недействительна",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Полное имя"),
    "gender": MessageLookupByLibrary.simpleMessage("Пол"),
    "gender_female": MessageLookupByLibrary.simpleMessage("Женский"),
    "gender_label": MessageLookupByLibrary.simpleMessage("Пол"),
    "gender_male": MessageLookupByLibrary.simpleMessage("Мужской"),
    "gender_other": MessageLookupByLibrary.simpleMessage("Другой"),
    "gender_required": MessageLookupByLibrary.simpleMessage("Пол обязателен"),
    "gender_select": MessageLookupByLibrary.simpleMessage("Выберите пол"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Начать"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage(
      "Вернуться к поездке",
    ),
    "grant_permission": MessageLookupByLibrary.simpleMessage(
      "Предоставить доступ",
    ),
    "helloText": MessageLookupByLibrary.simpleMessage("Здравствуйте..."),
    "home": MessageLookupByLibrary.simpleMessage("Главная"),
    "initializing": MessageLookupByLibrary.simpleMessage("Инициализация..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите все данные",
    ),
    "inside_car": MessageLookupByLibrary.simpleMessage(
      "Вы находитесь в машине. Устройтесь поудобнее.",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "Внутренняя ошибка сервера",
    ),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage(
      "Ваша проблема успешно отправлена",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Язык"),
    "letsGo": MessageLookupByLibrary.simpleMessage("Поехали"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, включите доступ к местоположению для использования этой функции.",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "Требуется доступ к геолокации",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("Выйти"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage(
      "Вход с другого устройства",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Войти"),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "Войдите с помощью пароля",
    ),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "my_profile": MessageLookupByLibrary.simpleMessage("Мой профиль"),
    "name_label": MessageLookupByLibrary.simpleMessage("Имя"),
    "new_password": MessageLookupByLibrary.simpleMessage("Новый пароль"),
    "no_address_found": MessageLookupByLibrary.simpleMessage("Адрес не найден"),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage("Пока нет карт!"),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "Отсутствует интернет-соединение.",
    ),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "Отсутствует интернет-соединение. Пожалуйста, проверьте подключение.",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "Нет доступных способов оплаты",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage("Пока нет поездок."),
    "no_service_available": MessageLookupByLibrary.simpleMessage(
      "Сервис недоступен",
    ),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage(
      "Нет данных кошелька",
    ),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage(
      "Или выберите аватар из списка ниже:",
    ),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage("Введите ваш OTP"),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage("Введите OTP"),
    "otp_resend": MessageLookupByLibrary.simpleMessage("Отправить снова"),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "Мы отправили код OTP на ваш номер телефона",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("OTP"),
    "password_hint": MessageLookupByLibrary.simpleMessage(
      "Установите надёжный пароль",
    ),
    "password_label": MessageLookupByLibrary.simpleMessage("Пароль"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage(
      "Пароли не совпадают.",
    ),
    "password_requirements": m5,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Способ оплаты"),
    "payment_completed": MessageLookupByLibrary.simpleMessage(
      "Спасибо! Оплата завершена",
    ),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage("Платёжный шлюз"),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Номер телефона должен содержать не менее 6 цифр",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("Телефон"),
    "pick_a_date": MessageLookupByLibrary.simpleMessage("Выберите дату"),
    "pickup": MessageLookupByLibrary.simpleMessage("Место посадки"),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, выберите способ оплаты",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, подождите...",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "proceedNext": MessageLookupByLibrary.simpleMessage("Далее"),
    "profile_info_description": MessageLookupByLibrary.simpleMessage(
      "Введите свои данные, чтобы завершить профиль и улучшить взаимодействие.",
    ),
    "profile_info_subtitle": MessageLookupByLibrary.simpleMessage(
      "Добавить информацию профиля",
    ),
    "profile_info_title": MessageLookupByLibrary.simpleMessage(
      "Информация профиля",
    ),
    "reason_changed_mind": MessageLookupByLibrary.simpleMessage(
      "Я передумал(а).",
    ),
    "reason_driver_late": MessageLookupByLibrary.simpleMessage(
      "Водитель слишком долго едет.",
    ),
    "reason_mismatch_info": MessageLookupByLibrary.simpleMessage(
      "Информация о водителе/транспорте не совпадает.",
    ),
    "reason_other": MessageLookupByLibrary.simpleMessage("Другое"),
    "reason_wrong_location": MessageLookupByLibrary.simpleMessage(
      "Неправильное место посадки.",
    ),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Превышено время ожидания получения от API-сервера",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage(
          "Получен неверный ответ от сервера.",
        ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("Сообщить о проблеме"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "Расскажите нам, что пошло не так. Мы сразу же разберёмся.",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так? Сообщите о проблеме",
    ),
    "reportType": MessageLookupByLibrary.simpleMessage("Тип отчёта"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage(
      "Слишком большой объект запроса",
    ),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "Время запроса истекло. Пожалуйста, попробуйте снова.",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "Запрос к API-серверу был отменён",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage(
      "Ресурс не найден.",
    ),
    "rideBookingEase": MessageLookupByLibrary.simpleMessage(
      "Наслаждайтесь выгодными тарифами, разными вариантами поездок и удобным бронированием в одно касание.",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("Стоимость поездки"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("Детали поездки"),
    "rideFeatures": MessageLookupByLibrary.simpleMessage(
      "Отслеживание в реальном времени, проверенные водители и безопасные платежи обеспечивают спокойную поездку.",
    ),
    "rideYourWay": MessageLookupByLibrary.simpleMessage(
      "Ваша поездка — по вашему выбору",
    ),
    "ride_complete": MessageLookupByLibrary.simpleMessage("Поездка завершена"),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "Надеемся, поездка прошла гладко. Пожалуйста, оплатите и оцените поездку.",
    ),
    "ride_in_progress": MessageLookupByLibrary.simpleMessage(
      "Расслабьтесь. Водитель везет вас к месту назначения.",
    ),
    "ride_on_the_way": MessageLookupByLibrary.simpleMessage(
      "Ваша поездка в пути",
    ),
    "ride_preferences": MessageLookupByLibrary.simpleMessage(
      "Настройки поездки",
    ),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "Выберите тип поездки, который вам подходит.",
    ),
    "ride_ready": MessageLookupByLibrary.simpleMessage("Ваша поездка готова!"),
    "ride_requested": MessageLookupByLibrary.simpleMessage("Поездка запрошена"),
    "ride_started": MessageLookupByLibrary.simpleMessage("Поездка началась"),
    "safeSecure": MessageLookupByLibrary.simpleMessage(
      "Безопасные и надёжные поездки",
    ),
    "safetyPriority": MessageLookupByLibrary.simpleMessage(
      "Ваша безопасность — наш приоритет",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "search_destination": MessageLookupByLibrary.simpleMessage(
      "Поиск места назначения",
    ),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage(
      "Поиск доступного водителя..",
    ),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage(
      "Надеемся увидеть вас снова в следующей поездке!",
    ),
    "selectReportType": MessageLookupByLibrary.simpleMessage(
      "Выберите тип отчёта",
    ),
    "select_a_country": MessageLookupByLibrary.simpleMessage("Выберите страну"),
    "select_card_type": MessageLookupByLibrary.simpleMessage(
      "Выберите тип карты",
    ),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "Выберите способ оплаты",
    ),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage(
      "Выберите место посадки",
    ),
    "select_profile_image": MessageLookupByLibrary.simpleMessage(
      "Выберите изображение профиля",
    ),
    "select_service": MessageLookupByLibrary.simpleMessage("Выберите услугу!"),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Превышено время ожидания отправки на API-сервер",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage(
      "Плата за обслуживание",
    ),
    "services": MessageLookupByLibrary.simpleMessage("Услуги"),
    "share_experience": MessageLookupByLibrary.simpleMessage(
      "Поделитесь своим опытом!",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Пропустить"),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("Пропустить сейчас"),
    "smartRideSavings": MessageLookupByLibrary.simpleMessage(
      "Умные поездки, умные сбережения.",
    ),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так",
    ),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так!",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Начать поездку"),
    "status": MessageLookupByLibrary.simpleMessage("Статус"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "Остаться на этом устройстве",
    ),
    "stop_point": MessageLookupByLibrary.simpleMessage("Промежуточная точка"),
    "submit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage(
      "Условия и положения",
    ),
    "textCopied": MessageLookupByLibrary.simpleMessage("Текст скопирован"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "Спасибо за сообщение. Наша команда рассмотрит вашу проблему и свяжется с вами в ближайшее время.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Тема"),
    "today": MessageLookupByLibrary.simpleMessage("Сегодня"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage(
          "Пополните кошелек безопасно и наслаждайтесь беспроблемными платежами.",
        ),
    "total_amount": MessageLookupByLibrary.simpleMessage("Общая сумма"),
    "trips": MessageLookupByLibrary.simpleMessage("Поездки"),
    "type_a_message": MessageLookupByLibrary.simpleMessage("Введите сообщение"),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage(
          "Неавторизованный доступ. Пожалуйста, войдите снова.",
        ),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "Неожиданное завершение работы приложения",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "Произошла непредвиденная ошибка",
    ),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "Непредвиденный формат ответа",
    ),
    "upload_image": MessageLookupByLibrary.simpleMessage(
      "Загрузить изображение",
    ),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage(
      "Используйте OTP вместо этого",
    ),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage(
      "Используйте свой пароль здесь",
    ),
    "validation_error": MessageLookupByLibrary.simpleMessage(
      "Ошибка валидации",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Посмотреть детали"),
    "wait_message": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, подождите, пока мы соединим вас с ближайшим доступным водителем.",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Кошелек"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage("Баланс кошелька"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("С возвращением!"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Лёгкие поездки под рукой. Быстрый, надежный и безопасный транспорт в любое время и в любом месте.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Добро пожаловать в Ready Ride",
    ),
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage(
      "Опишите проблему",
    ),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "Ваша учетная запись уже активна на другом устройстве. Чтобы использовать её здесь, с другого устройства будет выполнен выход.",
    ),
  };
}
