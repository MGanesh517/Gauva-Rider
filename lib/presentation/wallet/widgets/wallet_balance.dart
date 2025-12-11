import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/wallet/widgets/add_balance_sheet.dart';

import '../../account_page/provider/theme_provider.dart';
import '../../payment_method/provider/provider.dart';

Widget walletBalance(BuildContext context, {num? amount, required TextEditingController customAmountController}) =>
    Container(
      height: 124.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 31.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: context.surface,
        image: DecorationImage(image: Assets.images.walletBg.provider()),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        shape: InputBorder.none,
        title: Text(
          '₹ ${amount ?? 0}',
          style: context.bodyMedium?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: ColorPalette.primary50,
          ),
        ),
        subtitle: Text(
          AppLocalizations.of(context).wallet_balance,
          style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        trailing: Consumer(
          builder: (context, ref, _) => InkWell(
            onTap: () {
              Future.microtask(() {
                ref.read(selectedPayMethodProvider.notifier).reset();
                ref.read(paymentMethodsNotifierProvider.notifier).getPaymentMethods();
              });

              showWalletTopUpModal(
                context,
                customAmountController: customAmountController,
                isDark: ref.read(themeModeProvider.notifier).isDarkMode(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: const Color(0xFF2285D5)),
              child: Icon(Icons.add, color: Colors.white, size: 24.h),
            ),
          ),
        ),
      ),
    );
