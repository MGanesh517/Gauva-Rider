import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

class IntercitySelectionPage extends ConsumerWidget {
  const IntercitySelectionPage({super.key});

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
          icon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Intercity Services',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ride as you like it section
              _buildRideAsYouLikeItSection(context, isDark),
              // Add bottom padding for safe scrolling
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRideAsYouLikeItSection(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Text(
          //   'Ride as you like it',
          //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black),
          // ),
          //           SizedBox(height: 12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: 2,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _buildSharePoolingBanner(context, isDark);
              }
              return GestureDetector(
                onTap: () {
                  NavigationService.pushNamed(AppRoutes.privateBooking);
                },
                child: _buildPrivateBookingCard(context, isDark),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSharePoolingBanner(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        NavigationService.pushNamed(AppRoutes.sharePoolingSelection);
      },
      child: Container(
        width: double.infinity,
        height: 150.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            "assets/images/share-pooling-banner.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150.h,
          ),
        ),
      ),
    );
  }

  Widget _buildPrivateBookingCard(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset("assets/privatebooking.jpg", fit: BoxFit.cover, width: double.infinity, height: 150.h),
      ),
    );
  }
}
