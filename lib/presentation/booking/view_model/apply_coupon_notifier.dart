import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/ride_service_repo_interface.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

import '../provider/ride_services_providers.dart';
import '../provider/selection_providers.dart';

class ApplyCouponNotifier extends StateNotifier<AppState<CommonResponse>>{
  final Ref ref;
  final IRideServicesRepo repo;

  ApplyCouponNotifier({required this.ref, required this.repo}) : super(const AppState.initial());
  Future<void> applyCoupon({required String? coupon}) async {
    state = const AppState.loading();
    final result = await repo.applyCoupon(coupon: coupon);
    result.fold(
          (failure) {
            showNotification(message: failure.message);
        state = AppState.error(failure);
      },
          (data) {
            showNotification(message: data.message ?? '', isSuccess: true);
            ref.read(rideServiceFilterNotiferProvider.notifier).updateCouponCode(coupon);
        state = AppState.success(data);
            ref.read(rideServicesNotifierProvider.notifier).getRideServices(riderServiceFilter: ref.read(rideServiceFilterNotiferProvider.notifier).state);
            NavigationService.pop();
      },
    );
  }

}