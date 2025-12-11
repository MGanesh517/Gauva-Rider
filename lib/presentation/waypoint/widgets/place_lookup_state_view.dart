import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        loading: () => Assets.lottie.loading.lottie(),
      ),
    );
  }
}
