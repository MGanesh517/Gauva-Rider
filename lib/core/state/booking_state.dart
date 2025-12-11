import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/vehicle.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState<T> with _$BookingState<T> {
  const factory BookingState.initial({@Default(false) bool showButtonEnable}) = _Initial<T>;
  const factory BookingState.selectVehicle(List<VehicleOrder> vehicles, {@Default(false) bool showButtonEnable}) =
      _SelectVehicle<T>;
  const factory BookingState.inProgress({@Default(false) bool showButtonEnable}) = _Confirm;
  // const factory BookingState.inProgress(Order order, {@Default(false) bool showButtonEnable}) = _Confirm<T>;
  const factory BookingState.cancel({@Default(false) bool showButtonEnable}) = _Cancel<T>;
}
