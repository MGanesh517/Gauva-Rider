import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/repositories/interfaces/cancel_ride_repo_interface.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../data/services/navigation_service.dart';
import '../../websocket/provider/websocket_provider.dart';
import '../provider/booking_providers.dart';

class CancelRideNotifier extends StateNotifier<AppState<CommonResponse>> {
  final ICancelRideRepo rideRepo;
  final Ref ref;
  CancelRideNotifier(this.ref, this.rideRepo) : super(const AppState.initial());

  Future<void> cancelRide() async {
    final local = LocalStorageService();
    state = const AppState.loading();

    final orderId = await local.getOrderId();
    final result = await rideRepo.cancelRide(orderId: orderId);

    result.fold(
      (failure) {
        state = AppState.error(failure);

        showNotification(message: failure.message);
      },
      (data) {
        final message = data.message ?? 'Ride cancelled';

        showNotification(message: message, isSuccess: true);

        state = AppState.success(data);

        local.clearOrderId();
        ref.read(bookingNotifierProvider.notifier).resetState();
        ref.read(carTypeNotifierProvider.notifier).resetState();

        // Leave WebSocket ride room
        ref.read(websocketProvider.notifier).leaveRideRoom();

        NavigationService.pop();
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
      },
    );
  }
}
