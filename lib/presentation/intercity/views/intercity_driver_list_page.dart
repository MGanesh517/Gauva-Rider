import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/data/models/intercity_trip_model.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import 'package:gauva_userapp/presentation/intercity/views/intercity_booking_summary_page.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/intercity_trip_card.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/seat_selection_sheet.dart';

class IntercityDriverListPage extends ConsumerWidget {
  final List<IntercityTripModel> drivers;
  final String fromAddress;
  final String toAddress;
  final LatLng fromLocation;
  final LatLng toLocation;
  final bool isPrivateBooking;
  final int? routeId;
  final int? seatsNeeded;

  const IntercityDriverListPage({
    super.key,
    required this.drivers,
    required this.fromAddress,
    required this.toAddress,
    required this.fromLocation,
    required this.toLocation,
    this.isPrivateBooking = false,
    this.routeId,
    this.seatsNeeded,
  });

  void _showTripSeatSelection(BuildContext context, WidgetRef ref, IntercityTripModel trip) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: SeatSelectionSheet(
          maxSeats: trip.totalSeats ?? 4,
          minSeats: trip.minSeats ?? 1,
          availableSeats: trip.availableSeats ?? 0,
          onConfirm: (selectedSeats) {
            _confirmTripBooking(context, ref, trip, selectedSeats);
          },
        ),
      ),
    );
  }

  void _confirmTripBooking(BuildContext context, WidgetRef ref, IntercityTripModel trip, int seatsToBook) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IntercityBookingSummaryPage(
          trip: trip,
          seatsToBook: seatsToBook,
          pickupAddress: fromAddress,
          dropAddress: toAddress,
          pickupLocation: fromLocation,
          dropLocation: toLocation,
          isPrivateBooking: isPrivateBooking,
          routeId: routeId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Available Drivers',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: drivers.isEmpty
            ? Center(
                child: Text(
                  'No drivers available',
                  style: TextStyle(fontSize: 16.sp, color: isDark ? Colors.white70 : Colors.black54),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  return IntercityTripCard(
                    trip: drivers[index],
                    isDark: isDark,
                    onJoinPressed: (trip) {
                      if (seatsNeeded != null) {
                        _confirmTripBooking(context, ref, trip, seatsNeeded!);
                      } else if (isPrivateBooking) {
                        // For private booking, skip seat selection and book the whole vehicle
                        _confirmTripBooking(context, ref, trip, trip.totalSeats ?? 4);
                      } else {
                        _showTripSeatSelection(context, ref, trip);
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}
