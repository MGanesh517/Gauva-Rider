import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/repositories/interfaces/way_point_repo_interface.dart';

import '../../../data/models/place_model.dart';
import '../../dashboard/provider/home_map_providers.dart';

class SearchPlaceNotifier extends StateNotifier<AsyncValue<List<PlaceModel>>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;
  SearchPlaceNotifier({required this.ref, required this.googleAPIRepo}) : super(const AsyncValue.data([]));

  final _cache = <String, List<PlaceModel>>{};

  LatLng? _cachedLocation;

  Future<void> searchPlace(String place) async {
    if (_cache.containsKey(place)) {
      state = AsyncData(_cache[place]!);
      return;
    }
    state = const AsyncValue.loading();

    // Use cached location or fetch if null
    if (_cachedLocation == null) {
      _cachedLocation = await ref.read(homeMapRepoProvider).getUserLocation();
    }

    final result = await googleAPIRepo.searchPlace(place, _cachedLocation ?? const LatLng(0, 0));
    result.fold((error) => state = AsyncValue.error(error.message, StackTrace.current), (places) {
      _cache[place] = places;
      state = AsyncValue.data(places);
    });
  }

  Future<LatLng?> getLatLngFromPlaceID(String placeId) async {
    LatLng? latLng;
    final result = await googleAPIRepo.getLatLngFromPlaceId(placeId);
    result.fold((error) => null, (lat) {
      latLng = lat;
    });
    return latLng;
  }

  void reset() {
    state = const AsyncValue.data([]);
  }
}
