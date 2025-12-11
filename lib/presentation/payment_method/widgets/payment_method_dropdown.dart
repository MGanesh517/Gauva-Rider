import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/error_view.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/models/payment_methods_model/payment_methods_model.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import '../../../core/utils/network_image.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../provider/provider.dart';

Widget paymentMethodDropdown(
  BuildContext context, {
  required bool isDark,
  Function(String v)? onChange,
  final bool isRequired = false,
}) => Consumer(
  builder: (context, ref, _) {
    final state = ref.watch(paymentMethodsNotifierProvider);
    final selectPaymentMethod = ref.read(selectedPayMethodProvider.notifier);
    final selectPaymentMethodState = ref.watch(selectedPayMethodProvider);
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const LoadingView(),
      success: (list) {
        if (list.isEmpty) {
          return Center(child: Text(AppLocalizations.of(context).no_payment_methods_available));
        }
        return customDropdown<PaymentMethods>(
          context,
          hint: AppLocalizations.of(context).select_card_type,
          value: selectPaymentMethodState,
          validator: (v) => isRequired
              ? v == null
                    ? AppLocalizations.of(context).select_card_type
                    : null
              : null,
          autoValidateMode: isRequired ? AutovalidateMode.onUserInteraction : null,
          items: list
              .map(
                (e) => DropdownMenuItem<PaymentMethods>(
                  value: e,
                  child: Row(
                    children: [
                      buildNetworkImage(
                        imageUrl: e.logo,
                        height: 25.h,
                        width: 70.w,
                        fit: BoxFit.fill,
                        errorIconSize: 20.h,
                      ),
                      Gap(12.w),
                      Expanded(
                        child: Text(
                          e.value?.capitalize() ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF687387),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (PaymentMethods? v) {
            if (v != null) {
              selectPaymentMethod.selectPaymentMethod(v);
              onChange?.call(v.id.toString());
            }
          },
        );
      },
      error: (e) => ErrorView(message: e.message),
    );
  },
);
