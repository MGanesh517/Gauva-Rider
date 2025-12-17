import 'dart:async';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/models/waypoint.dart';
import 'package:gauva_userapp/data/repositories/interfaces/i_geo_location_manager.dart';
import 'package:gauva_userapp/presentation/booking/provider/route_providers.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../core/widgets/markers/app_marker_drop_off.dart';
import '../../../core/widgets/markers/app_marker_pickup.dart';
import '../../../gen/assets.gen.dart';
import '../../dashboard/provider/home_map_providers.dart';
import '../provider/location_provider.dart';
import '../provider/way_point_list_providers.dart';

class WayPointMapState {
  final LatLng? pickUpPointLocation, dropOffPointLocation, stopPointLocation, currentLocation, driverLocation;
  final List<LatLng> routePoints;
  final Set<Marker> markers;
  final bool hasAnimatedCamera;
  final Set<Polyline> polyline;
  final GoogleMapController? mapController;

  WayPointMapState({
    this.driverLocation,
    this.pickUpPointLocation,
    this.dropOffPointLocation,
    this.stopPointLocation,
    this.currentLocation,
    this.routePoints = const [],
    this.markers = const {},
    this.polyline = const {},
    this.hasAnimatedCamera = false,
    this.mapController,
  });

  WayPointMapState copyWith({
    LatLng? driverLocation,
    LatLng? pickUpPointLocation,
    LatLng? dropOffPointLocation,
    LatLng? stopPointLocation,
    LatLng? currentLocation,
    List<LatLng>? routePoints,
    Set<Marker>? markers,
    Set<Polyline>? polyline,
    bool? hasAnimatedCamera,
    GoogleMapController? mapController,
  }) => WayPointMapState(
    pickUpPointLocation: pickUpPointLocation ?? this.pickUpPointLocation,
    dropOffPointLocation: dropOffPointLocation ?? this.dropOffPointLocation,
    stopPointLocation: stopPointLocation ?? this.stopPointLocation,
    currentLocation: currentLocation ?? this.currentLocation,
    routePoints: routePoints ?? this.routePoints,
    markers: markers ?? this.markers,
    polyline: polyline ?? this.polyline,
    hasAnimatedCamera: hasAnimatedCamera ?? this.hasAnimatedCamera,
    mapController: mapController ?? this.mapController,
  );

  WayPointMapState.empty()
    : this(
        driverLocation: null,
        pickUpPointLocation: null,
        dropOffPointLocation: null,
        stopPointLocation: null,
        currentLocation: null,
        routePoints: [],
        markers: {},
        polyline: {},
        hasAnimatedCamera: false,
        mapController: null,
      );
}

class WayPointMapNotifier extends StateNotifier<WayPointMapState> {
  final Ref ref;
  final IGeoLocationManager geoLocationManager;

  WayPointMapNotifier(this.ref, {required this.geoLocationManager}) : super(WayPointMapState.empty()) {
    initialize();
  }

  Size markerSize = const Size(700, 400);
  MarkerId pickupMarkerId = const MarkerId('pick-up');
  MarkerId pickupCircleMarkerId = const MarkerId('pickup_circle');
  MarkerId dropMarkerId = const MarkerId('Drop-off');
  MarkerId pinMarkerId = const MarkerId('pin');

