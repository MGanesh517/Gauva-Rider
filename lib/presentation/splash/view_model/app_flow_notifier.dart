import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_flow_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';
import 'package:gauva_userapp/presentation/track_order/view_model/handle_order_status_update.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/services/navigation_service.dart';
import '../../booking/provider/booking_providers.dart';
import '../../track_order/provider/track_order_provider.dart';

class AppFlowNotifier extends StateNotifier<AppFlowState> {
  final Ref _ref;

  AppFlowNotifier(this._ref) : super(const AppFlowState.onboardingInProgress());

  Future<void> setAppFlowState() async {
    final localStorage = LocalStorageService();

    // Initialize required providers
    _ref
      ..read(bookingNotifierProvider)
      ..read(trackOrderNotifierProvider);

    final isOnboardingDone = await localStorage.isCompletedOnboarding();
    final isLoggedIn = await localStorage.isLoggedIn();
    final isRegistrationDone = await _isRegistrationDoneWell();

    if (!isOnboardingDone) {
      return _navigateTo(AppRoutes.onboarding);
    }

    if (!isRegistrationDone) {
      return _handleIncompleteRegistration();
    }

    if (!isLoggedIn) {
      return _navigateTo(AppRoutes.login);
    } else {
      _ref
          .watch(tripActivityNotifierProvider)
          .when(
            success: (order) {
              if (order != null) {
                return handleOrderStatusUpdate(
                  status: order.status?.toLowerCase() ?? '',
                  orderId: order.id,
                  ref: _ref,
                  paymentStatus: order.paymentStatus,
                );
              } else {
                return _navigateTo(AppRoutes.dashboard);
              }
            },
            initial: () {},
            loading: () {},
            error: (failure) {
              _navigateTo(AppRoutes.brokenPage);
            },
          );
    }
  }

  Future<bool> _isRegistrationDoneWell() async {
    final page = await LocalStorageService().getRegistrationProgress();
    return page == AppRoutes.dashboard || page == AppRoutes.setProfile;
  }

  void _handleIncompleteRegistration() async {
    final page = await LocalStorageService().getRegistrationProgress();

    if (page == null || page == AppRoutes.verifyOtp) {
      return _navigateTo(AppRoutes.login);
    }

    showNotification(message: 'Please complete your registration');
    _navigateTo(page);
  }

  void _navigateTo(String route, {Object? arguments}) {
    NavigationService.pushNamedAndRemoveUntil(route, arguments: arguments);
  }
}
