import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/data/models/intercity_ride_history_model/intercity_ride_history_model.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

Widget intercityRideHistoryCard(
  BuildContext context, {
  required IntercityRideHistoryModel ride,
  required VoidCallback onTap,
  required bool isDark,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1F2128) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          if (!isDark) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: Border.all(color: isDark ? const Color(0xFF2C303E) : const Color(0xFFEDEEF1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorPalette.primary50.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  ride.tripCode ?? 'N/A',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.primary50,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: (ride.status == 'COMPLETED') ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  ride.status ?? 'N/A',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: (ride.status == 'COMPLETED') ? Colors.green : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(Icons.circle, size: 10.r, color: Colors.green),
                  Container(height: 30.h, width: 1.w, color: const Color(0xFFEDEEF1)),
                  Icon(Icons.location_on, size: 12.r, color: Colors.red),
                ],
              ),
              Gap(8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ride.pickupAddress ?? 'N/A',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : const Color(0xFF24262D),
                      ),
                    ),
                    Gap(20.h),
                    Text(
                      ride.dropAddress ?? 'N/A',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : const Color(0xFF24262D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(12.h),
          Divider(color: isDark ? const Color(0xFF2C303E) : const Color(0xFFEDEEF1)),
          Gap(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn(context, 'Date', ride.scheduledDeparture?.split('T').first ?? 'N/A', isDark),
              _buildInfoColumn(context, 'Price', '${ride.totalPrice ?? 0}', isDark),
              _buildInfoColumn(context, 'Vehicle', ride.vehicleType ?? 'N/A', isDark),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoColumn(BuildContext context, String title, String value, bool isDark) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: context.bodyMedium?.copyWith(fontSize: 10.sp, color: const Color(0xFF687387)),
      ),
      Gap(4.h),
      Text(
        value,
        style: context.bodyMedium?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF24262D),
        ),
      ),
    ],
  );
}
