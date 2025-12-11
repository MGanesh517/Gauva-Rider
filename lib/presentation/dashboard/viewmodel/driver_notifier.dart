import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/models/driver_response/driver_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/driver_repo_interface.dart';

class DriversNotifier extends StateNotifier<AppState<DriverResponse>> {
  final IDriverRepo driverRepo;
  final LatLng? userLocation;
  DriversNotifier({
    required this.driverRepo,
    required this.userLocation,
  }) : super(const AppState.initial()) {
    getDrivers(location: userLocation);
  }

  Future<void> getDrivers({required LatLng? location}) async {
    state = const AppState.loading();
    final result = await driverRepo.getDrivers(location: location);
    result.fold(
      (failure) => state = AppState.error(failure),
      (data) => state = AppState.success(data),
    );
  }
}
