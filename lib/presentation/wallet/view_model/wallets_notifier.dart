import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import '../../../core/state/app_state.dart';
import '../../../data/models/wallet_model/wallet_model.dart';
import '../../../data/repositories/interfaces/wallet_repo_interface.dart';

class WalletsNotifier extends StateNotifier<AppState<WalletModel>> {
  final IWalletsRepo walletsRepo;
  final Ref ref;

  WalletsNotifier({required this.walletsRepo, required this.ref}) : super(const AppState.initial());

  Future<void> getWallets() async {
    state = const AppState.loading();
    final result = await walletsRepo.getWallets();
    result.fold((failure) => state = AppState.error(failure), (data) => state = AppState.success(data));
  }

  Future<void> addBalance(String amount) async {
    debugPrint('💰 ADD BALANCE - Initiating top-up for amount: $amount');
    state = const AppState.loading();
    final result = await walletsRepo.addBalance(amount: amount);
    result.fold(
      (failure) {
        debugPrint('🔴 ADD BALANCE - Failed: ${failure.message}');
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) async {
        debugPrint('✅ ADD BALANCE - Success');

        // Check if payment link is available (new format)
        if (data.data?.paymentLinkUrl != null) {
          debugPrint('💳 Payment Link Created');
          debugPrint('💳 Payment Link URL: ${data.data?.paymentLinkUrl}');
          debugPrint('💳 Payment Link ID: ${data.data?.paymentLinkId}');
          debugPrint('💳 Transaction ID: ${data.data?.transactionId}');
          debugPrint('💳 Status: ${data.data?.status}');
          debugPrint('💳 Amount: ${data.data?.amount}');

          state = AppState.success(data);

          // Navigate to Razorpay payment WebView
          try {
            debugPrint('🔗 Opening payment link in WebView: ${data.data!.paymentLinkUrl}');

            // Close modal first
            NavigationService.pop();

            // Navigate to Razorpay payment WebView
            NavigationService.pushNamed(
              AppRoutes.razorpayPayment,
              arguments: {'paymentLinkUrl': data.data!.paymentLinkUrl!, 'transactionId': data.data!.transactionId},
            );

            debugPrint('✅ Navigated to Razorpay payment WebView');
          } catch (e, stackTrace) {
            debugPrint('🔴 Error navigating to payment WebView: $e');
            debugPrint('🔴 Stack trace: $stackTrace');
            showNotification(message: 'Error opening payment page. Please try again.');
          }
        }
        // Check if Razorpay order is needed (old format)
        else if (data.data?.razorpayOrderId != null && data.data?.razorpayKey != null) {
          debugPrint('💳 Razorpay Order Created');
          debugPrint('💳 Order ID: ${data.data?.razorpayOrderId}');
          debugPrint('💳 Key: ${data.data?.razorpayKey}');
          debugPrint('💳 Amount: ${data.data?.amount}');

          // TODO: Integrate Razorpay payment gateway
          // For now, show the Razorpay details
          showNotification(message: 'Razorpay payment initiated. Order ID: ${data.data?.razorpayOrderId}');

          state = AppState.success(data);
          // Don't close modal yet - wait for Razorpay payment completion
        } else {
          // Direct balance added (admin or other method)
          state = AppState.success(data);
          NavigationService.pop();
          getWallets();
        }
      },
    );
  }
}
