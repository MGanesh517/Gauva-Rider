import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';

import '../../account_page/provider/theme_provider.dart';

class AuthBottomButtons extends ConsumerWidget {
  const AuthBottomButtons({
    super.key,
    this.showBothButtons = false,
    this.onSkip,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });
  final bool showBothButtons;
  final Function()? onSkip;
  final Function() onTap;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();
    return SafeArea(
      bottom: !isIos(),
      child: Container(
        height: 80.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(color: isDark ? AppColors.surface : Colors.white),
        child: AppPrimaryButton(
          isLoading: isLoading,
          onPressed: onTap,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorPalette.neutral100,
            ),
          ),
        ),
      ),
    );
  }
}
