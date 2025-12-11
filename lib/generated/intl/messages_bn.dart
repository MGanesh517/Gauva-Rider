// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a bn locale. All the
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
  String get localeName => 'bn';

  static String m0(msg) => "${msg} সর্বস্বত্ব সংরক্ষিত।";

  static String m1(msg) => "আপনি কি নিশ্চিত আপনি অ্যাপ থেকে ${msg} করতে চান?";

  static String m2(msg) => "ত্রুটি: ${msg}";

  static String m3(length) => "অন্তত ${length} অক্ষরের হতে হবে";

  static String m4(secondsRemaining) =>
      "00:${secondsRemaining} সেকেন্ডে কোড পুনরায় পাঠান";

  static String m5(length) => "${length} অক্ষরের একটি পাসওয়ার্ড ব্যবহার করুন।";

  static String m6(method) =>
      "${method} মাধ্যমে পেমেন্ট হয়েছে। আশা করি রাইডটি ভালো হয়েছে! দয়া করে রেটিং দিতে ভুলবেন না।";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("অ্যাকাউন্ট"),
    "activity": MessageLookupByLibrary.simpleMessage("কার্যক্রম"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "আপনার ওয়ালেটে ব্যালেন্স যোগ করুন",
    ),
    "add_coupon_code": MessageLookupByLibrary.simpleMessage(
      "কুপন কোড যোগ করুন",
    ),
    "add_new": MessageLookupByLibrary.simpleMessage("নতুন যোগ করুন"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage(
      "পেমেন্ট গেটওয়ে যোগ করুন",
    ),
    "add_wallet": MessageLookupByLibrary.simpleMessage("ওয়ালেট যোগ করুন"),
    "affordableConvenient": MessageLookupByLibrary.simpleMessage(
      "সাশ্রয়ী ও সুবিধাজনক",
    ),
    "all_rights_reserved": m0,
    "allow": MessageLookupByLibrary.simpleMessage("অনুমতি দিন"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "অ্যাপটি একটি অপ্রত্যাশিত ত্রুটির সম্মুখীন হয়েছে এবং বন্ধ করতে হয়েছে। এটি হতে পারে ডিভাইসের মেমোরি কম থাকা, অ্যাপের বাগ, বা ক্ষতিগ্রস্ত ফাইলের কারণে। সমস্যা চলতে থাকলে অ্যাপটি রিস্টার্ট করুন অথবা পুনরায় ইনস্টল করুন।",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("প্রয়োগ করুন"),
    "are_you_sure_msg": m1,
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "API সার্ভারের সাথে খারাপ সার্টিফিকেট",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("ত্রুটিপূর্ণ অনুরোধ"),
    "cancel": MessageLookupByLibrary.simpleMessage("বাতিল করুন"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("রাইড বাতিল করুন"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage(
      "আপনার রাইড বাতিলের কারণ জানান।",
    ),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage("রাইড বাতিল করুন"),
    "cancel_title": MessageLookupByLibrary.simpleMessage(
      "আপনি রাইড বাতিল করছেন কেন জানান",
    ),
    "card_number": MessageLookupByLibrary.simpleMessage("কার্ড নম্বর"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage("কার্ডধারীর নাম"),
    "change_password": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড পরিবর্তন করুন",
    ),
    "choose_ride_title": MessageLookupByLibrary.simpleMessage(
      "আপনার জন্য উপযুক্ত রাইডটি বেছে নিন",
    ),
    "close": MessageLookupByLibrary.simpleMessage("বন্ধ করুন"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("রাইড সম্পন্ন করুন"),
    "confirm": MessageLookupByLibrary.simpleMessage("নিশ্চিত করুন"),
    "confirm_destination": MessageLookupByLibrary.simpleMessage(
      "গন্তব্য নিশ্চিত করুন",
    ),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage(
      "নতুন পাসওয়ার্ড নিশ্চিত করুন",
    ),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড নিশ্চিত করুন",
    ),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("পেমেন্ট নিশ্চিত করুন"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage(
      "পিকআপ নিশ্চিত করুন",
    ),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "API সার্ভারের সাথে সংযোগ ত্রুটি",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "API সার্ভারের সাথে সংযোগের সময় শেষ হয়েছে",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage(
      "সাপোর্টের সাথে যোগাযোগ করুন",
    ),
    "country": MessageLookupByLibrary.simpleMessage("দেশ"),
    "coupon_description": MessageLookupByLibrary.simpleMessage(
      "আপনার রাইডে ছাড় পেতে একটি বৈধ কুপন কোড দিন।",
    ),
    "current_password": MessageLookupByLibrary.simpleMessage(
      "বর্তমান পাসওয়ার্ড",
    ),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "delete": MessageLookupByLibrary.simpleMessage("মুছে ফেলুন"),
    "delete_account": MessageLookupByLibrary.simpleMessage(
      "অ্যাকাউন্ট মুছে ফেলুন",
    ),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "আপনি কি নিশ্চিত যে আপনার অ্যাকাউন্ট মুছে ফেলতে চান?",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "এই কাজটি স্থায়ী এবং পূর্বাবস্থায় ফেরানো যাবে না।",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("গন্তব্য"),
    "details": MessageLookupByLibrary.simpleMessage("বিস্তারিত"),
    "discount": MessageLookupByLibrary.simpleMessage("ডিসকাউন্ট"),
    "downloadReceipt": MessageLookupByLibrary.simpleMessage(
      "রসিদ ডাউনলোড করুন",
    ),
    "drag_map_adjust_location": MessageLookupByLibrary.simpleMessage(
      "অবস্থান সমন্বয়ের জন্য মানচিত্র টেনে আনুন",
    ),
    "driver_arrived": MessageLookupByLibrary.simpleMessage(
      "ড্রাইভার পিকআপ লোকেশনে পৌঁছে গেছেন। এখনই যান।",
    ),
    "driver_heading_to_you": MessageLookupByLibrary.simpleMessage(
      "ড্রাইভার আপনার লোকেশনের দিকে আসছেন। অনুগ্রহ করে প্রস্তুত থাকুন।",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage(
          "ফোন নম্বর খালি বা পাসওয়ার্ড ফাঁকা",
        ),
    "email": MessageLookupByLibrary.simpleMessage("ইমেইল"),
    "email_label": MessageLookupByLibrary.simpleMessage("ইমেইল"),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "আপনার রাইড চালিয়ে যেতে এবং আপডেট থাকতে আপনার ফোন নম্বর লিখুন।",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage("ফোন নম্বর লিখুন"),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage(
      "৩ সংখ্যার CVV লিখুন",
    ),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage(
      "একটি সঠিক পরিমাণ লিখুন",
    ),
    "enter_amount": MessageLookupByLibrary.simpleMessage("পরিমাণ লিখুন"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage("নাম লিখুন"),
    "enter_coupon_code": MessageLookupByLibrary.simpleMessage("কুপন কোড লিখুন"),
    "enter_destination": MessageLookupByLibrary.simpleMessage("গন্তব্য লিখুন"),
    "enter_experience": MessageLookupByLibrary.simpleMessage(
      "আপনার অভিজ্ঞতা লিখুন!",
    ),
    "enter_pickup_point": MessageLookupByLibrary.simpleMessage(
      "পিকআপ পয়েন্ট লিখুন",
    ),
    "enter_stop_point": MessageLookupByLibrary.simpleMessage(
      "স্টপ পয়েন্ট লিখুন",
    ),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage(
      "সঠিক কার্ড নম্বর লিখুন",
    ),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("আনুমানিক সময়"),
    "exit": MessageLookupByLibrary.simpleMessage("প্রস্থান"),
    "exp_date": MessageLookupByLibrary.simpleMessage("মেয়াদ শেষের তারিখ"),
    "fetching_address": MessageLookupByLibrary.simpleMessage(
      "ঠিকানা আনা হচ্ছে...",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "এই ঘরটি অবশ্যই পূরণ করতে হবে",
    ),
    "find_you_faster": MessageLookupByLibrary.simpleMessage(
      "চলুন আপনাকে দ্রুত খুঁজে নেই!",
    ),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "লোকেশন চালু করুন যাতে কাছাকাছি ড্রাইভারের সাথে সহজে ম্যাচ করা যায়।",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "নিষিদ্ধ প্রবেশ। দয়া করে আবার লগইন করুন।",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage("ফর্মটি বৈধ নয়"),
    "full_name": MessageLookupByLibrary.simpleMessage("পুরো নাম"),
    "gender": MessageLookupByLibrary.simpleMessage("লিঙ্গ"),
    "gender_female": MessageLookupByLibrary.simpleMessage("নারী"),
    "gender_label": MessageLookupByLibrary.simpleMessage("লিঙ্গ"),
    "gender_male": MessageLookupByLibrary.simpleMessage("পুরুষ"),
    "gender_other": MessageLookupByLibrary.simpleMessage("অন্যান্য"),
    "gender_required": MessageLookupByLibrary.simpleMessage("লিঙ্গ প্রয়োজন"),
    "gender_select": MessageLookupByLibrary.simpleMessage(
      "লিঙ্গ নির্বাচন করুন",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("শুরু করুন"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage("রাইডে ফিরে যান"),
    "grant_permission": MessageLookupByLibrary.simpleMessage("অনুমতি দিন"),
    "helloText": MessageLookupByLibrary.simpleMessage("হ্যালো..."),
    "home": MessageLookupByLibrary.simpleMessage("হোম"),
    "initializing": MessageLookupByLibrary.simpleMessage("আরম্ভ হচ্ছে..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage(
      "অনুগ্রহ করে সব তথ্য প্রদান করুন",
    ),
    "inside_car": MessageLookupByLibrary.simpleMessage(
      "আপনি গাড়িতে আছেন। আরামে বসুন।",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "সার্ভার অভ্যন্তরীণ ত্রুটি",
    ),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage(
      "আপনার সমস্যা সফলভাবে জমা হয়েছে",
    ),
    "language": MessageLookupByLibrary.simpleMessage("ভাষা"),
    "letsGo": MessageLookupByLibrary.simpleMessage("চলুন শুরু করি"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "এই ফিচারটি ব্যবহারের জন্য লোকেশন অ্যাক্সেস চালু করুন।",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "লোকেশন অনুমতি প্রয়োজন",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("লগ আউট"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage(
      "অন্য কোথাও লগইন করা হচ্ছে",
    ),
    "login": MessageLookupByLibrary.simpleMessage("লগইন"),
    "loginSignup": MessageLookupByLibrary.simpleMessage("লগইন / সাইন আপ"),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "আপনার পাসওয়ার্ড দিয়ে লগইন করুন",
    ),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("মোবাইল নম্বর"),
    "my_profile": MessageLookupByLibrary.simpleMessage("আমার প্রোফাইল"),
    "name_label": MessageLookupByLibrary.simpleMessage("নাম"),
    "new_password": MessageLookupByLibrary.simpleMessage("নতুন পাসওয়ার্ড"),
    "no_address_found": MessageLookupByLibrary.simpleMessage(
      "কোন ঠিকানা পাওয়া যায়নি",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage(
      "এখনও কোনও কার্ড নেই!",
    ),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "ইন্টারনেট সংযোগ নেই।",
    ),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "ইন্টারনেট সংযোগ নেই। অনুগ্রহ করে আপনার ইন্টারনেট সংযোগ পরীক্ষা করুন।",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "কোন পেমেন্ট পদ্ধতি পাওয়া যায়নি",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage("এখনও কোনও রাইড নেই।"),
    "no_service_available": MessageLookupByLibrary.simpleMessage(
      "কোনো পরিষেবা পাওয়া যায়নি",
    ),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage(
      "কোনও ওয়ালেট তথ্য পাওয়া যায়নি",
    ),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage(
      "অথবা নিচের তালিকা থেকে একটি অবতার নির্বাচন করুন:",
    ),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage(
      "আপনার ওটিপি লিখুন",
    ),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage("ওটিপি লিখুন"),
    "otp_resend": MessageLookupByLibrary.simpleMessage("পুনরায় পাঠান"),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("সংরক্ষণ করুন"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "আমরা আপনার ফোন নম্বরে একটি ওটিপি পাঠিয়েছি",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("ওটিপি"),
    "password_hint": MessageLookupByLibrary.simpleMessage(
      "একটি শক্তিশালী পাসওয়ার্ড সেট করুন",
    ),
    "password_label": MessageLookupByLibrary.simpleMessage("পাসওয়ার্ড"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage(
      "পাসওয়ার্ড মিলছে না।",
    ),
    "password_requirements": m5,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("পেমেন্ট পদ্ধতি"),
    "payment_completed": MessageLookupByLibrary.simpleMessage(
      "ধন্যবাদ! পেমেন্ট সম্পন্ন হয়েছে",
    ),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage("পেমেন্ট গেটওয়ে"),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "ফোন নম্বরে অন্তত ৬টি সংখ্যা থাকতে হবে",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("ফোন নম্বর"),
    "pick_a_date": MessageLookupByLibrary.simpleMessage(
      "একটি তারিখ নির্বাচন করুন",
    ),
    "pickup": MessageLookupByLibrary.simpleMessage("পিকআপ"),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "অনুগ্রহ করে পেমেন্ট টাইপ নির্বাচন করুন",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage(
      "অনুগ্রহ করে অপেক্ষা করুন...",
    ),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("প্রাইভেসি পলিসি"),
    "proceedNext": MessageLookupByLibrary.simpleMessage("পরবর্তী ধাপে যান"),
    "profile_info_description": MessageLookupByLibrary.simpleMessage(
      "আপনার প্রোফাইল সম্পূর্ণ করতে এবং অভিজ্ঞতা উন্নত করতে আপনার তথ্য লিখুন।",
    ),
    "profile_info_subtitle": MessageLookupByLibrary.simpleMessage(
      "প্রোফাইল তথ্য যুক্ত করুন",
    ),
    "profile_info_title": MessageLookupByLibrary.simpleMessage("প্রোফাইল তথ্য"),
    "reason_changed_mind": MessageLookupByLibrary.simpleMessage(
      "ভাবনা পরিবর্তন করেছি।",
    ),
    "reason_driver_late": MessageLookupByLibrary.simpleMessage(
      "ড্রাইভার দেরি করছে।",
    ),
    "reason_mismatch_info": MessageLookupByLibrary.simpleMessage(
      "ড্রাইভার/গাড়ির তথ্য মিলছে না।",
    ),
    "reason_other": MessageLookupByLibrary.simpleMessage("অন্যান্য"),
    "reason_wrong_location": MessageLookupByLibrary.simpleMessage(
      "ভুল পিকআপ লোকেশন।",
    ),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "API সার্ভার থেকে ডেটা গ্রহণের সময় শেষ হয়েছে",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage(
          "সার্ভার থেকে অবৈধ উত্তর পাওয়া গেছে।",
        ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("সমস্যা জানান"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "আমাদের জানান কী হয়েছে। আমরা দ্রুত সমাধান করব।",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage(
      "কোনো সমস্যা হয়েছে? সমস্যা রিপোর্ট করুন",
    ),
    "reportType": MessageLookupByLibrary.simpleMessage("রিপোর্টের ধরন"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage(
      "অনুরোধকৃত এককটি খুব বড়",
    ),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "অনুরোধের সময় শেষ হয়েছে। অনুগ্রহ করে আবার চেষ্টা করুন।",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "API সার্ভারে অনুরোধ বাতিল হয়েছে",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage(
      "সম্পদ পাওয়া যায়নি।",
    ),
    "rideBookingEase": MessageLookupByLibrary.simpleMessage(
      "প্রতিযোগিতামূলক ভাড়া, একাধিক রাইড অপশন এবং শুধু একটি ট্যাপে নির্বিঘ্ন বুকিং উপভোগ করুন।",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("যাত্রার চার্জ"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("যাত্রার বিস্তারিত"),
    "rideFeatures": MessageLookupByLibrary.simpleMessage(
      "রিয়েল-টাইম ট্র্যাকিং, যাচাইকৃত ড্রাইভার এবং নিরাপদ পেমেন্ট নিশ্চিত করে নিশ্চিন্ত রাইড অভিজ্ঞতা।",
    ),
    "rideYourWay": MessageLookupByLibrary.simpleMessage(
      "আপনার যাত্রা, আপনার মতো",
    ),
    "ride_complete": MessageLookupByLibrary.simpleMessage(
      "আপনার রাইড সম্পন্ন হয়েছে",
    ),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "আশা করি রাইডটি মসৃণ হয়েছে। অনুগ্রহ করে পেমেন্ট সম্পন্ন করুন এবং রেটিং দিন।",
    ),
    "ride_in_progress": MessageLookupByLibrary.simpleMessage(
      "আরামে বসে থাকুন। ড্রাইভার আপনাকে গন্তব্যে নিয়ে যাচ্ছেন।",
    ),
    "ride_on_the_way": MessageLookupByLibrary.simpleMessage("আপনার রাইড আসছে"),
    "ride_preferences": MessageLookupByLibrary.simpleMessage("রাইড পছন্দ"),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "আপনার প্রয়োজন অনুযায়ী রাইডের ধরন বেছে নিন।",
    ),
    "ride_ready": MessageLookupByLibrary.simpleMessage("আপনার রাইড প্রস্তুত!"),
    "ride_requested": MessageLookupByLibrary.simpleMessage(
      "রাইড অনুরোধ করা হয়েছে",
    ),
    "ride_started": MessageLookupByLibrary.simpleMessage(
      "আপনার রাইড শুরু হয়েছে",
    ),
    "safeSecure": MessageLookupByLibrary.simpleMessage(
      "নিরাপদ ও সুরক্ষিত রাইড",
    ),
    "safetyPriority": MessageLookupByLibrary.simpleMessage(
      "আপনার নিরাপত্তা, আমাদের অগ্রাধিকার",
    ),
    "save": MessageLookupByLibrary.simpleMessage("সংরক্ষণ করুন"),
    "search_destination": MessageLookupByLibrary.simpleMessage(
      "গন্তব্য অনুসন্ধান",
    ),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage(
      "অনলাইনে ড্রাইভার খোঁজা হচ্ছে..",
    ),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage(
      "পরবর্তী রাইডের জন্য আবার আপনাকে দেখতে চাই!",
    ),
    "selectReportType": MessageLookupByLibrary.simpleMessage(
      "রিপোর্টের ধরন নির্বাচন করুন",
    ),
    "select_a_country": MessageLookupByLibrary.simpleMessage(
      "একটি দেশ নির্বাচন করুন",
    ),
    "select_card_type": MessageLookupByLibrary.simpleMessage(
      "কার্ডের ধরন নির্বাচন করুন",
    ),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "পেমেন্ট পদ্ধতি নির্বাচন করুন",
    ),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage(
      "পিকআপ লোকেশন নির্বাচন করুন",
    ),
    "select_profile_image": MessageLookupByLibrary.simpleMessage(
      "প্রোফাইল ছবি নির্বাচন করুন",
    ),
    "select_service": MessageLookupByLibrary.simpleMessage(
      "একটি পরিষেবা নির্বাচন করুন!",
    ),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "API সার্ভারে ডেটা পাঠানোর সময় শেষ হয়েছে",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage("পরিষেবা চার্জ"),
    "services": MessageLookupByLibrary.simpleMessage("সেবা"),
    "share_experience": MessageLookupByLibrary.simpleMessage(
      "আপনার অভিজ্ঞতা শেয়ার করুন!",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("এড়িয়ে যান"),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("এখনই বাদ দিন"),
    "smartRideSavings": MessageLookupByLibrary.simpleMessage(
      "স্মার্ট রাইড, স্মার্ট সাশ্রয়।",
    ),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage(
      "কিছু ভুল হয়েছে",
    ),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "কিছু ভুল হয়েছে!",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("রাইড শুরু করুন"),
    "status": MessageLookupByLibrary.simpleMessage("অবস্থা"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "এই ডিভাইসে থাকুন",
    ),
    "stop_point": MessageLookupByLibrary.simpleMessage("স্টপ পয়েন্ট"),
    "submit": MessageLookupByLibrary.simpleMessage("জমা দিন"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage("শর্তাবলী"),
    "textCopied": MessageLookupByLibrary.simpleMessage("টেক্সট কপি হয়েছে"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "সমস্যা জানানোর জন্য ধন্যবাদ। আমাদের টিম দ্রুত আপনার সাথে যোগাযোগ করবে।",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("থিম"),
    "today": MessageLookupByLibrary.simpleMessage("আজ"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage(
          "নিরাপদে আপনার ওয়ালেট পূরণ করুন এবং নির্বিঘ্নে পেমেন্ট উপভোগ করুন।",
        ),
    "total_amount": MessageLookupByLibrary.simpleMessage("মোট পরিমাণ"),
    "trips": MessageLookupByLibrary.simpleMessage("ট্রিপসমূহ"),
    "type_a_message": MessageLookupByLibrary.simpleMessage("একটি বার্তা লিখুন"),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage(
          "অননুমোদিত প্রবেশ। দয়া করে আবার লগইন করুন।",
        ),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "অপ্রত্যাশিত অ্যাপ ক্র্যাশ",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "একটি অপ্রত্যাশিত ত্রুটি ঘটেছে",
    ),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "অপ্রত্যাশিত রেসপন্স ফরম্যাট",
    ),
    "upload_image": MessageLookupByLibrary.simpleMessage("ছবি আপলোড করুন"),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage(
      "তার পরিবর্তে ওটিপি ব্যবহার করুন",
    ),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage(
      "এখানে আপনার পাসওয়ার্ড ব্যবহার করুন",
    ),
    "validation_error": MessageLookupByLibrary.simpleMessage(
      "ভ্যালিডেশন ত্রুটি",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("বিস্তারিত দেখুন"),
    "wait_message": MessageLookupByLibrary.simpleMessage(
      "অনুগ্রহ করে অপেক্ষা করুন যতক্ষণ না আমরা আপনাকে নিকটতম উপলব্ধ ড্রাইভারের সাথে সংযুক্ত করব।",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("ওয়ালেট"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage("ওয়ালেট ব্যালেন্স"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage(
      "ফিরে আসার জন্য স্বাগতম!",
    ),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "আপনার আঙুলের ছোঁয়ায় সহজ রাইড। যেকোনো সময়, যেকোনো জায়গায় দ্রুত, নির্ভরযোগ্য এবং নিরাপদ যাত্রার অভিজ্ঞতা নিন।",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Ready Ride এ স্বাগতম",
    ),
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage(
      "সমস্যার বিস্তারিত লিখুন",
    ),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "আপনার অ্যাকাউন্ট ইতিমধ্যেই অন্য ডিভাইসে সক্রিয় আছে। এখানে ব্যবহার করতে চাইলে অন্য ডিভাইস থেকে লগআউট হয়ে যাবে।",
    ),
  };
}
