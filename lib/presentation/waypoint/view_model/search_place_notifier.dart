import 'dart:async';
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
  
  // PERFORMANCE OPTIMIZATION: Faster debounce (300ms like HTML tool) for better responsiveness
  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 300); // Reduced from 500ms for faster response

  Future<void> searchPlace(String place) async {
    // Clear previous timer
    _debounceTimer?.cancel();
    
    // If query is too short, don't search
    if (place.trim().length < 2) {
      state = const AsyncValue.data([]);
      return;
    }
    
    // PERFORMANCE OPTIMIZATION: Check cache first (instant response)
    final cacheKey = place.trim().toLowerCase();
    if (_cache.containsKey(cacheKey)) {
      state = AsyncData(_cache[cacheKey]!);
      return;
    }
    
    // PERFORMANCE OPTIMIZATION: Debounce reduced to 300ms (matches HTML tool speed)
    // This prevents API calls on every keystroke while maintaining fast response
    _debounceTimer = Timer(_debounceDuration, () async {
      await _performSearch(place);
    });
  }
  
  Future<void> _performSearch(String place) async {
    state = const AsyncValue.loading();

    // PERFORMANCE OPTIMIZATION: Don't fetch location on every search
    // Backend autocomplete doesn't require origin location for basic search
    // Only fetch location once and cache it, or skip if not needed
    if (_cachedLocation == null) {
      // Fetch location asynchronously without blocking search
      ref.read(homeMapRepoProvider).getUserLocation().then((location) {
        _cachedLocation = location;
      });
    }

    // PERFORMANCE OPTIMIZATION: Search without waiting for location
    // Backend autocomplete works fine without origin location
    final result = await googleAPIRepo.searchPlace(place, _cachedLocation ?? const LatLng(0, 0));
    result.fold((error) => state = AsyncValue.error(error.message, StackTrace.current), (places) {
      // Cache results for instant future responses
      final cacheKey = place.trim().toLowerCase();
      _cache[cacheKey] = places;
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
    _debounceTimer?.cancel();
    state = const AsyncValue.data([]);
  }
  
  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
