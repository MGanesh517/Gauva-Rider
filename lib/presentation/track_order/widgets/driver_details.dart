import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/extensions/number_extension.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/driver/driver.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../data/services/url_launch_serivices.dart';

Widget driverDetails(BuildContext context, Driver? driver, {required bool isDark}) {
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
          backgroundColor: ColorPalette.primary50,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: driver?.profilePicture ?? '',
                height: height.h,
                width: width.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: height.h,
                  width: width.w,
                  color: Colors.grey[300],
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                errorWidget: (context, url, error) => Container(
                  height: height.h,
                  width: width.w,
                  color: Colors.grey,
                  child: const Icon(Icons.error, color: Colors.white),
                ),
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
                maxLines: 2,
                style: context.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.directions_car_outlined, size: 13.r, color: const Color(0xFF687387)),
                  Gap(4.w),
                  Text(
                    (driver?.totalTrip ?? 0).formattedCount,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF687387),
                    ),
                  ),
                  Gap(4.w),
                  Text(
                    AppLocalizations.of(context).trips,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF687387),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
                    height: 8.h,
                    width: 1.w,
                    color: const Color(0xFFD7DAE0),
                  ),
                  Icon(Icons.star, color: Colors.amber, size: 16.r),
                  Gap(2.w),
                  Text(
                    (driver?.rating ?? 0).formattedCount,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF687387),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Consumer(
          builder: (context, ref, _) {
            return getBackground(
              icon: Ionicons.chatbubble_ellipses_outline,
              backgroundColor: isDark ? const Color(0xFF687387) : const Color(0xFFF6F7F9),
              iconColor: const Color(0xFF24262D),
              onTap: () {
                // TODO: Implement chat functionality
                // LocalStorageService().saveChatState(isOpen: true);
                NavigationService.pushNamed(AppRoutes.chatPage);
              },
            );
          },
        ),
        Gap(16.w),
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
