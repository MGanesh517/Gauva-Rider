import 'dart:async';
import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/utils/change_status_bar.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/payment_method/provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/state/rider_service_state.dart';
import '../../../core/utils/color_palette.dart';
import '../../../core/widgets/buttons/app_back_button.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../core/widgets/icon_destination.dart';
import '../../../core/widgets/location_text_field.dart';
import '../../../data/models/waypoint.dart';
import '../../../data/services/navigation_service.dart';
import '../../account_page/provider/theme_provider.dart';
import '../../booking/provider/booking_providers.dart';
import '../../booking/provider/order_providers.dart';
import '../../booking/provider/ride_services_providers.dart';
import '../../booking/provider/selection_providers.dart';
import '../../booking/provider/route_providers.dart';
import '../../dashboard/provider/home_map_providers.dart';
import '../../track_order/provider/order_in_progress_provider.dart';
import '../provider/google_api_providers.dart';
import '../provider/pick_route_providers.dart';
import '../provider/search_place_providers.dart';
import '../provider/selected_loc_text_field_providers.dart';
import '../provider/way_point_list_providers.dart';
import '../provider/way_point_map_providers.dart';
import '../provider/way_point_selection_providers.dart';
import '../widgets/place_lookup_state_view.dart';

class SearchDestinationPage extends ConsumerStatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  ConsumerState<SearchDestinationPage> createState() => _SearchDestinationPageState();
}

class _SearchDestinationPageState extends ConsumerState<SearchDestinationPage> {
  Timer? _debounce;