  Future<void> initialize() async {
    final userLocation = await ref.read(homeMapRepoProvider).getUserLocation();
    state = state.copyWith(currentLocation: userLocation);

    ref.listen(wayPointListNotifierProvider, (previous, current) {
      final currentLocations = current.map((e) => e.location).toSet();
      final previousLocations = previous?.map((e) => e.location).toSet();
      if (!const SetEquality().equals(previousLocations, currentLocations)) {
        _updateMarkers(current);
      }
    });
  }

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(mapController: controller);
  }

  void updatePolyline(Set<Polyline>? polyline) {
    state = state.copyWith(polyline: polyline);
  }

  Future<void> updateForAccepted() async {
    final waypoints = ref.read(wayPointListNotifierProvider);
    await _updateMarkers(waypoints);

    _fitBoundsToPickupAndDropOff(waypoints.first.location, waypoints.last.location);
  }

  Future<void> updateForGoToPickup(LatLng driverLocation) async {
    await _updateDriverMarker(driverLocation);
    await _updateRoute(
      [Waypoint(location: driverLocation, address: '', name: '')] + ref.read(wayPointListNotifierProvider),
    );
  }

  Future<void> updateForPickedUp() async {
    final waypoints = ref.read(wayPointListNotifierProvider);
    await _updateMarkers(waypoints);
    await ref.read(routeNotifierProvider.notifier).fetchRoutes();
  }

  bool shouldUpdateMarker(MarkerId id, LatLng newPos) {
    if (state.markers.isEmpty || state.markers.length == 1) return true;
    try {
      final existing = state.markers.firstWhere((m) => m.markerId == id);
      // Marker exists → check position
      return existing.position != newPos;
    } catch (_) {
      // Marker doesn't exist → needs update
      return true;
    }
  }

  Future<void> _updateMarkers(List<Waypoint> waypoints) async {
    final pickupPos = waypoints.first.location;
    final dropPos = waypoints.last.location;

    if (shouldUpdateMarker(pickupMarkerId, pickupPos)) {
      final circleIcon = BitmapDescriptor.bytes(await _createCircle());
      await _getPickupMarker(waypoints.first.address).then((value) {
        final updatedMarkers = {...state.markers}
          ..removeWhere((m) => m.markerId == pickupMarkerId)
          ..add(Marker(markerId: pickupMarkerId, position: pickupPos, icon: value))
          ..removeWhere((m) => m.markerId == pickupCircleMarkerId)
          ..add(Marker(markerId: pickupCircleMarkerId, position: pickupPos, icon: circleIcon));
        state = state.copyWith(markers: updatedMarkers);
      });
    }

    if (shouldUpdateMarker(dropMarkerId, dropPos)) {
      final pinIcon = BitmapDescriptor.bytes(await _createRedPin());
      await _getDropOffMarker(waypoints.last.address).then((value) {
        final updatedMarkers = {...state.markers}
          ..removeWhere((m) => m.markerId == dropMarkerId)
          ..add(Marker(markerId: dropMarkerId, position: dropPos, icon: value))
          ..removeWhere((m) => m.markerId == pinMarkerId)
          ..add(Marker(markerId: pinMarkerId, position: dropPos, icon: pinIcon));
        state = state.copyWith(markers: updatedMarkers);
      });
    }
    await ref.read(routeNotifierProvider.notifier).fetchRoutes();
  }

  Future<void> _updateDriverMarker(LatLng location) async {
    final icon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(44, 44)),
      Assets.images.carTopView.path,
    );
    final marker = Marker(
      markerId: const MarkerId('car'),
      position: location,
      icon: icon,
      flat: true,
      anchor: const Offset(0.5, 0.5),
    );
    final updated = {...state.markers}
      ..removeWhere((m) => m.markerId.value == 'car')
      ..add(marker);
    _animateTo(location);
    state = state.copyWith(driverLocation: location, markers: updated);
  }

  void _animateTo(LatLng location) {
    state.mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 18)));
  }

  Future<void> _updateRoute(List<Waypoint> waypoints) async {
    await ref.read(routeNotifierProvider.notifier).fetchRoutes(wayPoints: waypoints);
  }

  Future<BitmapDescriptor> _getPickupMarker(String address) async =>
      await AppMarkerPickup(address: address).toBitmapDescriptor(imageSize: const Size(350, 300));

  Future<BitmapDescriptor> _getDropOffMarker(String address) async =>
      await AppMarkerDropOff(address: address).toBitmapDescriptor(imageSize: const Size(350, 300));

  Future<Uint8List> _createCircle() async {
    const size = 20;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const center = Offset(size / 2, size / 2);

    canvas
      ..drawCircle(center, size / 2, Paint()..color = const Color(0xFF27AE60))
      ..drawCircle(center, size / 2 - 4.5, Paint()..color = Colors.white)
      ..drawCircle(center, 3, Paint()..color = const Color(0xFF27AE60));

    final img = await recorder.endRecording().toImage(size, size);
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<Uint8List> _createRedPin() async {
    const size = 20;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const center = Offset(size / 2, size / 2);

    canvas
      ..drawCircle(center, size / 2, Paint()..color = const Color(0xFFEB5757))
      ..drawCircle(center, size / 2 - 4.5, Paint()..color = Colors.white)
      ..drawCircle(center, 3, Paint()..color = const Color(0xFFEB5757));

    final img = await recorder.endRecording().toImage(size, size);
    final byteData = await img.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void stopTracking({bool clearMarkers = true, bool clearPolylines = true}) {
    ref.read(locationNotifierProvider.notifier).stopTracking();
    if (clearMarkers) state = state.copyWith(markers: {});
    if (clearPolylines) state = state.copyWith(polyline: {});
  }

  void _fitBoundsToPickupAndDropOff(LatLng pickup, LatLng dropOff) {
    final southwest = LatLng(
      pickup.latitude < dropOff.latitude ? pickup.latitude : dropOff.latitude,
      pickup.longitude < dropOff.longitude ? pickup.longitude : dropOff.longitude,
    );
    final northeast = LatLng(
      pickup.latitude > dropOff.latitude ? pickup.latitude : dropOff.latitude,
      pickup.longitude > dropOff.longitude ? pickup.longitude : dropOff.longitude,
    );

    final bounds = LatLngBounds(southwest: southwest, northeast: northeast);

    // Animate camera to fit bounds with padding
    Future.delayed(const Duration(milliseconds: 300), () {
      state.mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
    });
  }
}
