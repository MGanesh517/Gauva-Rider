import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/models/ride_history_response/ride_history_item.dart';
import 'package:gauva_userapp/presentation/auth/views/change_password.dart';
import 'package:gauva_userapp/presentation/auth/views/login_page.dart';
import 'package:gauva_userapp/presentation/auth/views/login_with_password_page.dart';
import 'package:gauva_userapp/presentation/auth/views/forgot_password_page.dart';
import 'package:gauva_userapp/presentation/auth/views/forgot_password_verify_otp_page.dart';
import 'package:gauva_userapp/presentation/auth/views/onboarding_page.dart';
import 'package:gauva_userapp/presentation/booking/views/booking_page.dart';
import 'package:gauva_userapp/presentation/ride_history/views/ride_details_page.dart';
import 'package:gauva_userapp/presentation/splash/views/splash_page.dart';
import 'package:gauva_userapp/presentation/track_order/views/chat_sheet.dart';
import 'package:gauva_userapp/presentation/notifications/views/notifications_page.dart';
import 'package:gauva_userapp/presentation/waypoint/views/way_point_page.dart';
import 'package:gauva_userapp/presentation/waypoint/widgets/waypoints_input_sheet.dart';
import 'package:gauva_userapp/presentation/intercity/views/intercity_search_results_page.dart';

import '../../common/error_view.dart';
import '../../presentation/auth/views/set_password_page.dart';
import '../../presentation/auth/views/set_profile_page.dart';
import '../../presentation/auth/views/signup_page.dart';
import '../../presentation/auth/views/verify_otp_page.dart';
import '../../presentation/broken_page/view/broken_page.dart';
import '../../presentation/dashboard/views/dashboard.dart';
import '../../presentation/no_internet/view/no_internet_view.dart';
import '../../presentation/profile/views/profile_info_page.dart';
import '../../presentation/report_issue/view/report_issue_view.dart';
import '../../presentation/ride_history/views/ride_history_page.dart';

import '../../presentation/intercity/views/share_pooling_selection_page.dart';
import '../../presentation/intercity/views/private_booking_page.dart';
import '../../presentation/intercity/views/private_booking_success_page.dart';
import '../../presentation/intercity/views/intercity_selection_page.dart';
import '../config/slide_right_route.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/onboarding':
        return SlideRightRoute(page: const OnboardingPage());
      case '/login':
        return SlideRightRoute(page: const LoginPage());
      case '/signup':
        return SlideRightRoute(page: const SignupPage());
      // case '/verify-otp':
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return SlideRightRoute(page: VerifyOtpPage(arguments: args));
      case '/login-with-password-page':
        return SlideRightRoute(page: const LoginWithPasswordPage());
      case '/set-password':
        return SlideRightRoute(page: const SetPasswordPage());
      case '/set-profile':
        return SlideRightRoute(page: const SetProfilePage());
      case '/change-password':
        return SlideRightRoute(page: const ChangePasswordPage());
      case '/forgot-password':
        return SlideRightRoute(page: const ForgotPasswordPage());
      case '/forgot-password-verify-otp':
        final email = settings.arguments as String;
        return SlideRightRoute(page: ForgotPasswordVerifyOtpPage(email: email));
      case '/dashboard-page':
        return SlideRightRoute(page: const DashboardPage());
      case '/waypoint-page':
        return SlideRightRoute(page: WayPointPage());
      case '/search-destination-page':
        return SlideRightRoute(page: const SearchDestinationPage());
      case '/booking-page':
        return SlideRightRoute(page: BookingPage());
      case '/chat-page':
        return SlideRightRoute(page: const ChatSheet());
      case '/notifications-page':
        return SlideRightRoute(page: const NotificationsPage());
      case '/profile-info-page':
        return SlideRightRoute(page: const ProfileInfoPage());

      case '/ride-history':
        return SlideRightRoute(page: const RideHistoryPage());
      case '/ride-history-detail':
        final ride = settings.arguments as RideHistoryItem;
        return SlideRightRoute(page: RideDetailsPage(ride: ride));

      case '/report-issue':
        final orderId = settings.arguments as int?;
        return SlideRightRoute(page: ReportIssueView(orderId));

      case '/no-internet':
        return SlideRightRoute(page: const NoInternetPage());
      case '/broken-page':
        return MaterialPageRoute(builder: (_) => const BrokenPage());
      case '/share_pooling_selection':
        return SlideRightRoute(page: const SharePoolingSelectionPage());
      case '/private_booking':
        return SlideRightRoute(page: const PrivateBookingPage());
      case '/private_booking_success':
        return SlideRightRoute(page: const PrivateBookingSuccessPage());
      case '/intercity_selection':
        return SlideRightRoute(page: const IntercitySelectionPage());
      case '/intercity_search_results':
        final args = settings.arguments as Map<String, dynamic>;
        return SlideRightRoute(
          page: IntercitySearchResultsPage(
            vehicleType: args['vehicleType'] as String,
            fromAddress: args['fromAddress'] as String,
            toAddress: args['toAddress'] as String,
            fromLocation: args['fromLocation'] as LatLng,
            toLocation: args['toLocation'] as LatLng,
            isPrivateBooking: args['bookingType'] == 'PRIVATE',
          ),
        );
      default:
        return SlideRightRoute(
          page: Scaffold(body: ErrorView(message: 'No route defined for ${settings.name}')),
        );
    }
  }
}
