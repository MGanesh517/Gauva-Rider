import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/payment_confirm_repo_interface.dart';

import '../../../core/state/app_state.dart';
import '../../../data/services/navigation_service.dart';
import '../../track_order/provider/order_in_progress_provider.dart';

class HitSuccessUrlNotifier extends StateNotifier<AppState<CommonResponse?>> {
  final Ref ref;
  final IPaymentConfirmRepo paymentConfirmRepo;
  HitSuccessUrlNotifier(this.ref, this.paymentConfirmRepo) : super(const AppState.initial());

  Future<void> hitSuccessUrl({required String url}) async {
    state = const AppState.loading();
    final result = await paymentConfirmRepo.hitSuccessUrl(url: url);

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        state = AppState.success(data);
        ref.read(orderInProgressNotifier.notifier).gotToFeedback();
        NavigationService.pop();
      },
    );
  }

  void resetState() {
    state = const AppState.initial();
  }
}
