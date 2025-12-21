import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/intercity_service_type.dart';
import '../../../data/models/intercity_search_response.dart';
import '../../../data/models/intercity_trip_model.dart';
import '../../../data/repositories/interfaces/intercity_service_repo_interface.dart';

class IntercityServiceState {
  final IntercityServiceType? selectedServiceType;
  final AppState<List<IntercityServiceType>> serviceListState;
  final AppState<IntercitySearchResponse> searchState;
  final AppState<List<IntercityTripModel>> driverListState;
  final AppState<Map<String, dynamic>> bookingState;

  IntercityServiceState({
    required this.selectedServiceType,
    required this.serviceListState,
    required this.searchState,
    AppState<List<IntercityTripModel>>? driverListState,
    required this.bookingState,
  }) : driverListState = driverListState ?? const AppState.initial();

  IntercityServiceState copyWith({
    IntercityServiceType? selectedServiceType,
    bool resetSelectedServiceType = false,
    AppState<List<IntercityServiceType>>? serviceListState,
    AppState<IntercitySearchResponse>? searchState,
    AppState<List<IntercityTripModel>>? driverListState,
    AppState<Map<String, dynamic>>? bookingState,
    bool resetSearchState = false,
  }) => IntercityServiceState(
    selectedServiceType: resetSelectedServiceType ? null : selectedServiceType ?? this.selectedServiceType,
    serviceListState: serviceListState ?? this.serviceListState,
    searchState: resetSearchState ? const AppState.initial() : (searchState ?? this.searchState),
    driverListState: driverListState ?? this.driverListState,
    bookingState: bookingState ?? this.bookingState,
  );

  factory IntercityServiceState.initial() => IntercityServiceState(
    selectedServiceType: null,
    serviceListState: const AppState.initial(),
    searchState: const AppState.initial(),
    driverListState: const AppState.initial(),
    bookingState: const AppState.initial(),
  );
}

class IntercityServiceNotifier extends StateNotifier<IntercityServiceState> {
  final Ref ref;
  final IIntercityServiceRepo intercityServiceRepo;

  IntercityServiceNotifier(this.ref, this.intercityServiceRepo) : super(IntercityServiceState.initial());

  Future<void> getIntercityServiceTypes() async {
    state = state.copyWith(serviceListState: const AppState.loading());

    final result = await intercityServiceRepo.getIntercityServiceTypes();
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = state.copyWith(serviceListState: AppState.error(failure));
      },
      (data) {
        state = state.copyWith(serviceListState: AppState.success(data));
      },
    );
  }

  Future<void> searchIntercity({
    required LatLng fromLocation,
    required LatLng toLocation,
    String? vehicleType,
    required DateTime preferredDeparture,
    int seatsNeeded = 0,
    double searchRadiusKm = 0,
  }) async {
    state = state.copyWith(searchState: const AppState.loading());

    final result = await intercityServiceRepo.searchIntercity(
      routeId: 0, // Keep routeId as 0 as per user requirement
      pickupLatitude: fromLocation.latitude,
      pickupLongitude: fromLocation.longitude,
      dropLatitude: toLocation.latitude,
      dropLongitude: toLocation.longitude,
      vehicleType: vehicleType,
      preferredDeparture: preferredDeparture.toIso8601String(),
      seatsNeeded: seatsNeeded,
      searchRadiusKm: searchRadiusKm,
    );

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = state.copyWith(searchState: AppState.error(failure));
      },
      (data) {
        state = state.copyWith(searchState: AppState.success(data));
      },
    );
  }

  Future<void> getIntercityDrivers({
    required String vehicleType,
    required int seatsNeeded,
    double? pickupLatitude,
    double? pickupLongitude,
    int? routeId,
  }) async {
    state = state.copyWith(driverListState: const AppState.loading());

    final result = await intercityServiceRepo.getIntercityDrivers(
      vehicleType: vehicleType,
      seatsNeeded: seatsNeeded,
      pickupLatitude: pickupLatitude,
      pickupLongitude: pickupLongitude,
      routeId: routeId,
    );

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = state.copyWith(driverListState: AppState.error(failure));
      },
      (data) {
        state = state.copyWith(driverListState: AppState.success(data));
      },
    );
  }

  void selectServiceType(IntercityServiceType serviceType) {
    state = state.copyWith(
      selectedServiceType: serviceType,
      // Don't reset searchState, keep it as is
    );
  }

  void resetSelectServiceType() {
    state = state.copyWith(resetSelectedServiceType: true);
  }

  void resetState() {
    state = IntercityServiceState.initial();
  }

  Future<void> createIntercityBooking({
    required String vehicleType,
    required String bookingType,
    required int seatsToBook,
    int? tripId,
    int? routeId,
    required String pickupAddress,
    required double pickupLatitude,
    required double pickupLongitude,
    required String dropAddress,
    required double dropLatitude,
    required double dropLongitude,
    required String paymentMethod,
    required String fullName,
    required String email,
    String? contactPhone,
    String? specialInstructions,
  }) async {
    state = state.copyWith(bookingState: const AppState.loading());

    final result = await intercityServiceRepo.createIntercityBooking(
      vehicleType: vehicleType,
      bookingType: bookingType,
      seatsToBook: seatsToBook,
      tripId: tripId,
      routeId: routeId,
      pickupAddress: pickupAddress,
      pickupLatitude: pickupLatitude,
      pickupLongitude: pickupLongitude,
      dropAddress: dropAddress,
      dropLatitude: dropLatitude,
      dropLongitude: dropLongitude,
      paymentMethod: paymentMethod,
      fullName: fullName,
      email: email,
      contactPhone: contactPhone,
      specialInstructions: specialInstructions,
    );

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = state.copyWith(bookingState: AppState.error(failure));
      },
      (data) {
        showNotification(message: 'Booking created successfully!', isSuccess: true);
        state = state.copyWith(bookingState: AppState.success(data));
      },
    );
  }
}
