import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/terms_and_privacy_provider.dart';

import '../../../common/error_view.dart';
import '../../../core/theme/color_palette.dart';
import '../../../data/services/navigation_service.dart';
import '../../../gen/assets.gen.dart';

Future<void> termsAndConditionDialogue(
  BuildContext context, {
  bool showTermsAndCondition = true,
  required bool isDark,
}) async {
  final platformInfo = await PackageInfo.fromPlatform();

  if (context.mounted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: isDark ? const BorderSide(color: Colors.white) : BorderSide.none,
        ),
        backgroundColor: context.surface,
        contentPadding: EdgeInsets.all(16.w),
        titlePadding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
        title: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Assets.images.appLogo.image(width: 150.w, height: 150.h),
            ),
            Gap(12.h),
            Text(
              platformInfo.appName,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: ColorPalette.primary50,
              ),
            ),
            Gap(4.h),
            Text(
              'Version: ${platformInfo.version} (Build ${platformInfo.buildNumber})',
              style: context.bodySmall?.copyWith(fontSize: 12.sp, color: Colors.grey),
            ),
          ],
        ),
        content: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(termsAndConditionProvider);
            final policyState = ref.watch(privacyAndPolicyProvider);

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300.h),
              child: Column(
                children: [
                  Gap(8.h),
                  Text(
                    showTermsAndCondition
                        ? AppLocalizations.of(context).terms_conditions
                        : AppLocalizations.of(context).privacy_policy,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                      decoration: TextDecoration.underline,
                      decorationColor: isDark ? Colors.white : Colors.black87,
                      decorationThickness: 1.5,
                    ),
                  ),
                  Gap(8.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          showTermsAndCondition
                              ? state.when(
                                  initial: () => const SizedBox.shrink(),
                                  loading: () => const LoadingView(),
                                  success: (data) => Text(
                                    data.data?.terms ?? 'N/A',
                                    style: context.bodySmall?.copyWith(
                                      fontSize: 14.sp,
                                      color: isDark ? Colors.white : Colors.black87,
                                    ),
                                  ),
                                  error: (e) => ErrorView(message: e.message),
                                )
                              : policyState.when(
                                  initial: () => const SizedBox.shrink(),
                                  loading: () => const LoadingView(),
                                  success: (data) => Text(
                                    data.data?.policy ?? 'N/A',
                                    style: context.bodySmall?.copyWith(
                                      fontSize: 14.sp,
                                      color: isDark ? Colors.white : Colors.black87,
                                    ),
                                  ),
                                  error: (e) => ErrorView(message: e.message),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Gap(16.h),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).all_rights_reserved('© 2025 Gauva.'),
                      textAlign: TextAlign.center,
                      style: context.bodySmall?.copyWith(fontSize: 12.sp, color: ColorPalette.primary50),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        actions: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF397098), const Color(0xFF942FAF)],
                ),
                borderRadius: BorderRadius.circular(10.r),
                border: isDark ? Border.all(color: Colors.white) : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => NavigationService.pop(),
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).close,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
