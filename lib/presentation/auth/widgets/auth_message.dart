import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../core/theme/color_palette.dart';
import '../../../generated/l10n.dart';

Widget authMessage(BuildContext context, {required bool isDarkMode, String? version}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations().helloText,
            style: context.bodyMedium?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: ColorPalette.primary50,
            ),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Text(
            version ?? '',
            textAlign: TextAlign.end,
            style: context.bodyMedium?.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: ColorPalette.primary50,
            ),
          ),
        ),
      ],
    ),
    Gap(4.h),
    Text(
      AppLocalizations().welcomeBack,
      style: context.bodyMedium?.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: isDarkMode ? const Color(0xFF687387) : ColorPalette.neutral24,
      ),
    ),
    Gap(8.h),
    Text(
      AppLocalizations().enterPhoneDes,
      style: context.bodyMedium?.copyWith(fontSize: 16.sp, color: const Color(0xFF687387), fontWeight: FontWeight.w400),
    ),
    Gap(24.h),
    Text(
      AppLocalizations().phoneNo,
      style: context.bodyMedium?.copyWith(
        color: isDarkMode ? const Color(0xFF687387) : const Color(0xFF24262D),
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  ],
);
