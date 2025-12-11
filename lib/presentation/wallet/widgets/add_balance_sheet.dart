import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/wallet/provider/provider.dart';

void showWalletTopUpModal(
  BuildContext context, {
  required TextEditingController customAmountController,
  required bool isDark,
}) {
  customAmountController.clear();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      side: BorderSide(color: Colors.white),
    ),
    backgroundColor: isDark ? context.surface : Colors.white,

    builder: (context) {
      int? selectedAmount;

      return SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 30.h,
              // bottom: 16.h
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Wallet Icon
                  Assets.images.walletBalanceLogo.image(height: 60.h, width: 60.w, fit: BoxFit.fill),
                  Gap(24.h),

                  // Title
                  Text(
                    AppLocalizations.of(context).add_balance_to_your_wallet,
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
                    ),
                  ),
                  Gap(8.h),

                  // Subtitle
                  Text(
                    AppLocalizations.of(context).top_up_your_wallet_securely_and_enjoy_seamless_payments,
                    style: context.bodyMedium?.copyWith(
                      color: const Color(0xFF687387),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(24.h),

                  // Payment Method
                  // paymentMethodDropdown(context, isDark: isDark),
                  // Gap(16.h),
                  SizedBox(
                    height: 50.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: [50, 100, 200, 300].length,
                      separatorBuilder: (_, _) => Gap(12.w),
                      itemBuilder: (context, index) {
                        final amount = [50, 100, 200, 300][index];
                        final isSelected = selectedAmount == amount;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAmount = amount;
                              customAmountController.text = amount.toString();
                            });
                          },
                          child: Container(
                            width: 80.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: isDark ? Colors.black : const Color(0xFFF6F7F9),
                              border: isSelected ? Border.all(color: ColorPalette.primary50) : null,
                            ),
                            child: Text(
                              '₹$amount',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.blue
                                    : isDark
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Gap(16.h),

                  // Custom Amount TextField
                  TextField(
                    controller: customAmountController,
                    keyboardType: TextInputType.number,
                    onTap: () {
                      // If user taps on input, deselect preset buttons
                      if (selectedAmount != null) {
                        setState(() {
                          selectedAmount = null;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).enter_amount,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      // contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    ),
                  ),
                  Gap(24.h),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            AppLocalizations.of(context).cancel,
                            style: context.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorPalette.primary50,
                            ),
                          ),
                        ),
                      ),
                      Gap(12.w),
                      Consumer(
                        builder: (context, ref, _) {
                          final state = ref.watch(walletsNotifierProvider);
                          final notifier = ref.read(walletsNotifierProvider.notifier);
                          final bool isLoading = state.whenOrNull(loading: () => true) ?? false;
                          return Expanded(
                            child: AppPrimaryButton(
                              isLoading: isLoading,
                              isDisabled: isLoading,
                              onPressed: () {
                                final amount = selectedAmount ?? int.tryParse(customAmountController.text.trim());

                                if (amount == null || amount <= 0) {
                                  showNotification(message: AppLocalizations.of(context).enter_a_valid_amount);
                                  return;
                                }
                                notifier.addBalance(amount.toString());
                              },
                              child: Text(
                                AppLocalizations.of(context).add_wallet,
                                style: context.bodyMedium?.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
