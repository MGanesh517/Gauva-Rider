import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/color_palette.dart';
import '../../../data/models/ride_history_response/ride_history_item.dart';

Widget rideHistoryCard(
  BuildContext context, {
  required RideHistoryItem ride,
  Function()? onTap,
  bool showCancelItem = false,
  required bool isDark,
}) => Container(
  color: isDark ? AppColors.surface : Colors.white,
  padding: EdgeInsets.all(16.r),
  margin: EdgeInsets.only(bottom: 8.h),
  child: rideActivityCard(context, ride: ride, onTap: onTap, showCancelItem: showCancelItem, isDark: isDark),
);

Widget rideActivityCard(
  BuildContext context, {
  required RideHistoryItem ride,
  Function()? onTap,
  bool showCancelItem = false,
  required bool isDark,
}) => InkWell(
  onTap: onTap,
  child: Container(
    padding: EdgeInsets.all(8.r),
    decoration: BoxDecoration(
      color: isDark ? AppColors.surface : Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: const Color(0xFFEDEEF1), width: 1.w),
    ),
    child: Row(
      children: [
        Expanded(
          child: rideDetails(context, ride: ride, showCancelItem: showCancelItem, isDark: isDark),
        ),
        Container(
          margin: EdgeInsets.only(right: 8.w),
          height: 56.h,
          width: 1.w,
          color: const Color(0xFFD7DAE0),
        ),
        ratingDate(context, showCancelItem: showCancelItem, ride: ride),
      ],
    ),
  ),
);

Widget ratingDate(BuildContext context, {bool showCancelItem = false, required RideHistoryItem ride}) => SizedBox(
  width: 61.w,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '₹${(ride.fare ?? 0).toStringAsFixed(1)}',
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: ColorPalette.primary50,
            ),
          ),
          Gap(4.h),
          // Show "Cancelled" badge if cancelled, otherwise show "N/A" for rating
          showCancelItem
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: const Color(0xFFFFE4E4)),
                  child: Text(
                    'Cancelled',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFF5630),
                    ),
                  ),
                )
              : Text(
                  'N/A',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF687387),
                  ),
                ),
        ],
      ),
      Gap(8.h),
      Text(
        _formatDate(ride.endTime ?? ride.startTime),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.end,
        style: context.bodyMedium?.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF687387),
        ),
      ),
    ],
  ),
);

Widget rideDetails(
  BuildContext context, {
  required RideHistoryItem ride,
  bool showCancelItem = false,
  required bool isDark,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        ride.status ?? 'N/A',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF24262D),
        ),
      ),
      Gap(4.h),
      // Show all details for both completed and cancelled rides
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.directions_car, size: 14.sp, color: ColorPalette.primary50),
              Gap(4.w),
              Text(
                '${(ride.distance ?? 0).toStringAsFixed(2)} km',
                style: context.bodyMedium?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF687387),
                ),
              ),
              Gap(12.w),
              Icon(Icons.access_time, size: 14.sp, color: Colors.green),
              Gap(4.w),
              Text(
                '${((ride.duration ?? 0) / 60).toStringAsFixed(2)} min',
                style: context.bodyMedium?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF687387),
                ),
              ),
            ],
          ),
          Gap(8.h),
          if (ride.pickupArea != null) ...[
            Row(
              children: [
                Icon(Ionicons.location_outline, size: 14.sp, color: Colors.green),
                Gap(4.w),
                Expanded(
                  child: Text(
                    ride.pickupArea!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall?.copyWith(fontSize: 12.sp, color: const Color(0xFF687387)),
                  ),
                ),
              ],
            ),
            Gap(4.h),
          ],
          if (ride.destinationArea != null)
            Row(
              children: [
                Icon(Ionicons.location_outline, size: 14.sp, color: Colors.red),
                Gap(4.w),
                Expanded(
                  child: Text(
                    ride.destinationArea!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall?.copyWith(fontSize: 12.sp, color: const Color(0xFF687387)),
                  ),
                ),
              ],
            ),
        ],
      ),
    ],
  );
}

String _formatDate(String? dateTime) {
  if (dateTime == null) return 'N/A';
  try {
    final date = DateTime.parse(dateTime);
    return DateFormat('MMM dd, yyyy').format(date);
  } catch (e) {
    return 'N/A';
  }
}
