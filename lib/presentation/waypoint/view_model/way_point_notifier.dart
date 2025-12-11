import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/models/waypoint.dart';
import '../provider/way_point_list_providers.dart';

class WayPointNotifier extends StateNotifier<List<Waypoint>> {
  final Ref ref;
  WayPointNotifier(this.ref) : super([]) {
    state = [
      Waypoint(name: 'Pick-up point', address: '', location: const LatLng(0.0, 0.0)),
      Waypoint(name: 'Drop-off point', address: '', location: const LatLng(0.0, 0.0))
    ];
  }
  void addStopPoint() {
    // add wayPoint to index 1
    state = List.from(state)
      ..insert(
        1,
        Waypoint(
          name: 'Stop point',
          address: '',
          location: const LatLng(0.0, 0.0),
        ),
      );
  }


  void removeStopPoint() {
    state = List.from(state)..removeAt(1);
  }

  void updateWayPoint({
    required int index,
    required String name,
    required String address,
    required LatLng location,
  }) {
    state = List.from(state)
      ..removeAt(index)
      ..insert(
        index,
        Waypoint(
          name: name,
          address: address,
          location: location,
        ),
      );
  }

  void removeWayPointByIndex({required int index}) {
    state = List.from(state)..[index] = state[index].copyWith(address: '', location: const LatLng(0.0, 0.0));
  }

  void resetWayPoint() {
    state.clear();
    state = [
      Waypoint(name: 'Pick-up point', address: '', location: const LatLng(0.0, 0.0)),
      Waypoint(name: 'Drop-off point', address: '', location: const LatLng(0.0, 0.0))
    ];
  }

  void setWayPointList(List<Waypoint> list){
    state.clear();
    state = list;
  }
}

class WayPointSelectionNotifier extends StateNotifier<bool> {
  final Ref ref;
  WayPointSelectionNotifier(this.ref) : super(false) {
    _updateButtonState();
    ref.listen<List<Waypoint>>(wayPointListNotifierProvider, (previous, next) {
      _updateButtonState();
    });
  }

  void _updateButtonState() {
    final waypoint = ref.read(wayPointListNotifierProvider);

    // Count waypoints with a valid address or non-zero location
    final selectedWaypoints = waypoint
        .where((waypoint) =>
    waypoint.address.isNotEmpty || (waypoint.location.latitude != 0.0 && waypoint.location.longitude != 0.0))
        .length;
    state = selectedWaypoints >= 2;
  }
}
