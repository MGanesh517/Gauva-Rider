import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/booking_state.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';

import '../../../data/models/ride_service_response.dart';

class BookingNotifier extends StateNotifier<BookingState> {
  final Ref ref;

  BookingNotifier(this.ref) : super(const BookingState.initial()) {
    _init();
  }

  void _init() {
    selectVehicle();
    ref.listen<Services?>(
      carTypeNotifierProvider.select((s) => s.selectedCarType),
          (_, _) => _updateBookingState(),
      onError: (error, stack) => true,
    );  }

  void selectVehicle() {
    state = const BookingState.selectVehicle([]);
  }

  void cancel() => state = const BookingState.cancel();

  void inProgress() {
    state = const BookingState.inProgress();

  }

  bool _checkBookingEnable() {
    final selectedService = ref.read(carTypeNotifierProvider);
    return selectedService.selectedCarType != null ;
  }

  void _updateBookingState() => state = state.copyWith(showButtonEnable: _checkBookingEnable());

  void resetState(){
    state = const BookingState.initial();
  }
}
