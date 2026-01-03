import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/extensions/number_extension.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/driver/driver.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../data/services/url_launch_serivices.dart';

String _getFirstLetter(String? name) {
  if (name == null) return 'D';
  final trimmed = name.trim();
  if (trimmed.isEmpty) return 'D';
  return trimmed[0].toUpperCase();
}

String _buildVehicleInfo(Driver? driver) {
  final licensePlate = driver?.licensePlate;

  if (licensePlate != null && licensePlate.isNotEmpty) {
    return licensePlate;
  }
  return '';
}

Widget driverDetails(BuildContext context, Driver? driver, {required bool isDark, int? otp}) {
  const double height = 60;
  const double width = 60;
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFEDEEF1)),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: ColorPalette.primary94,
          radius: (height / 2).r,
          child: (driver?.profilePicture != null && driver!.profilePicture!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: driver.profilePicture!,
                      height: height.h,
                      width: width.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: height.h,
                        width: width.w,
                        color: Colors.grey[300],
                        child: Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF397098), Color(0xFF942FAF)],
                            ).createShader(bounds),
                            child: const CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Text(
                          _getFirstLetter(driver.name),
                          style: context.bodyMedium?.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1469B5),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    _getFirstLetter(driver?.name),
                    style: context.bodyMedium?.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1469B5),
                    ),
                  ),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driver?.name != null ? driver!.name! : (driver?.mobile ?? 'N/A'),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
                ),
              ),
              // Row(
              //   children: [
              //     Icon(Icons.directions_car_outlined, size: 13.r, color: const Color(0xFF687387)),
              //     Gap(4.w),
              //     Text(
              //       (driver?.totalTrip ?? 0).formattedCount,
              //       style: context.bodyMedium?.copyWith(
              //         fontSize: 10.sp,
              //         fontWeight: FontWeight.w500,
              //         color: const Color(0xFF687387),
              //       ),
              //     ),
              //     Gap(4.w),
              //     Text(
              //       AppLocalizations.of(context).trips,
              //       style: context.bodyMedium?.copyWith(
              //         fontSize: 10.sp,
              //         fontWeight: FontWeight.w600,
              //         color: const Color(0xFF687387),
              //       ),
              //     ),
              //     Container(
              //       margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
              //       height: 8.h,
              //       width: 1.w,
              //       color: const Color(0xFFD7DAE0),
              //     ),
              //     Icon(Icons.star, color: Colors.amber, size: 16.r),
              //     Gap(2.w),
              //     Text(
              //       (driver?.rating ?? 0).formattedCount,
              //       style: context.bodyMedium?.copyWith(
              //         fontSize: 10.sp,
              //         fontWeight: FontWeight.w600,
              //         color: const Color(0xFF687387),
              //       ),
              //     ),
              //   ],
              // ),
              if (driver?.licensePlate != null) ...[
                Gap(4.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2C3036) : const Color(0xFFF1F7FE),
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: isDark ? Colors.grey[800]! : Colors.blue.withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          _buildVehicleInfo(driver),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : const Color(0xFF1469B5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // OTP display if available
        if (otp != null) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF687387) : const Color(0xFFF1F7FE),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'OTP',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF687387),
                  ),
                ),
                Gap(2.h),
                Text(
                  otp.toString().padLeft(4, '0'),
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1469B5),
                  ),
                ),
              ],
            ),
          ),
          Gap(8.w),
        ],
        getBackground(
          icon: Ionicons.call_outline,
          backgroundColor: isDark ? const Color(0xFF687387) : const Color(0xFFF1F7FE),
          iconColor: const Color(0xFF1469B5),
          onTap: () {
            UrlLaunchServices.launchDialer(driver?.mobile);
          },
        ),
      ],
    ),
  );
}

Widget getBackground({
  required IconData icon,
  required Color backgroundColor,
  required Color iconColor,
  void Function()? onTap,
}) => InkWell(
  onTap: onTap,
  child: Container(
    padding: EdgeInsets.all(10.r),
    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4.r)),
    child: Icon(icon, color: iconColor, size: 19.r),
  ),
);
