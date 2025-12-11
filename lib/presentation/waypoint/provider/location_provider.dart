import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/presentation/waypoint/provider/way_point_map_providers.dart';
import '../view_model/location_notifier.dart';

final locationNotifierProvider = StateNotifierProvider<LocationNotifier, void>((ref) {
  final geoManager = ref.read(geoLocationManagerProvider);
  return LocationNotifier(geoManager, ref);
});