  late bool isDark;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWaypoints();
      setStatusBar(isDark: isDark);
    });
  }

  void _initializeWaypoints() {
    try {
      final homeMapState = ref.read(homeMapNotifierProvider);
      final wayPointNotifier = ref.read(wayPointListNotifierProvider.notifier);
      final filterNotifier = ref.read(rideServiceFilterNotiferProvider.notifier);

      wayPointNotifier.resetWayPoint();
      final _ = ref.refresh(selectedLocTextFieldNotifierProvider.notifier);

      if (homeMapState.currentLocation != null) {
        wayPointNotifier.updateWayPoint(
          index: 0,
          name: 'Pick-up',
          address: homeMapState.address ?? 'N/A',
          location: homeMapState.currentLocation!,
        );
        filterNotifier.updatePickupLocation([
          homeMapState.currentLocation!.latitude,
          homeMapState.currentLocation!.longitude,
        ]);
      }
    } catch (e) {
      debugPrint('Error initializing waypoints: $e');
    }
  }

  void _onSearchChanged(String? value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 800), () {
      if (value == null || value.trim().isEmpty) {
        ref.read(searchPlaceNotifierProvider.notifier).reset();
      } else if (value.length > 3) {
        ref.read(searchPlaceNotifierProvider.notifier).searchPlace(value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    setStatusBar(isHome: true, isDark: isDark);
    super.dispose();
  }

  Waypoint _getWaypointByName(List<Waypoint> list, String name) => list.firstWhere(
    (element) => element.name == name,
    orElse: () => Waypoint(name: '', address: '', location: const LatLng(0, 0)),
  );

  @override
  Widget build(BuildContext context) {
    final wayPointList = ref.watch(wayPointListNotifierProvider);
    final pickupPoint = _getWaypointByName(wayPointList, 'Pick-up');
    final dropOffPoint = _getWaypointByName(wayPointList, 'Destination');
    final stopPoint = _getWaypointByName(wayPointList, 'Stop point');

    return ExitAppWrapper(
      child: Scaffold(
        appBar: AppBar(
          leading: AppBackButton(color: isDark ? Colors.white : null),
          title: Text(
            AppLocalizations.of(context).search_destination,
            style: context.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
          // backgroundColor: Colors.white,
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        body: Column(
          children: [
            Container(height: 10.h, width: double.infinity, color: isDark ? Colors.black : ColorPalette.neutralF6),
            Expanded(
              child: SafeArea(
                bottom: !isIos(),
                child: Padding(
                  padding: const EdgeInsets.all(16).copyWith(bottom: isIos() ? 24.h : 16.h),
                  child: Column(
                    children: [
                      _buildWaypointList(wayPointList, isDark: isDark),
                      Gap(16.h),
                      const Expanded(child: PlaceLookupStateView()),
                      _buildConfirmButton(pickupPoint, dropOffPoint, stopPoint),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaypointList(List<Waypoint> wayPointList, {required bool isDark}) {
    final selectedField = ref.watch(selectedLocTextFieldNotifierProvider);
    final fieldNotifier = ref.read(selectedLocTextFieldNotifierProvider.notifier);
    final routePickNotifier = ref.read(pickRouteNotifierProvider.notifier);
    final wayPointNotifier = ref.read(wayPointListNotifierProvider.notifier);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: wayPointList
              .mapIndexed(
                (index, _) => Column(
                  children: [
                    IconDestination(isPickupPoint: index == 0, color: isDark ? Colors.white : null),
                    if (index != wayPointList.length - 1)
                      const DottedLine(
                        direction: Axis.vertical,
                        dashColor: ColorPalette.neutral90,
                        lineThickness: 3,
                        lineLength: 70,
                      ),
                  ],
                ),
              )
              .toList(),
        ),
        Gap(6.w),
        Expanded(
          child: Column(
            children: wayPointList
                .mapIndexed(
                  (index, e) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: LocationTextField(
                      initialValue: e,
                      isFocused: index == selectedField,
                      onChanged: (value) {
                        // Ensure selected field is set when user types
                        if (selectedField != index) {
                          fieldNotifier.setSelectedLocation(index);
                        }
                        _onSearchChanged(value);
                      },
                      index: index,
                      totalCount: wayPointList.length,
                      onFocused: () => fieldNotifier.setSelectedLocation(index),
                      onRemoveStop: () {},
                      onMapPressed: (value, node) {
                        node.unfocus();
                        fieldNotifier.setSelectedLocation(index);
                        routePickNotifier.setLocation(index: index);
                        NavigationService.pushNamed(AppRoutes.waypointPage);
                      },
                      onRemoved: (removed) {
                        if (removed) {
                          wayPointNotifier.removeWayPointByIndex(index: index);
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(Waypoint pickup, Waypoint dropOff, Waypoint stop) {
    final isEnabled = ref.watch(wayPointSelectionNotifierProvider);
    final isLoading = ref.watch(rideServicesNotifierProvider).maybeWhen(loading: () => true, orElse: () => false);

    return AppPrimaryButton(
      isDisabled: !isEnabled,
      isLoading: isLoading,
      onPressed: () async {
        if (pickup.name.isEmpty || dropOff.name.isEmpty) {
          showNotification(message: AppLocalizations.of(context).select_pickup_location);
          return;
        }

        final pickupLatLng = LatLng(pickup.location.latitude, pickup.location.longitude);
        final dropLatLng = LatLng(dropOff.location.latitude, dropOff.location.longitude);

        // Show loading
        showNotification(message: 'Getting zone information...');

        // Get zones for pickup and dropoff
        final googleAPIRepo = ref.read(googleAPIRepoProvider);
        String? pickupZone = '';
        String? dropZone = '';

        try {
          final pickupZoneResult = await googleAPIRepo.getZoneId(pickupLatLng);
          pickupZoneResult.fold(
            (error) => debugPrint('Error getting pickup zone: ${error.message}'),
            (zone) => pickupZone = zone,
          );

          final dropZoneResult = await googleAPIRepo.getZoneId(dropLatLng);
          dropZoneResult.fold(
            (error) => debugPrint('Error getting drop zone: ${error.message}'),
            (zone) => dropZone = zone,
          );
        } catch (e) {
          debugPrint('Error getting zones: $e');
        }

        // Calculate distance and duration
        final distanceKm = _calculateDistance(pickupLatLng, dropLatLng) / 1000; // Convert to km
        final durationMin = _estimateDuration(distanceKm);

        final riderService = RiderServiceState(
          pickupLocation: [pickupLatLng.latitude, pickupLatLng.longitude],
          pickupAddress: pickup.address,
          dropLocation: [dropLatLng.latitude, dropLatLng.longitude],
          dropAddress: dropOff.address,
          waitLocation: stop.name.isNotEmpty ? [stop.location.latitude, stop.location.longitude] : [],
          waitAddress: stop.address,
          serviceOptionIds: [],
          pickupZoneReadableId: pickupZone,
          dropZoneReadableId: dropZone,
          distanceKm: distanceKm,
          durationMin: durationMin,
        );

        ref.read(rideServiceFilterNotiferProvider.notifier).addRideServiceFilter(riderService);

        await ref.read(rideServicesNotifierProvider.notifier).getRideServices(riderServiceFilter: riderService);

        ref.read(bookingNotifierProvider.notifier).resetState();
        ref.read(createOrderNotifierProvider.notifier).reset();
        ref.read(orderInProgressNotifier.notifier).resetState();
        ref.read(selectedPayMethodProvider.notifier).reset();
        ref.read(selectedRideNotifierProvider.notifier).reset();
        ref.read(bookingNotifierProvider.notifier).selectVehicle();

        await ref.read(routeNotifierProvider.notifier).fetchRoutes();

        ref
            .read(rideServicesNotifierProvider)
            .maybeWhen(
              success: (_) {
                NavigationService.pushReplacementNamed(AppRoutes.bookingPage);
                ref.read(wayPointMapNotifierProvider.notifier).updateForAccepted();
              },
              orElse: () {},
            );
      },
      child: Text(
        AppLocalizations.of(context).confirm,
        style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }

  /// Calculate distance between two points in meters (Haversine formula)
  double _calculateDistance(LatLng from, LatLng to) {
    const double earthRadius = 6371000; // Earth radius in meters
    final double dLat = _deg2rad(to.latitude - from.latitude);
    final double dLon = _deg2rad(to.longitude - from.longitude);

    final double a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_deg2rad(from.latitude)) * math.cos(_deg2rad(to.latitude)) * math.sin(dLon / 2) * math.sin(dLon / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _deg2rad(double deg) => deg * (math.pi / 180);

  /// Estimate duration in minutes based on distance
  /// Assuming average speed of 30 km/h in city
  int _estimateDuration(double distanceKm) {
    const double averageSpeedKmh = 30.0; // Average city speed
    final double durationHours = distanceKm / averageSpeedKmh;
    return (durationHours * 60).round(); // Convert to minutes
  }
}
