import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_back_button.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/account_page/view/account_page.dart';

class AuthAppBar extends ConsumerWidget {
  const AuthAppBar({super.key, this.showLeading = true, this.title, this.child});
  final bool showLeading;
  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Gradient container extending edge to edge
            Container(
              height: 180.h + MediaQuery.of(context).padding.top,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF397098), Color(0xFF942FAF)],
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h, top: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(24.h),
                      showLeading
                          ? Row(
                              children: [
                                // const AppBackButton(color: ColorPalette.neutral100),
                                // SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    title ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.bodyMedium?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Assets.images.rideIn.image(height: 49.h, fit: BoxFit.contain),
                                  // child: Image.asset(Assets.images.rideIn.path, height: 49.h, fit: BoxFit.contain),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: showLeading ? 110.h : 125.h, left: 16.w, right: 16.w, bottom: 16.h),
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(16),
                  color: isDarkMode ? Colors.black : Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
