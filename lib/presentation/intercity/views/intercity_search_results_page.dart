import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/intercity/provider/intercity_service_providers.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/seat_selection_sheet.dart';
import 'package:gauva_userapp/data/models/intercity_search_response.dart';

class IntercitySearchResultsPage extends ConsumerStatefulWidget {
  final String vehicleType;
  final String fromAddress;
  final String toAddress;
  final LatLng fromLocation;
  final LatLng toLocation;
  final bool isPrivateBooking;

  const IntercitySearchResultsPage({
    super.key,
    required this.vehicleType,
    required this.fromAddress,
    required this.toAddress,
    required this.fromLocation,
    required this.toLocation,
    this.isPrivateBooking = false,
  });

  @override
  ConsumerState<IntercitySearchResultsPage> createState() => _IntercitySearchResultsPageState();
}

class _IntercitySearchResultsPageState extends ConsumerState<IntercitySearchResultsPage> {
  void _showSeatSelectionDialog(VehicleOption option) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SeatSelectionSheet(
          maxSeats: option.maxSeats ?? 4,
          minSeats: option.minSeats ?? 1,
          availableSeats: option.availableSeats ?? 0,
          onConfirm: (selectedSeats) {
            _confirmBooking(option, selectedSeats);
          },
        ),
      ),
    );
  }

  void _confirmBooking(VehicleOption option, int seatsToBook) async {
    final notifier = ref.read(intercityServiceNotifierProvider.notifier);

    await notifier.createIntercityBooking(
      vehicleType: widget.vehicleType,
      bookingType: 'SHARE_POOL', // Static as per user requirement
      seatsToBook: seatsToBook,
      pickupAddress: widget.fromAddress,
      pickupLatitude: widget.fromLocation.latitude,
      pickupLongitude: widget.fromLocation.longitude,
      dropAddress: widget.toAddress,
      dropLatitude: widget.toLocation.latitude,
      dropLongitude: widget.toLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final searchState = ref.watch(intercityServiceNotifierProvider).searchState;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isPrivateBooking ? 'Private Booking - Available Vehicles' : 'Available Vehicles',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: searchState.when(
          initial: () => Center(child: Text('Initializing...')),
          loading: () => const Center(child: LoadingView()),
          error: (failure) => Center(child: Text('Error: ${failure.message}')),
          success: (data) {
            if (data.vehicleOptions == null || data.vehicleOptions!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64.sp, color: Colors.grey),
                    Gap(16.h),
                    Text(
                      'No vehicles available',
                      style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Route Info
                if (data.route != null) _buildRouteInfo(context, data.route!, isDark),
                // Vehicle Options List
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.w),
                    itemCount: data.vehicleOptions!.length,
                    itemBuilder: (context, index) {
                      final option = data.vehicleOptions![index];
                      return _buildVehicleOptionCard(context, option, isDark, data.recommendedVehicle);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, RouteInfo route, bool isDark) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            route.routeCode ?? 'Route',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
          ),
          Gap(8.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 16.sp, color: Colors.blue),
              Gap(4.w),
              Expanded(
                child: Text(
                  route.originName ?? widget.fromAddress,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          Gap(4.h),
          Row(
            children: [
              Icon(Icons.location_on, size: 16.sp, color: Colors.red),
              Gap(4.w),
              Expanded(
                child: Text(
                  route.destinationName ?? widget.toAddress,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            children: [
              Icon(Icons.straighten, size: 16.sp, color: Colors.grey[600]),
              Gap(4.w),
              Text(
                '${route.distanceKm?.toStringAsFixed(1) ?? 0} km',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
              Gap(16.w),
              Icon(Icons.access_time, size: 16.sp, color: Colors.grey[600]),
              Gap(4.w),
              Text(
                '${route.estimatedDurationMinutes ?? 0} mins',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOptionCard(BuildContext context, VehicleOption option, bool isDark, String? recommendedVehicle) {
    final isRecommended = option.isRecommended == true || option.vehicleType == recommendedVehicle;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isRecommended
              ? Border.all(color: Colors.amber, width: 2)
              : Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and recommended badge
              Row(
                children: [
                  Expanded(
                    child: Text(
                      option.displayName ?? option.vehicleType ?? 'Vehicle',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  if (isRecommended)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        'RECOMMENDED',
                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                ],
              ),
              Gap(8.h),
              // Description
              if (option.description != null && option.description!.isNotEmpty)
                Text(
                  option.description!,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              Gap(8.h),
              // Details Row
              Row(
                children: [
                  // Seats
                  Row(
                    children: [
                      Icon(Ionicons.people, size: 14.sp, color: Colors.grey[600]),
                      Gap(4.w),
                      Text(
                        '${option.seatsRemaining ?? 0}/${option.seatsTotal ?? 0} seats',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Gap(16.w),
                  // Price per head
                  Row(
                    children: [
                      Icon(Icons.currency_rupee, size: 14.sp, color: Colors.grey[600]),
                      Gap(4.w),
                      Text(
                        '₹${option.currentPerHeadPrice?.toStringAsFixed(0) ?? 0}/head',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(8.h),
              // Recommendation Tag
              if (option.recommendationTag != null && option.recommendationTag!.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    option.recommendationTag!,
                    style: TextStyle(fontSize: 10.sp, color: Colors.amber[700], fontWeight: FontWeight.w600),
                  ),
                ),
              Gap(12.h),
              // Price and Book Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                      ),
                      Text(
                        '₹${option.totalPrice?.toStringAsFixed(0) ?? 0}',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFF1469B5), const Color(0xFF942FAF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1469B5).withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          _showSeatSelectionDialog(option);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Book Seat', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
