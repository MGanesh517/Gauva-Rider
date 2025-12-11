import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/state/app_state.dart';

import '../../waypoint/provider/google_api_providers.dart';
import '../view_model/handle_travel_info_notifier.dart';
import '../view_model/route_notifier.dart';

final routeNotifierProvider = StateNotifierProvider<RouteNotifier, AppState<Set<Polyline>>>(
        (ref) => RouteNotifier(ref: ref, googleAPIRepo: ref.read(googleAPIRepoProvider)));

final routeProgressProvider = StateProvider<double>((ref) => 0.0);

final travelInfoNotifierProvider = NotifierProvider<TravelInfoNotifier, TravelTimeDistance>(() => TravelInfoNotifier());




