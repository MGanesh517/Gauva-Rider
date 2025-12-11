import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextTheme textTheme(String fontPrimary, String fontSecondary) => TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontPrimary,
        fontSize: 57.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: fontPrimary,
        fontSize: 45.sp,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        fontFamily: fontPrimary,
        fontSize: 36.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontPrimary,
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontPrimary,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontPrimary,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontFamily: fontSecondary,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: fontSecondary,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: fontSecondary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.10,
      ),
      labelLarge: TextStyle(
        fontSize: 16.sp,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.10,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.50,
      ),
      labelSmall: TextStyle(
        fontSize: 12.sp,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.50,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.50,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontFamily: fontSecondary,
        fontWeight: FontWeight.w400,
      ),
    );
