import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/decoration.dart';
import '../utils/text_style.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: AppTextStyles.navy24Bold700,
  ),
  inputDecorationTheme: inputDecorationDarkTheme(),
);
