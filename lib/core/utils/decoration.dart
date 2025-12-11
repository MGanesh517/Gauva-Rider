import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

InputDecorationTheme inputDecorationDarkTheme() => InputDecorationTheme(
    fillColor: AppColors.offWhite,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: TextStyle(
      color: const Color(0xFF97A1B0),
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide.none,
    ),
  );
