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
import 'package:gauva_userapp/data/models/intercity_trip_model.dart';
import 'package:gauva_userapp/presentation/intercity/views/intercity_booking_summary_page.dart';
import 'package:gauva_userapp/presentation/intercity/views/intercity_driver_list_page.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/intercity_trip_card.dart';

class IntercitySearchResultsPage extends ConsumerStatefulWidget {
  final String vehicleType;
  final String fromAddress;
  final String toAddress;
  final LatLng fromLocation;
  final LatLng toLocation;
  final bool isPrivateBooking;
  final int seatsNeeded;

  const IntercitySearchResultsPage({
    super.key,
    required this.vehicleType,
    required this.fromAddress,
    required this.toAddress,
    required this.fromLocation,
    required this.toLocation,
    this.isPrivateBooking = false,
    this.seatsNeeded = 1,
  });

  @override
  ConsumerState<IntercitySearchResultsPage> createState() => _IntercitySearchResultsPageState();
}

class _IntercitySearchResultsPageState extends ConsumerState<IntercitySearchResultsPage> {
  String? _loadingVehicleType;

  void _showTripSeatSelection(IntercityTripModel trip) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SeatSelectionSheet(
          maxSeats: trip.totalSeats ?? 4,
          minSeats: trip.minSeats ?? 1,
          availableSeats: trip.availableSeats ?? 0,
          onConfirm: (selectedSeats) {
            _confirmTripBooking(trip, selectedSeats);
          },
        ),
      ),
    );
  }

  void _confirmTripBooking(IntercityTripModel trip, int seatsToBook) {
    final searchState = ref.read(intercityServiceNotifierProvider).searchState;
    int? routeId;
    searchState.whenOrNull(success: (data) => routeId = data.route?.routeId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IntercityBookingSummaryPage(
          trip: trip,
          seatsToBook: seatsToBook,
          pickupAddress: widget.fromAddress,
          dropAddress: widget.toAddress,
          pickupLocation: widget.fromLocation,
          dropLocation: widget.toLocation,
          isPrivateBooking: widget.isPrivateBooking,
          routeId: routeId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final searchState = ref.watch(intercityServiceNotifierProvider).searchState;

    ref.listen(intercityServiceNotifierProvider.select((s) => s.driverListState), (previous, next) {
      next.maybeWhen(
        success: (drivers) {
          if (drivers.isNotEmpty) {
            final searchState = ref.read(intercityServiceNotifierProvider).searchState;
            int? routeId;
            searchState.whenOrNull(success: (data) => routeId = data.route?.routeId);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => IntercityDriverListPage(
                  drivers: drivers,
                  fromAddress: widget.fromAddress,
                  toAddress: widget.toAddress,
                  fromLocation: widget.fromLocation,
                  toLocation: widget.toLocation,
                  isPrivateBooking: widget.isPrivateBooking,
                  routeId: routeId,
                  seatsNeeded: widget.seatsNeeded, // Pass seatsNeeded
                ),
              ),
            ).then((_) {
              if (mounted) setState(() => _loadingVehicleType = null);
            });
          } else {
            setState(() => _loadingVehicleType = null);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('No drivers found for this vehicle type')));
          }
        },
        error: (failure) {
          setState(() => _loadingVehicleType = null);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Failed to load drivers: ${failure.message}')));
        },
        orElse: () {},
      );
    });

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
          widget.isPrivateBooking ? 'Private Search' : 'Search Results',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: searchState.when(
          initial: () => Center(child: Text('Initializing...')),
          loading: () => const Center(child: LoadingView()),
          error: (failure) => Center(child: Text('Error: ${failure.message}')),
          success: (data) {
            final hasVehicles = data.vehicleOptions != null && data.vehicleOptions!.isNotEmpty;
            final hasTrips = data.availableTrips != null && data.availableTrips!.isNotEmpty;

            if (!hasVehicles && !hasTrips) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64.sp, color: Colors.grey),
                    Gap(16.h),
                    Text(
                      'No services available',
                      style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route Info
                  if (data.route != null) _buildRouteInfo(context, data.route!, isDark),

                  // Available Trips Section
                  if (hasTrips) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                      child: Text(
                        'Available Trips (Drivers)',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: data.availableTrips!.map((trip) => _buildTripCard(context, trip, isDark)).toList(),
                      ),
                    ),
                  ],

                  // Vehicle Options Section
                  if (hasVehicles) ...[
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                      child: Text(
                        'Vehicle Options',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: data.vehicleOptions!
                            .map((option) => _buildVehicleOptionCard(context, option, isDark, data.recommendedVehicle))
                            .toList(),
                      ),
                    ),
                  ],

                  Gap(20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, RouteInfo route, bool isDark) => Container(
    margin: EdgeInsets.all(16.w),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              route.routeCode ?? 'Route',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            if (route.distanceKm != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(
                  '${route.distanceKm!.toStringAsFixed(1)} km',
                  style: TextStyle(fontSize: 12.sp, color: Colors.blue, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
        Gap(12.h),
        Row(
          children: [
            Icon(Icons.circle, size: 12.sp, color: Colors.green),
            Gap(8.w),
            Expanded(
              child: Text(
                route.originName ?? widget.fromAddress,
                style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.white70 : Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 5.w),
          height: 16.h,
          width: 1,
          color: Colors.grey,
        ),
        Row(
          children: [
            Icon(Icons.circle, size: 12.sp, color: Colors.red),
            Gap(8.w),
            Expanded(
              child: Text(
                route.destinationName ?? widget.toAddress,
                style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.white70 : Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildTripCard(BuildContext context, IntercityTripModel trip, bool isDark) =>
      IntercityTripCard(trip: trip, isDark: isDark, onJoinPressed: (trip) => _showTripSeatSelection(trip));

  Widget _buildVehicleOptionCard(BuildContext context, VehicleOption option, bool isDark, String? recommendedVehicle) {
    final isRecommended = option.isRecommended == true || option.vehicleType == recommendedVehicle;
    final isGlobalLoading = ref
        .watch(intercityServiceNotifierProvider)
        .driverListState
        .maybeWhen(loading: () => true, orElse: () => false);

    final isThisCardLoading = isGlobalLoading && option.vehicleType == _loadingVehicleType;
    final isSelected = isThisCardLoading;

    String? imagePath;
    if (option.vehicleType == 'TATA_MAGIC_LITE')
      imagePath = 'assets/images/tataMagic.png';
    else if (option.vehicleType == 'CAR_NORMAL')
      imagePath = 'assets/images/carnormal.png';
    else if (option.vehicleType == 'CAR_PREMIUM_EXPRESS')
      imagePath = 'assets/images/carPremium.png';
    else if (option.vehicleType == 'AUTO_NORMAL')
      imagePath = 'assets/images/Auto5.png';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        gradient: isSelected ? const LinearGradient(colors: [Color(0xFF1469B5), Color(0xFF42A5F5)]) : null,
        color: isSelected ? null : (isRecommended ? Colors.amber : (isDark ? Colors.grey[800]! : Colors.grey[200]!)),
      ),
      padding: EdgeInsets.all(isSelected || isRecommended ? 2.0 : 1.0),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: imagePath != null
                        ? Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Image.asset(imagePath, fit: BoxFit.contain),
                          )
                        : Icon(Ionicons.car_sport, size: 32.sp, color: Colors.grey.shade700),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              option.displayName ?? option.vehicleType ?? 'Vehicle',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF24262D),
                              ),
                            ),
                          ),
                          if (isRecommended)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                'RECOMMENDED',
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                      Gap(4.h),
                      Row(
                        children: [
                          Icon(Ionicons.people, size: 14.sp, color: Colors.grey[600]),
                          Gap(4.w),
                          Text(
                            '${option.seatsRemaining ?? 0} seats avail',
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Gap(12.h),
            Divider(color: isDark ? Colors.grey[800] : Colors.grey[200], thickness: 1),
            Gap(12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: (!isGlobalLoading || isThisCardLoading)
                        ? const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF397098), Color(0xFF942FAF)],
                          )
                        : null,
                    color: (!isGlobalLoading || isThisCardLoading)
                        ? null
                        : (isDark ? Colors.grey[700] : Colors.grey[300]),
                  ),
                  child: ElevatedButton(
                    onPressed: isGlobalLoading
                        ? null
                        : () {
                            setState(() {
                              _loadingVehicleType = option.vehicleType;
                            });
                            ref
                                .read(intercityServiceNotifierProvider.notifier)
                                .getIntercityDrivers(
                                  vehicleType: option.vehicleType!,
                                  seatsNeeded: widget.seatsNeeded,
                                  pickupLatitude: widget.fromLocation.latitude,
                                  pickupLongitude: widget.fromLocation.longitude,
                                  routeId: option.routeId,
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      elevation: 0,
                    ),
                    child: isThisCardLoading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            'Get Drivers',
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14.sp),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
