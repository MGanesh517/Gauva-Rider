import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/utils/format_date.dart';
import '../../../core/utils/network_image.dart';
import '../../../data/models/order_response/order_model/order/order.dart';
import '../../../gen/assets.gen.dart';

Widget rideHistoryCard(
  BuildContext context, {
  required Order order,
  Function()? onTap,
  bool showCancelItem = false,
  required bool isDark,
}) => Container(
  color: isDark ? AppColors.surface : Colors.white,
  padding: EdgeInsets.all(16.r),
  margin: EdgeInsets.only(bottom: 8.h),
  child: rideActivityCard(context, order: order, onTap: onTap, showCancelItem: showCancelItem, isDark: isDark),
);

Widget rideActivityCard(
  BuildContext context, {
  required Order order,
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
        showCancelItem ? buildImageError(40, 40) : imageBuilder(order.driver?.profilePicture),
        Gap(8.w),
        Expanded(
          child: rideDetails(context, order: order, showCancelItem: showCancelItem, isDark: isDark),
        ),
        Container(
          margin: EdgeInsets.only(right: 8.w),
          height: 56.h,
          width: 1.w,
          color: const Color(0xFFD7DAE0),
        ),

        ratingDate(context, showCancelItem: showCancelItem, order: order),
      ],
    ),
  ),
);

Widget ratingDate(BuildContext context, {bool showCancelItem = false, required Order order}) => SizedBox(
  width: 61.w,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      showCancelItem
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: const Color(0xFFFFE4E4)),
              child: Text(
                'Cancel Ride',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: context.bodyMedium?.copyWith(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFFF5630),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Ionicons.star, color: Colors.amber, size: 16.h),
                Gap(4.w),
                Text(
                  (order.rating ?? 0).toStringAsFixed(1),
                  style: context.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode() ? Colors.grey : const Color(0xFF24262D),
                  ),
                ),
              ],
            ),
      Gap(8.h),
      Text(
        formatDateEnglish(order.orderTime),
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

Widget rideDetails(BuildContext context, {required Order order, bool showCancelItem = false, required bool isDark}) {
  final driver = order.driver;
  final displayName = driver?.name != null ? (driver?.name ?? '') : driver?.mobile ?? 'N/A';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        displayName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF24262D),
        ),
      ),
      Gap(4.h),
      showCancelItem
          ? const SizedBox.shrink()
          : Row(
              children: [
                infoChip(context, netImage: order.service?.logo, title: showCancelItem ? '' : order.service?.name),
                Gap(8.w),
                infoChip(
                  context,
                  image: Assets.images.distanceLogo,
                  title: showCancelItem ? '' : '${((order.distance ?? 0) / 1000).toStringAsFixed(2)} km',
                  imgColor: ColorPalette.primary50,
                ),
                Gap(8.w),
                infoChip(
                  context,
                  image: Assets.images.watch,
                  title: showCancelItem ? '' : '${((order.duration ?? 0) / 60).toStringAsFixed(2)} min',
                  imgColor: Colors.green,
                  showVerticalDivider: false,
                ),
              ],
            ),
    ],
  );
}

Widget infoChip(
  BuildContext context, {
  String? title,
  AssetGenImage? image,
  String? netImage,
  bool showVerticalDivider = true,
  Color? imgColor,
}) => Expanded(
  child: Row(
    children: [
      image != null
          ? image.image(height: 16.h, width: 16.w, fit: BoxFit.contain, color: imgColor)
          : const SizedBox.shrink(),
      netImage != null
          ? buildNetworkImage(imageUrl: netImage, height: 16.h, width: 16.w, errorIconSize: 8.h, fit: BoxFit.fill)
          : const SizedBox.shrink(),
      Gap(4.w),
      Flexible(
        child: Text(
          title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: context.bodyMedium?.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF687387),
          ),
        ),
      ),
      Gap(showVerticalDivider ? 8.w : 0),
      showVerticalDivider ? Container(height: 8.h, width: 1.w, color: const Color(0xFFD7DAE0)) : const SizedBox.shrink(),
    ],
  ),
);
Widget imageBuilder(String? image, {double height = 40, double width = 40}) => CircleAvatar(
  backgroundColor: ColorPalette.primary50,
  child: Padding(
    padding: const EdgeInsets.all(1),
    child: ClipOval(
      child: image != null
          ? buildNetworkImage(
              imageUrl: image,
              height: height,
              width: width,
              placeholder: buildImagePlaceholder(height, width),
              errorIconSize: 40,
              errorWidget: buildImageError(height, width),
            )
          // CachedNetworkImage(
          //         imageUrl: image,
          //         height: height,
          //         width: width,
          //         fit: BoxFit.cover,
          //         placeholder: (_, _) => buildImagePlaceholder(height, width),
          //         errorWidget: (_, _, _) => buildImageError(height, width),
          //       )
          : const CircleAvatar(backgroundColor: ColorPalette.primary50),
    ),
  ),
);

Widget buildImagePlaceholder(double height, double width) => Container(
  height: height,
  width: width,
  color: Colors.grey[300],
  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
);

Widget buildImageError(double height, double width) => Container(
  height: height,
  width: width,
  decoration: BoxDecoration(image: DecorationImage(image: Assets.images.cancelProfile.provider())),
);
