import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/ride_service_response.dart';

import '../../../core/enums/car_view_type.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/car_type_state.dart';
import '../../../data/repositories/interfaces/ride_service_repo_interface.dart';
import '../../booking/provider/ride_services_providers.dart';
import '../../waypoint/provider/selected_loc_text_field_providers.dart';

final carTypeNotifierProvider =
StateNotifierProvider<CarTypeNotifier, CarTypeState>((ref) {
  final repo = ref.read(rideServicesRepoProvider);
  return CarTypeNotifier(ref, repo);
});


class CarTypeNotifier extends StateNotifier<CarTypeState> {
  final Ref ref;
  final IRideServicesRepo rideServicesRepo;

  CarTypeNotifier(this.ref, this.rideServicesRepo) : super(CarTypeState.initial());

  Future<void> getServicesHome() async {
    state = state.copyWith(serviceListState: const AppState.loading());

    final result = await rideServicesRepo.getServicesHome();
    result.fold(
          (failure) {
        showNotification(message: failure.message);
        state = state.copyWith(serviceListState: AppState.error(failure));
      },
          (data) {
        final list = data.data?.servicesList ?? [];
        state = state.copyWith(serviceListState: AppState.success(list));
      },
    );
  }

  void selectCar(Services carType, {bool resetSelectedLocationState = false}) {
    state = state.copyWith(selectedCarType: carType);
    if (resetSelectedLocationState) {
      ref.read(selectedLocTextFieldNotifierProvider.notifier).resetState();
    }
  }

  void toggleViewType() {
    final newType =
    state.viewType == CarViewType.grid ? CarViewType.list : CarViewType.grid;
    state = state.copyWith(viewType: newType);
  }

  void setViewType(CarViewType type) {
    state = state.copyWith(viewType: type);
  }

  void resetSelectCar(){
    state = state.copyWith(resetSelectedCarType: true);
  }

  void resetState() {
    state = CarTypeState.initial();
  }
}

