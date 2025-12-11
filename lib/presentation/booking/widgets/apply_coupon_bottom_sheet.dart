import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';

import '../../../core/widgets/buttons/app_close_button.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../generated/l10n.dart';
import '../provider/ride_services_providers.dart';

class ApplyCouponBottomSheet extends StatefulWidget {
  const ApplyCouponBottomSheet({super.key});

  @override
  State<ApplyCouponBottomSheet> createState() => _ApplyCouponBottomSheetState();
}

class _ApplyCouponBottomSheetState extends State<ApplyCouponBottomSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isCouponFieldEmpty = true;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildHeader(context),
                buildFooter(context),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child:
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppCloseButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),)
        ],
      ),
    );

  Widget buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Assets.images.couponCircle.image(height: 60.h, width: 60.w, fit: BoxFit.fill),
            Gap(10.h),
            Text(
              AppLocalizations.of(context).add_coupon_code,
              style: context.headlineSmall?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700,),
            ),
            Gap(10.h),
            Text(
              AppLocalizations.of(context).coupon_description,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF687387),
              ),
            ),
          ],
        ),
      );

  Widget buildFooter(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'coupon_code',
                focusNode: _focusNode,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).enter_coupon_code,
                  labelStyle: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
                  prefixIcon: Assets.images.coupon.image(height: 24.h, width: 24.w, fit: BoxFit.fill,),
                  fillColor: context.surface
                ),
                onChanged: (value) {
                  setState(() => isCouponFieldEmpty = value == null || value.isEmpty);
                },
              ),
              Gap(26.h),
              Consumer(builder: (context, ref, _) => AppPrimaryButton(
                  isDisabled: isCouponFieldEmpty,
                  isLoading: ref.watch(applyCouponProvider).whenOrNull(loading: ()=> true) ?? false,
                  child: Text(
                    AppLocalizations.of(context).apply,
                    style: context.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    _formKey.currentState?.save();
                    ref.read(applyCouponProvider.notifier).applyCoupon(coupon: _formKey.currentState?.value['coupon_code']);
                    // final riderServiceFilter =
                    //       _formKey.currentState?.value['coupon_code'],
                    //     );


                  },
                )),
              Gap(isIos() ? 24.h : 16.h)
            ],
          ),
        ),
      );
}
