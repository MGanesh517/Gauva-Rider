import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/repositories/interfaces/ride_service_repo_interface.dart';

import '../../../core/state/rider_service_state.dart';
import '../../../data/models/ride_service_response.dart';

class RideServicesNotifier extends StateNotifier<AppState<RideServiceResponse>> {
  final IRideServicesRepo rideServicesRepo;
  final Ref ref;

  RideServicesNotifier({required this.ref, required this.rideServicesRepo}) : super(const AppState.initial());

  Future<void> getRideServices({required RiderServiceState riderServiceFilter}) async {
    if (riderServiceFilter.pickupLocation.isEmpty || riderServiceFilter.dropLocation.isEmpty) {
      return;
    }
    state = const AppState.loading();
    final result = await rideServicesRepo.getRideServices(riderServiceFilter: riderServiceFilter);
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        state = AppState.success(data);
      },
    );
  }

  Future<void> getAvailableServicesForRoute({required RiderServiceState riderServiceFilter}) async {
    if (riderServiceFilter.pickupLocation.isEmpty || riderServiceFilter.dropLocation.isEmpty) {
      return;
    }
    state = const AppState.loading();
    final result = await rideServicesRepo.getAvailableServicesForRoute(riderServiceFilter: riderServiceFilter);
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        state = AppState.success(data);
      },
    );
  }
}
