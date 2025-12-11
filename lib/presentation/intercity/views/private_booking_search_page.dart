import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/presentation/intercity/provider/intercity_service_providers.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/intercity_waypoints_input_sheet.dart';
import 'package:gauva_userapp/presentation/intercity/views/intercity_search_results_page.dart';

class PrivateBookingSearchPage extends ConsumerStatefulWidget {
  final String vehicleType;
  const PrivateBookingSearchPage({super.key, required this.vehicleType});

  @override
  ConsumerState<PrivateBookingSearchPage> createState() => _PrivateBookingSearchPageState();
}

class _PrivateBookingSearchPageState extends ConsumerState<PrivateBookingSearchPage> {
  @override
  Widget build(BuildContext context) {
    return IntercityWaypointsInputSheet(
      vehicleType: widget.vehicleType,
      onConfirm:
          ({
            required String fromAddress,
            required String toAddress,
            required LatLng fromLocation,
            required LatLng toLocation,
            required DateTime selectedDate,
            required TimeOfDay selectedTime,
          }) async {
            // Combine date and time
            final dateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            // Call search API
            await ref
                .read(intercityServiceNotifierProvider.notifier)
                .searchIntercity(
                  fromLocation: fromLocation,
                  toLocation: toLocation,
                  vehicleType: widget.vehicleType,
                  preferredDeparture: dateTime,
                );

            // Navigate to results page
            final searchState = ref.read(intercityServiceNotifierProvider).searchState;
            searchState.maybeWhen(
              success: (data) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IntercitySearchResultsPage(
                      vehicleType: widget.vehicleType,
                      fromAddress: fromAddress,
                      toAddress: toAddress,
                      fromLocation: fromLocation,
                      toLocation: toLocation,
                      isPrivateBooking: true,
                    ),
                  ),
                );
              },
              error: (failure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message)));
              },
              orElse: () {},
            );
          },
    );
  }
}
