import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/address/address.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/icon_destination.dart';

Widget readAbleLocationView(BuildContext context, Addresses? address, {Color? backGroundColor, required bool isDark}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            getCircleBackground(
              const IconDestination(isPickupPoint: true, color: Color(0xFF1469b5)),
              backgroundColor: isDark ? const Color(0xFF687387) : null,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: DottedLine(
                direction: Axis.vertical,
                dashColor: ColorPalette.neutral90,
                // lineThickness: 1,
                lineLength: 50,
              ),
            ),

            getCircleBackground(
              const IconDestination(color: Color(0xFF1469b5)),
              backgroundColor: isDark ? const Color(0xFF687387) : null,
            ),
          ],
        ),
        Gap(8.w),
        Expanded(
          child: Column(
            children: [
              locationBackground(
                context,
                title: AppLocalizations.of(context).pickup,
                subTitle: address?.pickupAddress,
                backGroundColor: backGroundColor,
                isDark: isDark,
              ),
              Gap(8.h),
              locationBackground(
                context,
                title: AppLocalizations.of(context).destination,
                subTitle: address?.dropAddress,
                backGroundColor: backGroundColor,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ],
    );

Widget getCircleBackground(Widget child, {Color? backgroundColor}) =>
    CircleAvatar(radius: 14.r, backgroundColor: backgroundColor ?? const Color(0xFFF1F7FE), child: child);

Widget locationBackground(
  BuildContext context, {
  required String title,
  String? subTitle,
  Color? backGroundColor,
  required bool isDark,
}) => Container(
  width: double.infinity,
  padding: EdgeInsets.all(12.r),
  decoration: BoxDecoration(
    color: backGroundColor ?? const Color(0xFFF1F7FE),
    borderRadius: BorderRadius.circular(8.r),
    border: Border.all(color: const Color(0xFFE3EEFB), width: 1.w),
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: context.bodyMedium?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1469B5),
        ),
      ),
      Gap(8.h),
      Text(
        subTitle ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
        ),
      ),
    ],
  ),
);
