import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/models/waypoint.dart';
import 'package:gauva_userapp/data/repositories/interfaces/way_point_repo_interface.dart';
import 'package:gauva_userapp/presentation/waypoint/provider/way_point_map_providers.dart';

import '../../waypoint/provider/way_point_list_providers.dart';

class RouteNotifier extends StateNotifier<AppState<Set<Polyline>>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;
  RouteNotifier({
    required this.ref,
    required this.googleAPIRepo,
  }) : super(const AppState.initial());

  Future<void> fetchRoutes({List<Waypoint>? wayPoints}) async {
    state = const AppState.loading();
    final wayPointsState = ref.read(wayPointListNotifierProvider);
    final result = await googleAPIRepo.fetchWayPoints(
      waypoints: wayPoints ?? wayPointsState, );
    result.fold(
          (error) => state = AppState.error(error),
          (latlngs) {
        final polyLine = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.black,
            width: 6,
            points: latlngs,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            patterns: [],
            geodesic: true,
          ),
        };
        ref.read(wayPointMapNotifierProvider.notifier).updatePolyline(polyLine);
        return state = AppState.success(polyLine);
      },
    );


  }
}
