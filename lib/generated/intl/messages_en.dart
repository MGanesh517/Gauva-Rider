// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(msg) => "${msg} All rights reserved.";

  static String m1(msg) => "Are You Sure You Want to ${msg} from App";

  static String m2(msg) => "Error: ${msg}";

  static String m3(length) => "Must be at least ${length} characters";

  static String m4(secondsRemaining) => "Resend code in 00:${secondsRemaining}";

  static String m5(length) => "Use at least ${length} characters";

  static String m6(method) =>
      "paid via ${method}. We hope you had a great ride! Don\'t forget to leave a rating.";

  static String m7(msg) => "Write ${msg}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "activity": MessageLookupByLibrary.simpleMessage("Activity"),
    "add_balance_to_your_wallet": MessageLookupByLibrary.simpleMessage(
      "Add Balance to Your Wallet",
    ),
    "add_coupon_code": MessageLookupByLibrary.simpleMessage("Add Coupon Code"),
    "add_new": MessageLookupByLibrary.simpleMessage("Add New"),
    "add_payment_gateway": MessageLookupByLibrary.simpleMessage(
      "Add Payment Gateway",
    ),
    "add_wallet": MessageLookupByLibrary.simpleMessage("Add Wallet"),
    "affordableConvenient": MessageLookupByLibrary.simpleMessage(
      "Affordable & Convenient",
    ),
    "all_rights_reserved": m0,
    "allow": MessageLookupByLibrary.simpleMessage("Allow"),
    "app_encountered_unexpected_error": MessageLookupByLibrary.simpleMessage(
      "The app encountered an unexpected error and had to close. This could be caused by insufficient device memory, a bug in the app, or a corrupted file. Please restart the app or reinstall it if the issue continues.",
    ),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "are_you_sure_msg": m1,
    "bad_certificate_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Bad certificate with API server",
    ),
    "bad_request": MessageLookupByLibrary.simpleMessage("Bad request"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancel_ride": MessageLookupByLibrary.simpleMessage("Cancel Ride"),
    "cancel_subtitle": MessageLookupByLibrary.simpleMessage(
      "Let us know the reason for canceling your ride.",
    ),
    "cancel_the_ride": MessageLookupByLibrary.simpleMessage("Cancel the ride"),
    "cancel_title": MessageLookupByLibrary.simpleMessage(
      "Tell Us Why You\'re Cancelling The Ride",
    ),
    "card_number": MessageLookupByLibrary.simpleMessage("Card no"),
    "cardholder_name": MessageLookupByLibrary.simpleMessage("Cardholder Name"),
    "change_password": MessageLookupByLibrary.simpleMessage("Change Password"),
    "choose_ride_title": MessageLookupByLibrary.simpleMessage(
      "Choose a Ride That Suits You",
    ),
    "close": MessageLookupByLibrary.simpleMessage("CLOSE"),
    "complete_ride": MessageLookupByLibrary.simpleMessage("Complete Ride"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirm_destination": MessageLookupByLibrary.simpleMessage(
      "Confirm Destination",
    ),
    "confirm_new_password": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password",
    ),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "confirm_pay": MessageLookupByLibrary.simpleMessage("Confirm Pay"),
    "confirm_pickup": MessageLookupByLibrary.simpleMessage("Confirm Pick-up"),
    "connection_error_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Connection error with API server",
    ),
    "connection_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Connection timeout with API server",
    ),
    "contact_support": MessageLookupByLibrary.simpleMessage("Contact Support"),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "coupon_description": MessageLookupByLibrary.simpleMessage(
      "Enter a valid coupon code to apply discounts to your ride.",
    ),
    "current_password": MessageLookupByLibrary.simpleMessage(
      "Current Password",
    ),
    "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "delete_account": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "delete_account_confirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete your account?",
    ),
    "delete_account_warning": MessageLookupByLibrary.simpleMessage(
      "This action is permanent and cannot be undone.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destination"),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "discount": MessageLookupByLibrary.simpleMessage("Discount"),
    "downloadReceipt": MessageLookupByLibrary.simpleMessage("Download Receipt"),
    "drag_map_adjust_location": MessageLookupByLibrary.simpleMessage(
      "Drag The Map to Adjust The Location",
    ),
    "driver_arrived": MessageLookupByLibrary.simpleMessage(
      "Your driver has arrived at the pickup location. Please head over now.",
    ),
    "driver_heading_to_you": MessageLookupByLibrary.simpleMessage(
      "Your driver is heading to your location. Please be ready.",
    ),
    "either_phone_number_is_null_or_password_is_empty":
        MessageLookupByLibrary.simpleMessage(
          "Either phone number is null or password is empty",
        ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "email_label": MessageLookupByLibrary.simpleMessage("Email"),
    "enterPhoneDes": MessageLookupByLibrary.simpleMessage(
      "Enter your phone number to continue your ride and stay updated.",
    ),
    "enterPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Enter phone number",
    ),
    "enter_3_digit_cvv": MessageLookupByLibrary.simpleMessage(
      "Enter 3-digit CVV",
    ),
    "enter_a_valid_amount": MessageLookupByLibrary.simpleMessage(
      "Enter a valid amount",
    ),
    "enter_amount": MessageLookupByLibrary.simpleMessage("Enter Amount"),
    "enter_cardholder_name": MessageLookupByLibrary.simpleMessage("Enter name"),
    "enter_coupon_code": MessageLookupByLibrary.simpleMessage(
      "Enter Coupon Code",
    ),
    "enter_destination": MessageLookupByLibrary.simpleMessage(
      "Enter destination",
    ),
    "enter_experience": MessageLookupByLibrary.simpleMessage(
      "Enter your Experience!",
    ),
    "enter_pickup_point": MessageLookupByLibrary.simpleMessage(
      "Enter pick-up point",
    ),
    "enter_stop_point": MessageLookupByLibrary.simpleMessage(
      "Enter stop point",
    ),
    "enter_valid_card_number": MessageLookupByLibrary.simpleMessage(
      "Enter valid card number",
    ),
    "error_with_msg": m2,
    "estimated_time": MessageLookupByLibrary.simpleMessage("Estimated Time"),
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "exp_date": MessageLookupByLibrary.simpleMessage("Exp. Date"),
    "fetching_address": MessageLookupByLibrary.simpleMessage(
      "Fetching address...",
    ),
    "field_required": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "find_you_faster": MessageLookupByLibrary.simpleMessage(
      "Let’s Find You Faster!",
    ),
    "find_you_faster_msg": MessageLookupByLibrary.simpleMessage(
      "Enable location access to get matched with nearby drivers quickly and easily.",
    ),
    "forbidden_access_please_login_again": MessageLookupByLibrary.simpleMessage(
      "Forbidden access. Please login again.",
    ),
    "form_is_not_valid": MessageLookupByLibrary.simpleMessage(
      "Form is not valid",
    ),
    "full_name": MessageLookupByLibrary.simpleMessage("Full Name"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "gender_female": MessageLookupByLibrary.simpleMessage("Female"),
    "gender_label": MessageLookupByLibrary.simpleMessage("Gender"),
    "gender_male": MessageLookupByLibrary.simpleMessage("Male"),
    "gender_other": MessageLookupByLibrary.simpleMessage("Other"),
    "gender_required": MessageLookupByLibrary.simpleMessage(
      "Gender is required",
    ),
    "gender_select": MessageLookupByLibrary.simpleMessage("Select Gender"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "go_back_to_ride": MessageLookupByLibrary.simpleMessage("Go back to ride"),
    "grant_permission": MessageLookupByLibrary.simpleMessage(
      "Grant Permission",
    ),
    "helloText": MessageLookupByLibrary.simpleMessage("Hello..."),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "initializing": MessageLookupByLibrary.simpleMessage("Initializing..."),
    "insertAllData": MessageLookupByLibrary.simpleMessage(
      "Please insert all Data",
    ),
    "inside_car": MessageLookupByLibrary.simpleMessage(
      "You are inside the car. Seat comfortably",
    ),
    "internal_server_error": MessageLookupByLibrary.simpleMessage(
      "Internal server error",
    ),
    "issueSubmitted": MessageLookupByLibrary.simpleMessage(
      "Your Issue Submitted Successfully",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "letsGo": MessageLookupByLibrary.simpleMessage("Let\'s Go"),
    "location_permission_msg": MessageLookupByLibrary.simpleMessage(
      "Please enable location access to use this feature.",
    ),
    "location_permission_needed": MessageLookupByLibrary.simpleMessage(
      "Location Permission Needed",
    ),
    "log_out": MessageLookupByLibrary.simpleMessage("Log Out"),
    "loggingInSomewhereElse": MessageLookupByLibrary.simpleMessage(
      "Logging in Somewhere Else",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginSignup": MessageLookupByLibrary.simpleMessage("Log in / Sign up"),
    "login_with_your_password": MessageLookupByLibrary.simpleMessage(
      "Login with your Password",
    ),
    "min_length_error": m3,
    "mobile_number": MessageLookupByLibrary.simpleMessage("Mobile Number"),
    "my_profile": MessageLookupByLibrary.simpleMessage("My Profile"),
    "name_label": MessageLookupByLibrary.simpleMessage("Name"),
    "new_password": MessageLookupByLibrary.simpleMessage("New Password"),
    "no_address_found": MessageLookupByLibrary.simpleMessage(
      "No address found",
    ),
    "no_cards_yet": MessageLookupByLibrary.simpleMessage("No Cards yet!"),
    "no_internet_connection": MessageLookupByLibrary.simpleMessage(
      "No internet connection.",
    ),
    "no_internet_connection_please_check": MessageLookupByLibrary.simpleMessage(
      "No internet connection. Please check your internet connection.",
    ),
    "no_payment_methods_available": MessageLookupByLibrary.simpleMessage(
      "No Payment methods available",
    ),
    "no_rides_yet": MessageLookupByLibrary.simpleMessage("No rides yet."),
    "no_service_available": MessageLookupByLibrary.simpleMessage(
      "No Service Available",
    ),
    "no_wallet_data_available": MessageLookupByLibrary.simpleMessage(
      "No wallet data available",
    ),
    "or_select_avatar": MessageLookupByLibrary.simpleMessage(
      "Or select an avatar from the list below:",
    ),
    "otp_enter_title": MessageLookupByLibrary.simpleMessage("Enter Your OTP"),
    "otp_input_hint": MessageLookupByLibrary.simpleMessage("Write Your OTP"),
    "otp_resend": MessageLookupByLibrary.simpleMessage("Resend"),
    "otp_resend_timer": m4,
    "otp_save_button": MessageLookupByLibrary.simpleMessage("Save"),
    "otp_sent_message": MessageLookupByLibrary.simpleMessage(
      "We sent OTP code to your phone number",
    ),
    "otp_title_short": MessageLookupByLibrary.simpleMessage("OTP"),
    "password_hint": MessageLookupByLibrary.simpleMessage(
      "Set a Strong Password",
    ),
    "password_label": MessageLookupByLibrary.simpleMessage("Password"),
    "password_mismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match.",
    ),
    "password_requirements": m5,
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
    "payment_completed": MessageLookupByLibrary.simpleMessage(
      "Thank You! Payment Completed",
    ),
    "payment_confirmation": m6,
    "payment_gateway": MessageLookupByLibrary.simpleMessage("Payment Gateway"),
    "phoneMinLengthError": MessageLookupByLibrary.simpleMessage(
      "Phone number must be at least 6 digits",
    ),
    "phoneNo": MessageLookupByLibrary.simpleMessage("Phone No"),
    "pick_a_date": MessageLookupByLibrary.simpleMessage("Pick a date"),
    "pickup": MessageLookupByLibrary.simpleMessage("Pick-up"),
    "please_select_payment_type": MessageLookupByLibrary.simpleMessage(
      "Please Select Payment Type",
    ),
    "please_wait": MessageLookupByLibrary.simpleMessage("Please wait..."),
    "privacy_policy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "proceedNext": MessageLookupByLibrary.simpleMessage("Proceed Next"),
    "profile_info_description": MessageLookupByLibrary.simpleMessage(
      "Enter your details to complete your profile and enhance your experience.",
    ),
    "profile_info_subtitle": MessageLookupByLibrary.simpleMessage(
      "Add Profile Info",
    ),
    "profile_info_title": MessageLookupByLibrary.simpleMessage("Profile Info"),
    "reason_changed_mind": MessageLookupByLibrary.simpleMessage(
      "Changed my mind.",
    ),
    "reason_driver_late": MessageLookupByLibrary.simpleMessage(
      "Driver is taking too long.",
    ),
    "reason_mismatch_info": MessageLookupByLibrary.simpleMessage(
      "Driver/vehicle info didn\'t match.",
    ),
    "reason_other": MessageLookupByLibrary.simpleMessage("Other"),
    "reason_wrong_location": MessageLookupByLibrary.simpleMessage(
      "Wrong pickup location.",
    ),
    "receive_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Receive timeout with API server",
    ),
    "received_invalid_response_from_server":
        MessageLookupByLibrary.simpleMessage(
          "Received an invalid response from the server.",
        ),
    "reportIssue": MessageLookupByLibrary.simpleMessage("Report Issue"),
    "reportIssueSubtitle": MessageLookupByLibrary.simpleMessage(
      "Tell us what went wrong. We’ll look into it immediately.",
    ),
    "reportIssueTitle": MessageLookupByLibrary.simpleMessage(
      "Something Went Wrong? Report an Issue",
    ),
    "reportType": MessageLookupByLibrary.simpleMessage("Report Type"),
    "requestEntityTooLarge": MessageLookupByLibrary.simpleMessage(
      "Request Entity Too Large",
    ),
    "request_timed_out_please_try_again": MessageLookupByLibrary.simpleMessage(
      "Request timed out. Please try again.",
    ),
    "request_to_api_server_was_cancelled": MessageLookupByLibrary.simpleMessage(
      "Request to API server was cancelled",
    ),
    "resource_not_found": MessageLookupByLibrary.simpleMessage(
      "Resource not found.",
    ),
    "rideBookingEase": MessageLookupByLibrary.simpleMessage(
      "Enjoy competitive fares, multiple ride options, and seamless booking with just a tap.",
    ),
    "rideCharge": MessageLookupByLibrary.simpleMessage("Ride Charge"),
    "rideDetails": MessageLookupByLibrary.simpleMessage("Ride Details"),
    "rideFeatures": MessageLookupByLibrary.simpleMessage(
      "Real-time tracking, verified drivers, and secure payments ensure a worry-free ride experience.",
    ),
    "rideYourWay": MessageLookupByLibrary.simpleMessage("Your Ride, Your Way"),
    "ride_complete": MessageLookupByLibrary.simpleMessage(
      "Your Ride is Complete",
    ),
    "ride_feedback_prompt": MessageLookupByLibrary.simpleMessage(
      "We hope you had a smooth ride. Please complete your payment and rate your experience.",
    ),
    "ride_in_progress": MessageLookupByLibrary.simpleMessage(
      "Sit back and relax. Your driver is taking you to your destination.",
    ),
    "ride_on_the_way": MessageLookupByLibrary.simpleMessage(
      "Your Ride is on the Way",
    ),
    "ride_preferences": MessageLookupByLibrary.simpleMessage(
      "Ride Preferences",
    ),
    "ride_preferences_description": MessageLookupByLibrary.simpleMessage(
      "Select the type of ride that best suits your needs.",
    ),
    "ride_ready": MessageLookupByLibrary.simpleMessage("Your Ride is Ready!"),
    "ride_requested": MessageLookupByLibrary.simpleMessage("Ride requested"),
    "ride_started": MessageLookupByLibrary.simpleMessage(
      "Your Ride Has Started",
    ),
    "safeSecure": MessageLookupByLibrary.simpleMessage("Safe & Secure Rides"),
    "safetyPriority": MessageLookupByLibrary.simpleMessage(
      "Your Safety, Our Priority",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "search_destination": MessageLookupByLibrary.simpleMessage(
      "Search Destination",
    ),
    "searching_for_driver": MessageLookupByLibrary.simpleMessage(
      "Searching for an online driver..",
    ),
    "see_you_next_ride": MessageLookupByLibrary.simpleMessage(
      "We hope to see you again soon for your next ride!",
    ),
    "selectReportType": MessageLookupByLibrary.simpleMessage(
      "Select Report type",
    ),
    "select_a_country": MessageLookupByLibrary.simpleMessage(
      "Select a country",
    ),
    "select_card_type": MessageLookupByLibrary.simpleMessage(
      "Select Card type",
    ),
    "select_payment_method": MessageLookupByLibrary.simpleMessage(
      "Select payment method",
    ),
    "select_pickup_location": MessageLookupByLibrary.simpleMessage(
      "Select Pickup location",
    ),
    "select_profile_image": MessageLookupByLibrary.simpleMessage(
      "Select Profile Image",
    ),
    "select_service": MessageLookupByLibrary.simpleMessage("Select a Service!"),
    "send_timeout_with_api_server": MessageLookupByLibrary.simpleMessage(
      "Send timeout with API server",
    ),
    "service_charge": MessageLookupByLibrary.simpleMessage("Service Charge"),
    "services": MessageLookupByLibrary.simpleMessage("Services"),
    "share_experience": MessageLookupByLibrary.simpleMessage(
      "Share Your Experience!",
    ),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "skip_for_now": MessageLookupByLibrary.simpleMessage("Skip for Now"),
    "smartRideSavings": MessageLookupByLibrary.simpleMessage(
      "Smart Rides, Smart Savings.",
    ),
    "something_went_wrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "something_went_wrong_exclamation": MessageLookupByLibrary.simpleMessage(
      "Something went wrong!",
    ),
    "start_ride": MessageLookupByLibrary.simpleMessage("Start Ride"),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "stayOnThisDevice": MessageLookupByLibrary.simpleMessage(
      "Stay on This Device",
    ),
    "stop_point": MessageLookupByLibrary.simpleMessage("Stop point"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "terms_conditions": MessageLookupByLibrary.simpleMessage(
      "Terms & Conditions",
    ),
    "textCopied": MessageLookupByLibrary.simpleMessage("Text been copied"),
    "thanksForReporting": MessageLookupByLibrary.simpleMessage(
      "Thanks for reporting. Our team will review your issue and get back to you shortly.",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "top_up_your_wallet_securely_and_enjoy_seamless_payments":
        MessageLookupByLibrary.simpleMessage(
          "Top up your wallet securely and enjoy seamless payments.",
        ),
    "total_amount": MessageLookupByLibrary.simpleMessage("Total Amount"),
    "trips": MessageLookupByLibrary.simpleMessage("Trips"),
    "type_a_message": MessageLookupByLibrary.simpleMessage("Type a message"),
    "unauthorized_access_please_login_again":
        MessageLookupByLibrary.simpleMessage(
          "Unauthorized access. Please login again.",
        ),
    "unexpected_application_crash": MessageLookupByLibrary.simpleMessage(
      "Unexpected Application Crash",
    ),
    "unexpected_error_occurred": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred",
    ),
    "unexpected_response_format": MessageLookupByLibrary.simpleMessage(
      "Unexpected response format",
    ),
    "upload_image": MessageLookupByLibrary.simpleMessage("Upload image"),
    "use_otp_instead": MessageLookupByLibrary.simpleMessage("Use OTP Instead"),
    "use_your_password_here": MessageLookupByLibrary.simpleMessage(
      "Use your password here",
    ),
    "validation_error": MessageLookupByLibrary.simpleMessage(
      "Validation error",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("View Details"),
    "wait_message": MessageLookupByLibrary.simpleMessage(
      "Please wait while we connect you with the nearest available driver.",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Wallet"),
    "wallet_balance": MessageLookupByLibrary.simpleMessage("Wallet Balance"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Effortless rides at your fingertips. Experience fast, reliable, and safe transportation anytime, anywhere.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to Ready Ride",
    ),
    "write": m7,
    "writeIssueDetails": MessageLookupByLibrary.simpleMessage(
      "Write Issue Details",
    ),
    "yourAccountAlreadyActive": MessageLookupByLibrary.simpleMessage(
      "Your account is already active on another device. To use it here, the other device will be logged out.",
    ),
  };
}
