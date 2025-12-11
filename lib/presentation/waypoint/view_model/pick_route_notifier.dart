import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/state/pick_route_state.dart';

import '../provider/way_point_list_providers.dart';

class PickRouteNotifier extends StateNotifier<PickRouteState> {
  final Ref ref;
  PickRouteNotifier(this.ref) : super(const PickRouteState.pickupPoint(LatLng(0, 0)));

  void setLocation({required int index, LatLng location = const LatLng(0, 0), bool isStopPoint = false}) {
    final wayPointList = ref.read(wayPointListNotifierProvider);

    if (wayPointList.length == 2) {
      switch (index) {
        case 0:
          state = PickRouteState.pickupPoint(location);
          break;
        case 1:
          state = PickRouteState.dropPoint(location);
          break;
        default:
      }
    } else {
      switch (index) {
        case 0:
          state = PickRouteState.pickupPoint(location);
          break;
        case 1:
          state = PickRouteState.stopPoint(location);
          break;
        case 2:
          state = PickRouteState.dropPoint(location);
      }
    }
  }
}
