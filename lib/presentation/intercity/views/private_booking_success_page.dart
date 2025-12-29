import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

class PrivateBookingSuccessPage extends ConsumerStatefulWidget {
  final String bookingType; // 'private' or 'share'

  const PrivateBookingSuccessPage({super.key, this.bookingType = 'private'});

  @override
  ConsumerState<PrivateBookingSuccessPage> createState() => _PrivateBookingSuccessPageState();
}

class _PrivateBookingSuccessPageState extends ConsumerState<PrivateBookingSuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Icon
                Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF1469B5), Color(0xFF942FAF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(Icons.check_circle, size: 80.sp, color: Colors.white),
                ),
                Gap(32.h),
                // Success Message
                Text(
                  'Booking Successful!',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(16.h),
                Text(
                  widget.bookingType == 'share'
                      ? 'Your share pooling booking request has been submitted successfully.'
                      : 'Your private booking request has been submitted successfully.',
                  style: TextStyle(fontSize: 16.sp, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  'Your booking is on HOLD and will be confirmed by Admin.',
                  style: TextStyle(fontSize: 14.sp, color: Colors.orange, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                Gap(48.h),
                // Go to Home Button
                Container(
                  width: 200.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1469B5), Color(0xFF942FAF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1469B5).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Center(
                        child: Text(
                          'Go to Home',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
