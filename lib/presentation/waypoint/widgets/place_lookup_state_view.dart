import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/presentation/booking/view_model/ride_services_notifier.dart';
import 'package:gauva_userapp/presentation/booking/provider/ride_services_providers.dart';
import 'package:gauva_userapp/data/models/waypoint.dart';

import '../../../core/state/rider_service_state.dart';
import '../../../gen/assets.gen.dart';
import '../../booking/widgets/place_result_item.dart';
import '../provider/place_lat_lng_fetcher_providers.dart';
import '../provider/search_place_providers.dart';
import '../provider/selected_loc_text_field_providers.dart';
import '../provider/way_point_list_providers.dart';
import 'place_confirm_sheet.dart';

class PlaceLookupStateView extends ConsumerWidget {
  final Widget? initialStateView;

  const PlaceLookupStateView({super.key, this.initialStateView});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeSearchState = ref.watch(searchPlaceNotifierProvider);
    final selectedLocationField = ref.watch(selectedLocTextFieldNotifierProvider);
    final wayPointNotifier = ref.read(wayPointListNotifierProvider.notifier);
    final wayPointsState = ref.watch(wayPointListNotifierProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: placeSearchState.when(
        data: (places) => NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            FocusScope.of(context).unfocus();
            return false;
          },
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: places.length,
            separatorBuilder: (context, index) => const Divider(thickness: 0.3, indent: 48, height: 16),
            itemBuilder: (context, index) {
              final place = places[index];
              return PlaceResultItem(
                onPressed: () async {
                  try {
                    final LatLng? location = await ref
                        .read(placeLatLngFetcherNotifierProvider.notifier)
                        .getLatLngFromPlaceId(place.placeId);
                    if (context.mounted && location != null) {
                      // Determine the correct index to update
                      int targetIndex = selectedLocationField ?? 0;

                      // If selectedLocationField is null, determine the correct index
                      if (selectedLocationField == null) {
                        // Check if pickup (index 0) has an address, then destination should be index 1
                        if (wayPointsState.isNotEmpty &&
                            wayPointsState[0].address.isNotEmpty &&
                            wayPointsState.length > 1) {
                          targetIndex = 1; // Destination
                        } else if (wayPointsState.length > 1 && wayPointsState[1].address.isEmpty) {
                          targetIndex = 1; // Destination is empty
                        } else {
                          targetIndex = 0; // Pickup
                        }
                      }

                      // Ensure the waypoint list has enough items
                      if (targetIndex >= wayPointsState.length) {
                        targetIndex = wayPointsState.length - 1;
                      }

                      debugPrint('Updating waypoint at index $targetIndex with address: ${place.subtitle}');

                      wayPointNotifier.updateWayPoint(
                        index: targetIndex,
                        name: name(context, wayPointsState.length, targetIndex),
                        address: place.subtitle,
                        location: location,
                      );

                      // Prefetch services if both pickup and drop are set
                      // This ensures data is ready when user clicks "Confirm"
                      if (wayPointsState.isNotEmpty && wayPointsState.length > 1) {
                        // We need the updated list, but wayPointsState is from previous render.
                        // However, we just updated one index. Let's construct a temporary check.
                        final pickup = targetIndex == 0
                            ? Waypoint(name: 'Pick-up', address: place.subtitle, location: location)
                            : wayPointsState[0];
                        final drop = targetIndex == 1
                            ? Waypoint(name: 'Destination', address: place.subtitle, location: location)
                            : wayPointsState[1];

                        if (pickup.address.isNotEmpty &&
                            drop.address.isNotEmpty &&
                            pickup.location.latitude != 0 &&
                            drop.location.latitude != 0) {
                          final pickupLatLng = LatLng(pickup.location.latitude, pickup.location.longitude);
                          final dropLatLng = LatLng(drop.location.latitude, drop.location.longitude);

                          // Calculate distance (Simple Euclidean for prefetch estimation or use Haversine if needed)
                          // For prefetch, we just need valid coordinates to wake up the backend or get initial cache
                          final distanceKm = 5.0; // Placeholder
                          final durationMin = 15;

                          final riderService = RiderServiceState(
                            pickupLocation: [pickupLatLng.latitude, pickupLatLng.longitude],
                            pickupAddress: pickup.address,
                            dropLocation: [dropLatLng.latitude, dropLatLng.longitude],
                            dropAddress: drop.address,
                            waitLocation: [],
                            waitAddress: '',
                            serviceOptionIds: [],
                            pickupZoneReadableId: '',
                            dropZoneReadableId: '',
                            distanceKm: distanceKm,
                            durationMin: durationMin,
                          );

                          // Fire and forget - silent prefetch
                          ref
                              .read(rideServicesNotifierProvider.notifier)
                              .getAvailableServicesForRoute(riderServiceFilter: riderService, isSilent: true);
                        }
                      }

                      ref.read(searchPlaceNotifierProvider.notifier).reset();
                    }
                  } catch (e) {
                    debugPrint('Error getting location from place ID: $e');
                  }
                },
                title: place.title,
                subtitle: place.subtitle,
                trailing: place.distance,
              );
            },
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // loading: () => Assets.lottie.loading.lottie(),
        loading: () => const LoadingView(),
      ),
    );
  }
}
