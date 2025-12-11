import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/repositories/interfaces/payment_confirm_repo_interface.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_state.dart';
import '../../../data/models/payent_confirm_model/payment_confirm_model.dart';
import '../../../data/services/navigation_service.dart';
import '../../track_order/provider/order_in_progress_provider.dart';

class PaymentConfirmNotifier extends StateNotifier<AppState<PaymentConfirmModel?>> {
  final Ref ref;
  final IPaymentConfirmRepo paymentConfirmRepo;
  PaymentConfirmNotifier(this.ref, this.paymentConfirmRepo) : super(const AppState.initial());

  Future<void> paymentConfirm({required int orderId, required String paymentMethodName}) async {
    state = const AppState.loading();
    final result = await paymentConfirmRepo.paymentConfirm(orderId: orderId, paymentMethodName: paymentMethodName);

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        state = AppState.success(data);
        if (data.data?.redirectUrl != null) {
          Future.microtask(() {
            NavigationService.pushNamed(AppRoutes.paymentPage, arguments: data.data?.redirectUrl ?? '');
          });
        } else {
          ref.read(orderInProgressNotifier.notifier).gotToFeedback();
        }
      },
    );
  }

  void resetState() {
    state = const AppState.initial();
  }
}
