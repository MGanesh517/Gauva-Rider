import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/presentation/intercity/provider/intercity_service_providers.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/intercity_waypoints_input_sheet.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class IntercitySelectionPage extends ConsumerStatefulWidget {
  const IntercitySelectionPage({super.key});

  @override
  ConsumerState<IntercitySelectionPage> createState() => _IntercitySelectionPageState();
}

class _IntercitySelectionPageState extends ConsumerState<IntercitySelectionPage> {
  String? _selectedBookingType;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('bookingType')) {
        setState(() {
          _selectedBookingType = args['bookingType'];
        });
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedBookingType != null) {
      return IntercityWaypointsInputSheet(
        vehicleType: null,
        bookingType: _selectedBookingType,
        onConfirm:
            ({
              required String fromAddress,
              required String toAddress,
              required LatLng fromLocation,
              required LatLng toLocation,
              required DateTime selectedDate,
              required int seats,
            }) async {
              final notifier = ref.read(intercityServiceNotifierProvider.notifier);

              // Combine date with default time logic (from previous implementation)
              final now = DateTime.now();
              TimeOfDay time;

              if (selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day == now.day) {
                time = TimeOfDay.now();
              } else {
                time = const TimeOfDay(hour: 9, minute: 0); // Default start time for future dates
              }

              final dt = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, time.hour, time.minute);

              // Trigger search
              await notifier.searchIntercity(
                fromLocation: fromLocation,
                toLocation: toLocation,
                vehicleType: null, // Search ALL types
                preferredDeparture: dt,
                seatsNeeded: seats,
                searchRadiusKm: 50,
              );

              if (mounted) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.intercitySearchResults,
                  arguments: {
                    'vehicleType': 'Any',
                    'fromAddress': fromAddress,
                    'toAddress': toAddress,
                    'fromLocation': fromLocation,
                    'toLocation': toLocation,
                    'bookingType': _selectedBookingType,
                    'seatsNeeded': seats,
                    'isPrivateBooking': _selectedBookingType == 'PRIVATE',
                  },
                );
              }
            },
      );
    }

    // If no bookingType, show selection screen
    return Scaffold(
      appBar: AppBar(title: const Text("Select Intercity Service")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [_buildSharePoolingBanner(context), const Gap(16), _buildPrivateBookingCard(context)],
      ),
    );
  }

  Widget _buildSharePoolingBanner(BuildContext context) => GestureDetector(
    onTap: () {
      setState(() {
        _selectedBookingType = 'SHARE_POOL';
      });
    },
    child: Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset("assets/images/share-pooling-banner.png", fit: BoxFit.fill),
      ),
    ),
  );

  Widget _buildPrivateBookingCard(BuildContext context) => GestureDetector(
    onTap: () {
      setState(() {
        _selectedBookingType = 'PRIVATE';
      });
    },
    child: Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset("assets/privatebooking.png", fit: BoxFit.fill),
      ),
    ),
  );
}
