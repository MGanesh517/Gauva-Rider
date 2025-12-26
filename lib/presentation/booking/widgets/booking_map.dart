import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/change_status_bar.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/widgets/location_permission_wrapper.dart';
import 'package:gauva_userapp/presentation/booking/provider/booking_providers.dart';
import 'package:gauva_userapp/presentation/booking/provider/ride_preference_provider.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';
import 'package:gauva_userapp/presentation/track_order/views/track_order_sheet.dart';

import '../../../core/theme/animation_duration.dart';
import '../../account_page/provider/theme_provider.dart';
import '../../waypoint/provider/way_point_map_providers.dart';
import '../provider/route_providers.dart';
import 'rider_booking_sheet.dart';

GoogleMapController? bookingMapController;

class BookingMap extends ConsumerStatefulWidget {
  const BookingMap({super.key});

  @override
  ConsumerState<BookingMap> createState() => _BookingMapState();
}

class _BookingMapState extends ConsumerState<BookingMap> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(bookingNotifierProvider.notifier);
      ref.read(ridePreferenceProvider.notifier).getPreference();
    });
  }

  bool showInfoWindow = false;
  Offset infoWindowPosition = const Offset(0, 0);

  void _onMapCreated(GoogleMapController controller) {
    bookingMapController = controller;
    final state = ref.read(wayPointMapNotifierProvider);
    ref.read(wayPointMapNotifierProvider.notifier).setMapController(controller);

    if (state.currentLocation != null) {
      final adjustedPosition = LatLng(state.currentLocation!.latitude - 0.01, state.currentLocation!.longitude);
      controller.animateCamera(CameraUpdate.newLatLngZoom(adjustedPosition, 14));
    }

    // Fetch route when map is created
    Future.microtask(() {
      ref.read(routeNotifierProvider.notifier).fetchRoutes();
    });
  }

  bool isDark() => ref.watch(themeModeProvider.notifier).isDarkMode();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wayPointMapNotifierProvider);
    final bookingState = ref.watch(bookingNotifierProvider);

    // Fetch route when booking state changes to selectVehicle
    bookingState.whenOrNull(
      selectVehicle: (vehicles, b) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.polyline.isEmpty) {
            ref.read(routeNotifierProvider.notifier).fetchRoutes();
          }
        });
        return null;
      },
    );

    return ExitAppWrapper(
      canPop:
          bookingState.whenOrNull(
            selectVehicle: (v, b) {
              setStatusBar(isHome: true, isDark: isDark());
              return true;
            },
          ) ??
          false,
      onExit: () {
        ref.read(carTypeNotifierProvider.notifier).resetSelectCar();
      },
      child: LocationPermissionWrapper(
        pageName: AppRoutes.bookingPage,
        child: state.currentLocation == null
            ? const Scaffold(body: LoadingView())
            : Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: state.currentLocation ?? const LatLng(23.8103, 90.4125),
                        zoom: 18.0,
                      ),
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      zoomControlsEnabled: false,
                      rotateGesturesEnabled: false,
                      polylines: state.polyline,
                      markers: state.markers,
                    ),
                    // Back button
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            elevation: 4,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                                child: const Icon(Icons.arrow_back, color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedSwitcher(
                        duration: AnimationDuration.pageStateTransitionMobile,
                        child: bookingState.when(
                          initial: (b) => const SizedBox(),
                          selectVehicle: (vehicles, b) => const RideBookingSheet(),
                          inProgress: (b) => const TrackOrderSheet(),
                          cancel: (b) => const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
