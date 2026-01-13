import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/models/waypoint.dart';
import 'package:gauva_userapp/data/repositories/interfaces/way_point_repo_interface.dart';
import 'package:gauva_userapp/presentation/waypoint/provider/way_point_map_providers.dart';

import '../../waypoint/provider/way_point_list_providers.dart';

class RouteNotifier extends StateNotifier<AppState<Set<Polyline>>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;

  // PERFORMANCE OPTIMIZATION: Prevent duplicate API calls
  bool _isFetching = false;
  Future<void>? _currentFetch;

  // PERFORMANCE OPTIMIZATION: Cache routes to avoid repeated API calls
  static final Map<String, List<LatLng>> _routeCache = {};
  static const _cacheDuration = Duration(minutes: 10); // Cache routes for 10 minutes
  static final Map<String, DateTime> _cacheTimestamps = {};

  // Track last fetched waypoints to prevent duplicate calls
  List<Waypoint>? _lastFetchedWaypoints;

  RouteNotifier({required this.ref, required this.googleAPIRepo}) : super(const AppState.initial());

  Future<void> fetchRoutes({List<Waypoint>? wayPoints}) async {
    // Use provided waypoints or get from state
    final List<Waypoint> wayPointsState = wayPoints ?? ref.read(wayPointListNotifierProvider);

    // Skip if waypoints list is empty or invalid
    if (wayPointsState.isEmpty || wayPointsState.length < 2) {
      debugPrint('⏭️ Route fetch skipped - insufficient waypoints');
      return;
    }

    // PERFORMANCE OPTIMIZATION: Skip if waypoints haven't changed
    if (_lastFetchedWaypoints != null && _waypointsEqual(_lastFetchedWaypoints!, wayPointsState)) {
      debugPrint('⏭️ Route fetch skipped - waypoints unchanged');
      return;
    }

    // PERFORMANCE OPTIMIZATION: Prevent duplicate simultaneous calls
    if (_isFetching && _currentFetch != null) {
      debugPrint('⏭️ Route fetch skipped - already in progress');
      return _currentFetch;
    }

    // PERFORMANCE OPTIMIZATION: Check cache first
    final cacheKey = _generateCacheKey(wayPointsState);
    if (_routeCache.containsKey(cacheKey)) {
      final cachedTimestamp = _cacheTimestamps[cacheKey];
      if (cachedTimestamp != null && DateTime.now().difference(cachedTimestamp) < _cacheDuration) {
        debugPrint('✅ Route fetched from cache');
        final cachedPoints = _routeCache[cacheKey]!;
        final polyLine = _createPolyline(cachedPoints);
        ref.read(wayPointMapNotifierProvider.notifier).updatePolyline(polyLine);
        _lastFetchedWaypoints = List<Waypoint>.from(wayPointsState);
        state = AppState.success(polyLine);
        return;
      } else {
        // Cache expired, remove it
        _routeCache.remove(cacheKey);
        _cacheTimestamps.remove(cacheKey);
      }
    }

    // Set fetching state
    _isFetching = true;
    state = const AppState.loading();
    _lastFetchedWaypoints = List<Waypoint>.from(wayPointsState);

    // Create fetch future
    _currentFetch = _performFetch(wayPointsState, cacheKey);

    try {
      await _currentFetch;
    } finally {
      _isFetching = false;
      _currentFetch = null;
    }
  }

  Future<void> _performFetch(List<Waypoint> wayPoints, String cacheKey) async {
    try {
      final result = await googleAPIRepo.fetchWayPoints(waypoints: wayPoints);
      result.fold(
        (error) {
          debugPrint('❌ Route fetch failed: ${error.message}');
          state = AppState.error(error);
        },
        (latlngs) {
          // Cache the route
          _routeCache[cacheKey] = latlngs;
          _cacheTimestamps[cacheKey] = DateTime.now();

          // Limit cache size
          if (_routeCache.length > 20) {
            final oldestKey = _cacheTimestamps.entries.reduce((a, b) => a.value.isBefore(b.value) ? a : b).key;
            _routeCache.remove(oldestKey);
            _cacheTimestamps.remove(oldestKey);
          }

          final polyLine = _createPolyline(latlngs);
          ref.read(wayPointMapNotifierProvider.notifier).updatePolyline(polyLine);
          state = AppState.success(polyLine);
          debugPrint('✅ Route fetched successfully (${latlngs.length} points)');
        },
      );
    } catch (e) {
      debugPrint('❌ Route fetch error: $e');
      state = AppState.error(Failure(message: e.toString()));
    }
  }

  Set<Polyline> _createPolyline(List<LatLng> points) {
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.black,
        width: 2,
        points: points,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        patterns: [],
        geodesic: true,
      ),
    };
  }

  String _generateCacheKey(List<Waypoint> waypoints) {
    if (waypoints.isEmpty) return '';
    final origin = waypoints.first.location;
    final destination = waypoints.last.location;
    // Round to 4 decimals for cache key (about 11 meters precision)
    return '${origin.latitude.toStringAsFixed(4)}_${origin.longitude.toStringAsFixed(4)}_'
        '${destination.latitude.toStringAsFixed(4)}_${destination.longitude.toStringAsFixed(4)}';
  }

  bool _waypointsEqual(List<Waypoint> a, List<Waypoint> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      // Compare locations with small tolerance (about 10 meters)
      if ((a[i].location.latitude - b[i].location.latitude).abs() > 0.0001 ||
          (a[i].location.longitude - b[i].location.longitude).abs() > 0.0001) {
        return false;
      }
    }
    return true;
  }
}
