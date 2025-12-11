import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/common/loading_view.dart';

import 'package:gauva_userapp/presentation/waypoint/widgets/place_confirm_sheet.dart';

import '../../../core/widgets/markers/app_marker_stop.dart';
import '../../../data/models/debouncer.dart';
import '../../../gen/assets.gen.dart';
import '../provider/pick_route_providers.dart';
import '../provider/selected_loc_text_field_providers.dart';
import '../provider/way_point_map_providers.dart';

class WayPointMap extends ConsumerStatefulWidget {
  const WayPointMap({super.key});

  @override
  ConsumerState<WayPointMap> createState() => _WayPointMapState();
}

class _WayPointMapState extends ConsumerState<WayPointMap> {
  GoogleMapController? _mapController;
  late final DeBouncer _deBouncer;

  @override
  void initState() {
    super.initState();
    _deBouncer = DeBouncer(delay: const Duration(milliseconds: 300));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    final state = ref.read(wayPointMapNotifierProvider);

    if (state.currentLocation != null) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(state.currentLocation!, 18.0));
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _deBouncer.dispose();
    super.dispose();
  }

  LatLng? _cameraCenter;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wayPointMapNotifierProvider);
    final selectedFieldIndex = ref.watch(selectedLocTextFieldNotifierProvider);
    return Scaffold(
      body: state.currentLocation == null
          ? const Center(child: LoadingView())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(target: state.currentLocation!, zoom: 18.0),
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  rotateGesturesEnabled: false,
                  onCameraMove: (cameraPosition) {
                    _cameraCenter = cameraPosition.target;
                  },
                  onCameraIdle: () async {
                    if (_cameraCenter != null) {
                      ref
                          .read(pickRouteNotifierProvider.notifier)
                          .setLocation(index: selectedFieldIndex ?? 0, location: _cameraCenter!);
                    }
                  },
                ),
                ref
                    .watch(pickRouteNotifierProvider)
                    .when(
                      pickupPoint: (position) => pickupMarker(),
                      dropPoint: (position) => pickupMarker(),
                      stopPoint: (position) => const Center(child: AppMarkerStop(stopIndex: 1)),
                    ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ref
                      .watch(pickRouteNotifierProvider)
                      .when(
                        pickupPoint: (position) => PlaceConfirmSheet(location: position, index: selectedFieldIndex ?? 0),
                        dropPoint: (position) => PlaceConfirmSheet(location: position, index: selectedFieldIndex ?? 0),
                        stopPoint: (position) => PlaceConfirmSheet(location: position, index: selectedFieldIndex ?? 0),
                      ),
                ),
              ],
            ),
    );
  }

  Widget pickupMarker() => Center(child: Assets.images.mapMarker.image(height: 110, width: 90, fit: BoxFit.fill));
}
