import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _baseStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static TextStyle navy24Bold700 = _baseStyle(
    color: const Color(0xFF0A2533),
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );

  static TextStyle gray18Bold800 = _baseStyle(
    color: const Color(0xFFE6EBF2),
    fontSize: 18.sp,
    fontWeight: FontWeight.w800,
    height: 1.10,
  );

  static TextStyle white28Bold800 = _baseStyle(
    color: Colors.white,
    fontSize: 28.sp,
    fontWeight: FontWeight.w800,
    height: 1.10,
  );

  static TextStyle white16Bold700 = _baseStyle(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );

  static TextStyle gray16Bold700 = _baseStyle(
    color: const Color(0xFF97A1B0),
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );

  static TextStyle primary16Bold700 = _baseStyle(
    color: AppColors.primary,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );
  static TextStyle primary14Bold400 = _baseStyle(
    color: AppColors.primary,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );
  static TextStyle secondary14Bold800 = _baseStyle(
    color: AppColors.secondary,
    fontSize: 14.sp,
    fontWeight: FontWeight.w800,
    height: 1.30,
  );
  static TextStyle primary24Bold800 = _baseStyle(
    color: AppColors.primary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w800,
    height: 1.35,
  );
  static TextStyle primary24Bold700 = _baseStyle(
    color: AppColors.primary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.35,
  );
  static TextStyle primary24Bold500 = _baseStyle(
    color: Colors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    height: 1.35,
  );

  static TextStyle primary24Bold400 = _baseStyle(
    color: Colors.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    height: 1.35,
  );

  static TextStyle primary20Bold800 = _baseStyle(
    color: AppColors.primary,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    height: 1.35,
  );
}
