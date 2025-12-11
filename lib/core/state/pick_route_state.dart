import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'pick_route_state.freezed.dart';

@freezed
class PickRouteState<T> with _$PickRouteState<T> {
  const factory PickRouteState.pickupPoint(LatLng location) = _PickupPoint<T>;
  const factory PickRouteState.dropPoint(LatLng location) = _DropPoint<T>;
  const factory PickRouteState.stopPoint(LatLng location) = _StopPoint<T>;
}
