import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../core/utils/is_arabic.dart';

Widget confirmPay(BuildContext context, Order order, {required bool isDark}) => Column(
  children: [
    Text(
      AppLocalizations.of(context).ride_complete,
      style: context.bodyMedium?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
      ),
    ),
    Text(
      AppLocalizations.of(context).ride_feedback_prompt,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
    ),
    Gap(8.h),
    Assets.images.confirmPay.image(height: 160.h, width: double.infinity, fit: BoxFit.fill),
    Gap(16.h),
    serviceOverView(context, order, isDark: isDark),
    Gap(8.h),
    selectedCashView(isDark),
    Gap(16.h),
    Consumer(
      builder: (context, ref, _) {
        // final state = ref.watch(paymentConfirmNotifierProvider);
        final bool isLoading = false;
        return AppPrimaryButton(
          isLoading: isLoading,
          isDisabled: isLoading,
          onPressed: () {
            handleTripCompletion(ref);
          },
          child: Text(
            AppLocalizations.of(context).confirm_pay,
            style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        );
      },
    ),
  ],
);

Widget selectedCashView(bool isDark) => Container(
  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.r),
    border: Border.all(color: isDark ? Colors.grey.shade700 : const Color(0xFFF1F7FE)),
  ),
  child: Row(
    children: [
      Icon(Icons.payment, color: isDark ? Colors.white70 : const Color(0xFF687387)),
      Gap(12.w),
      Text(
        'Cash Payment',
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF24262D),
        ),
      ),
    ],
  ),
);

Widget serviceOverView(BuildContext context, Order order, {List<Widget>? widgets, required bool isDark}) => Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.r),
    border: Border.all(color: const Color(0xFFF1F7FE)),
  ),
  child: Column(
    children: [
      if (widgets != null) ...widgets,
      Padding(
        padding: EdgeInsets.only(left: 8.0.w, right: 8.w, top: 8.h, bottom: 8.h),
        child: rowText(
          context,
          title: AppLocalizations.of(context).rideCharge,
          value:
              r'$'
              '${order.subTotal?.toString() ?? 0.0}',
          isDark: isDark,
        ),
      ),
      // Padding(
      //   padding: EdgeInsets.all(8.0.r),
      //   child: rowText(
      //     context,
      //     title: AppLocalizations.of(context).service_charge,
      //     value:
      //         r'$'
      //         '${order.service?.baseFare ?? 0.00}', isDark: isDark,
      //   ),
      // ),
      Padding(
        padding: EdgeInsets.only(left: 8.0.w, right: 8.w, bottom: 8.h),
        child: rowText(
          context,
          title: AppLocalizations.of(context).discount,
          value: r'$' + (order.discount ?? 0).toString(),
          isDark: isDark,
        ),
      ),
      Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.r), bottomLeft: Radius.circular(8.r)),
          color: isDark ? Colors.grey.shade900 : ColorPalette.neutralF6,
        ),
        child: rowText(
          context,
          title: AppLocalizations.of(context).total_amount,
          value:
              r'$'
              '${order.payableAmount ?? 0.00}',
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1469B5),
          isDark: isDark,
        ),
      ),
    ],
  ),
);

Widget rowText(
  BuildContext context, {
  required String title,
  value,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  bool showBackground = false,
  Color? backgroundColor,
  Color? rVColor,
  required bool isDark,
}) => Row(
  children: [
    Expanded(
      child: Text(
        title,
        textAlign: isArabic() ? TextAlign.right : TextAlign.left,
        style: context.bodyMedium?.copyWith(
          fontSize: (fontSize ?? 14).sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? (isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E)),
        ),
      ),
    ),
    Expanded(
      child: Container(
        decoration: showBackground
            ? BoxDecoration(borderRadius: BorderRadius.circular(4.r), color: backgroundColor)
            : null,
        child: Text(
          value ?? '',
          textAlign: isArabic() ? TextAlign.left : TextAlign.right,
          style: context.bodyMedium?.copyWith(
            fontSize: (fontSize ?? 14).sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: rVColor ?? color ?? (isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E)),
          ),
        ),
      ),
    ),
  ],
);

void handleTripCompletion(WidgetRef ref) async {
  // Payment is handled as cash by default
  showNotification(message: 'Payment confirmed');
  // TODO: Implement actual payment confirmation logic if needed
}
