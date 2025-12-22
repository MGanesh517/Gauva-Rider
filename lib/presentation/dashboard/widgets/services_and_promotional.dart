import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/car_view_type.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/promotional_slider.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';
import 'package:gauva_userapp/presentation/dashboard/provider/banner_provider.dart';
import 'package:gauva_userapp/presentation/intercity/widgets/intercity_waypoints_input_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../account_page/provider/theme_provider.dart';
import '../../intercity/provider/intercity_service_providers.dart';

class ServicesAndPromotional extends ConsumerWidget {
  const ServicesAndPromotional({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();

    // Check if there's any content to show
    final carState = ref.watch(carTypeNotifierProvider);
    final bannerState = ref.watch(bannerProvider);

    // Check if services have content
    final hasServices = carState.serviceListState.whenOrNull(success: (data) => data.isNotEmpty) ?? false;

    // Check if banners have content
    final hasBanners = bannerState.whenOrNull(success: (data) => data.isNotEmpty) ?? false;

    // Only show bottom sheet if there's content
    if (!hasServices && !hasBanners) {
      return const SizedBox.shrink();
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.15,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg.png'), fit: BoxFit.fill, opacity: 0.15),
          color: isDark ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: Column(
          children: [
            // Drag Handle
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2)),
            ),
            // Scrollable Content
            Expanded(
              child: ListView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  if (hasServices) const CarSelectionView(),
                  // Add spacing between services and banners
                  if (hasServices && hasBanners) SizedBox(height: 8.h),
                  if (hasBanners) const PromotionalSlider(),
                  // Add spacing between banners and "Ride as you like it"
                  if (hasBanners) SizedBox(height: 8.h),
                  // Additional sections below banners
                  _buildRideAsYouLikeItSection(context, ref, isDark),
                  // Add bottom padding for safe scrolling
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideAsYouLikeItSection(BuildContext context, WidgetRef ref, bool isDark) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ride as you like it',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 2,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildSharePoolingBanner(context, ref, isDark);
              }
              return _buildPrivateBookingCard(context, ref, isDark);
            },
          ),
        ),
      ],
    ),
  );

  Widget _buildSharePoolingBanner(BuildContext context, WidgetRef ref, bool isDark) => GestureDetector(
    onTap: () {
      _handleIntercitySelection(context, ref, 'SHARE_POOL');
    },
    child: Container(
      width: 300.w,
      height: 150.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 300.w,
          height: 150.h,
          child: Image.asset("assets/images/share-pooling-banner.png", fit: BoxFit.fill, width: 300.w, height: 150.h),
        ),
      ),
    ),
  );

  Widget _buildPrivateBookingCard(BuildContext context, WidgetRef ref, bool isDark) => GestureDetector(
    onTap: () {
      _handleIntercitySelection(context, ref, 'PRIVATE');
    },
    child: Container(
      width: 280.w,
      height: 150.h,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset("assets/privatebooking.png", fit: BoxFit.fill, width: 280.w, height: 150.h),
      ),
    ),
  );

  void _handleIntercitySelection(BuildContext context, WidgetRef ref, String bookingType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => IntercityWaypointsInputSheet(
        vehicleType: null,
        bookingType: bookingType,
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

              final now = DateTime.now();
              TimeOfDay time;

              if (selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day == now.day) {
                time = TimeOfDay.now();
              } else {
                time = const TimeOfDay(hour: 9, minute: 0);
              }

              final dt = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, time.hour, time.minute);

              await notifier.searchIntercity(
                fromLocation: fromLocation,
                toLocation: toLocation,
                vehicleType: null,
                preferredDeparture: dt,
                seatsNeeded: seats,
                searchRadiusKm: 50,
              );

              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  AppRoutes.intercitySearchResults,
                  arguments: {
                    'vehicleType': 'Any',
                    'fromAddress': fromAddress,
                    'toAddress': toAddress,
                    'fromLocation': fromLocation,
                    'toLocation': toLocation,
                    'bookingType': bookingType,
                    'seatsNeeded': seats,
                    'isPrivateBooking': bookingType == 'PRIVATE',
                  },
                );
              }
            },
      ),
    );
  }
}
