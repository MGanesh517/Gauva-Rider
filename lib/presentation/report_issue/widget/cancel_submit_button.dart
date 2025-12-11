import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/report_issue/provider/report_provider.dart';

import '../../../generated/l10n.dart';

Widget cancelSubmitButton(
  BuildContext context, {
  required int? orderId,
  required TextEditingController details,
  required String? reportType,
  required bool isDark,
}) => Container(
  color: isDark ? AppColors.surface : Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
  child: Row(
    children: [
      Expanded(
        child: AppPrimaryButton(
          showBorder: false,
          backgroundColor: isDark ? Colors.black : const Color(0xFFF6F7F9),
          onPressed: () {
            NavigationService.pop();
          },
          child: Text(
            AppLocalizations.of(context).cancel,
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      Gap(16.w),
      Consumer(
        builder: (context, ref, _) {
          final submitState = ref.watch(reportSubmitNotifierProvider);
          final submitStateNotifier = ref.watch(reportSubmitNotifierProvider.notifier);
          return Expanded(
            child: AppPrimaryButton(
              isDisabled: submitState.whenOrNull(loading: () => true) ?? false,
              isLoading: submitState.whenOrNull(loading: () => true) ?? false,
              onPressed: () {
                if (orderId == null || details.text.trim().isEmpty || reportType == null) {
                  showNotification(message: AppLocalizations.of(context).insertAllData);
                } else {
                  submitStateNotifier.submitReport(orderId: orderId, details: details.text, reportName: reportType);
                }
              },
              child: Text(
                AppLocalizations.of(context).submit,
                style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          );
        },
      ),
    ],
  ),
);
