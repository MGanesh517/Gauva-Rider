import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/geo_location_manager.dart';
import '../view_model/way_point_map_notifier.dart';

final geoLocationManagerProvider = Provider<GeoLocationManager>((ref) => GeoLocationManager());

final wayPointMapNotifierProvider =
StateNotifierProvider<WayPointMapNotifier, WayPointMapState>((ref) {
    final geoLocationManager = ref.watch(geoLocationManagerProvider);
    return WayPointMapNotifier(ref, geoLocationManager: geoLocationManager);
});
