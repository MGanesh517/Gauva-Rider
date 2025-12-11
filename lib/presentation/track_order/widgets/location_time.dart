import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/theme/color_palette.dart';
import '../../../gen/assets.gen.dart';

Widget locationTime(BuildContext context, {String? time, String? distance, required bool isDark}) => Consumer(
  builder: (context, ref, _) {
    // Default value
    const String timeText = '0 min';
    const String distanceText = '0 km';

    return Row(
      children: [
        infoCard(context, title: distance ?? distanceText, isDark: isDark),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: DottedLine(dashColor: ColorPalette.neutral90, lineThickness: 3, lineLength: 80),
        ),
        infoCard(context, showImage: false, title: time ?? timeText, isDark: isDark),
      ],
    );
  },
);

Widget infoCard(BuildContext context, {bool showImage = true, String? title, required bool isDark}) => Expanded(
  child: Container(
    height: 40.h,
    width: double.infinity,
    padding: EdgeInsets.all(8.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: const Color(0xFFC0DDF7), width: 1.w),
    ),
    child: Row(
      children: [
        showImage
            ? Assets.images.route.image(height: 24.h, width: 24.w, fit: BoxFit.fill)
            : Icon(Ionicons.time_outline, color: const Color(0xFF1469B5), size: 24.r),
        Gap(8.w),
        Expanded(
          child: Text(
            title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
        ),
      ],
    ),
  ),
);
