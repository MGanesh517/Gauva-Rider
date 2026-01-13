import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart' as cluster;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/location_permission_dialogue.dart';
import 'package:gauva_userapp/presentation/waypoint/provider/google_api_providers.dart';

import '../../../data/models/my_cluster_item.dart';

class HomeMapState {
  final LatLng? currentLocation;
  final Set<Marker> markers;
  final cluster.ClusterManager<MyClusterItem>? manager;
  final String? address;

  HomeMapState({
    this.currentLocation,
    this.markers = const {},
    this.manager,
    this.address,
  });

  HomeMapState copyWith({
    LatLng? currentLocation,
    Set<Marker>? markers,
    cluster.ClusterManager<MyClusterItem>? manager,
    String? address,
  }) => HomeMapState(
      currentLocation: currentLocation ?? this.currentLocation,
      markers: markers ?? this.markers,
      manager: manager ?? this.manager,
      address: address ?? this.address,
    );

  HomeMapState.empty() : this(currentLocation: null, markers: {}, manager: null, address: null);
}

class HomeMapNotifier extends StateNotifier<HomeMapState> {
  final Ref ref;
  
  // PERFORMANCE OPTIMIZATION: Cache addresses to avoid repeated API calls
  static final Map<String, String> _addressCache = {};

  HomeMapNotifier(this.ref,) : super(HomeMapState.empty()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final userLocation = await showLocationPermissionPrompt(ref);
    if(userLocation != null){
      // PERFORMANCE OPTIMIZATION: Update location immediately, fetch address in background
      updateCurrentLocationMarkerAddress(userLocation);
    }
  }

  Future<void> updateCurrentLocationMarkerAddress(LatLng location) async {
    // PERFORMANCE OPTIMIZATION: Update location immediately (non-blocking)
    // This allows map to show instantly
    state = state.copyWith(currentLocation: location);
    
    // Set marker immediately without waiting for address
    _setCurrentLocationMarker();
    
    // PERFORMANCE OPTIMIZATION: Fetch address in background (non-blocking)
    // Don't await - let it update address when ready
    _getAddressFromLatLng(location).then((address) {
      if (address != null) {
        state = state.copyWith(address: address);
      }
    }).catchError((e) {
      // Silently handle errors - address is not critical for map display
      debugPrint('⚠️ Failed to fetch address: $e');
    });
  }

  Future<String?> _getAddressFromLatLng(LatLng location) async {
    try {
      // PERFORMANCE OPTIMIZATION: Check cache first (instant response)
      final cacheKey = '${location.latitude.toStringAsFixed(6)}_${location.longitude.toStringAsFixed(6)}';
      if (_addressCache.containsKey(cacheKey)) {
        return _addressCache[cacheKey];
      }

      // Fetch from API if not cached
      final String? address = await getAddressFromLocationUsingApi(location);
      
      // Cache the address for future use
      if (address != null && address.isNotEmpty) {
        _addressCache[cacheKey] = address;
        // Limit cache size to prevent memory issues
        if (_addressCache.length > 50) {
          _addressCache.remove(_addressCache.keys.first);
        }
      }

      return address;
    } catch (e) {
      debugPrint('⚠️ Error fetching address: $e');
      return null;
    }
  }

  Future<String?> getAddressFromLocationUsingApi(LatLng latLng) async {
    final response = await ref.read(googleAPIRepoProvider).getAddressFromLatLng(latLng);
    final String? address = response.fold(
      (failure) => null,
      (data) => data,
    );
    return address;
  }

  // Future<cluster.ClusterManager<MyClusterItem>?> _initClusterManager({required LatLng? userLocation}) async {
  //   cluster.ClusterManager<MyClusterItem>? clusterManager;
  //
  //   ref.watch(driversNotifierProvider(userLocation)).map(
  //       initial: (v) => null,
  //       loading: (v) => null,
  //       success: (data) {
  //         final List<MyClusterItem> clusterItems = data.data.data!
  //             .map(
  //               (bikeLocation) => MyClusterItem(
  //                 LatLng(bikeLocation.latitude!, bikeLocation.longitude!),
  //                 bikeLocation.carAngle!,
  //                 bikeLocation.name!,
  //               ),
  //             )
  //             .toList();
  //         clusterManager = cluster.ClusterManager<MyClusterItem>(
  //           clusterItems,
  //           _updateMarkers,
  //           markerBuilder: _markerBuilder,
  //         );
  //       },
  //       error: (error) => null);
  //
  //   return clusterManager;
  // }

  Future<void> _setCurrentLocationMarker() async {
    if (state.currentLocation == null) return;
    
    // PERFORMANCE OPTIMIZATION: Load marker icon asynchronously without blocking
    _getCurrentLocationMarker().then((icon) {
      if (state.currentLocation != null) {
        state = state.copyWith(
          markers: {
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: state.currentLocation!,
              icon: icon,
              anchor: const Offset(0.5, 1.0), // Anchor at bottom center of the marker
            )
          },
        );
      }
    });
  }

  // void _updateMarkers(Set<Marker> markers) async {
  //   final currentLocationMarkerIcon = await _getCurrentLocationMarker();
  //   final markerWithCurrentLocation = markers
  //     ..add(Marker(
  //       markerId: const MarkerId('currentLocation'),
  //       position: state.currentLocation!,
  //       icon: currentLocationMarkerIcon,
  //     ));
  //   state = state.copyWith(
  //     markers: markerWithCurrentLocation,
  //   );
  // }

  Future<BitmapDescriptor> _getCurrentLocationMarker() async {
    return await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(60, 60)),
      Assets.images.mapMarker.path,
    );
  }

  // Future<Marker> Function(dynamic) get _markerBuilder => (clus) async {
  //       final BitmapDescriptor markerIcon = await BitmapDescriptor.asset(
  //         const ImageConfiguration(size: Size(44, 44)),
  //         Assets.images.carTopView.path,
  //       );
  //       if (clus is MyClusterItem) {
  //         return Marker(
  //           markerId: const MarkerId('test id'),
  //           position: clus.location,
  //           anchor: const Offset(0.5, 0.5),
  //           icon: markerIcon,
  //           rotation: clus.angle.toDouble(),
  //           infoWindow: InfoWindow(title: clus.title),
  //         );
  //       } else if (clus is cluster.Cluster<MyClusterItem>) {
  //         final MyClusterItem? firstItem = clus.items.isNotEmpty ? clus.items.first : null;
  //
  //         return Marker(
  //           markerId: MarkerId(clus.getId()),
  //           position: clus.location,
  //           anchor: const Offset(0.5, 0.5),
  //           icon: markerIcon,
  //           rotation: firstItem?.angle.toDouble() ?? 0.0,
  //           infoWindow: clus.isMultiple
  //               ? InfoWindow(title: '${clus.count} Vehicles')
  //               : InfoWindow(title: firstItem?.title ?? ''),
  //         );
  //       }
  //       throw Exception('Unknown cluster type');
  //     };

  Future<void> resetState() async {
    state = HomeMapState.empty();
  }



}
