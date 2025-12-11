import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/car_view_type.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/promotional_slider.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';
import 'package:gauva_userapp/presentation/dashboard/provider/banner_provider.dart';
import '../../account_page/provider/theme_provider.dart';

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
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.black : Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.circular(2)),
              ),
              // Flexible Content - wraps to content size
              Flexible(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (hasServices) const CarSelectionView(),
                      if (hasBanners) const PromotionalSlider(),
                      // Additional sections below banners
                      _buildRideAsYouLikeItSection(context, isDark),
                      // Add bottom padding for safe scrolling
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRideAsYouLikeItSection(BuildContext context, bool isDark) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    color: isDark ? Colors.black : Colors.white,
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
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              final title = index == 0 ? 'Share Pooling (Per Seat)' : 'Private Booking (Full Vehicle)';
              final subtitle = index == 0 ? 'Travel together and save' : 'Travel stress-free';
              final icon = index == 0 ? Icons.people : Icons.directions_car;
              final color = index == 0 ? Colors.orange : Colors.blue;

              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.pushNamed(context, '/share_pooling_selection');
                  } else {
                    Navigator.pushNamed(context, '/private_booking');
                  }
                },
                child: _buildFeatureCard(context, isDark, title: title, subtitle: subtitle, icon: icon, color: color),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget _buildFeatureCard(
    BuildContext context,
    bool isDark, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) => Container(
    width: 280.w,
    margin: EdgeInsets.only(right: 12.w),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[900] : Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        // Background illustration placeholder
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 120.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
            ),
            child: Icon(icon, size: 80.sp, color: color.withOpacity(0.5)),
          ),
        ),
        // Content
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.grey[400] : Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
