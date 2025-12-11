import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/booking/provider/cancel_ride_provider.dart';

import '../../../core/theme/animation_duration.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../core/widgets/buttons/app_radio_button.dart';

class CancelRideReason extends StatefulWidget {
  final bool isDark;
  const CancelRideReason({super.key, required this.isDark});

  @override
  State<CancelRideReason> createState() => _CancelRideReasonState();
}

class _CancelRideReasonState extends State<CancelRideReason> {
  String selectedReason = '';
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
    decoration: BoxDecoration(color: context.surface, borderRadius: BorderRadius.circular(16.r)),
    child: SingleChildScrollView(
      child: AnimatedSwitcher(
        duration: AnimationDuration.pageStateTransitionMobile,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Assets.images.cancel.image(height: 60.h, width: 60.w, fit: BoxFit.fill),
            Gap(24.h),
            Text(
              AppLocalizations.of(context).cancel_title,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: widget.isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
              ),
            ),
            Gap(8.h),
            Text(
              AppLocalizations.of(context).cancel_subtitle,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF687387),
              ),
            ),
            Gap(24.h),
            const Divider(),
            Gap(24.h),
            ...rideCancelReasons.map(
              (e) => CupertinoButton(
                padding: EdgeInsets.zero,

                child: Row(
                  children: [
                    AppRadioButton(
                      groupValue: selectedReason,
                      value: e,
                      onChanged: (value) => setState(() => selectedReason = e),
                    ),
                    Gap(8.w),
                    Expanded(child: Text(e, style: context.labelLarge)),
                  ],
                ),
                onPressed: () => setState(() => selectedReason = e),
              ),
            ),
            Gap(24.h),
            Row(
              children: [
                Expanded(
                  child: AppPrimaryButton(
                    showBorder: false,
                    backgroundColor: const Color(0xFFF1F7FE),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context).go_back_to_ride,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1469B5),
                      ),
                    ),
                  ),
                ),
                Gap(16.w),
                Consumer(
                  builder: (context, ref, _) {
                    final state = ref.watch(cancelRideNotifierProvider);
                    final stateNotifier = ref.read(cancelRideNotifierProvider.notifier);

                    return Expanded(
                      child: AppPrimaryButton(
                        isLoading: state.whenOrNull(loading: () => true) ?? false,
                        backgroundColor: const Color(0xFFEB5A3C),
                        showBorder: false,
                        onPressed: () {
                          stateNotifier.cancelRide();
                        },
                        child: Text(
                          AppLocalizations.of(context).cancel_ride,
                          style: context.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFFFFFFF),
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
  );
}

final List<String> rideCancelReasons = [
  AppLocalizations().reason_driver_late,
  AppLocalizations().reason_wrong_location,
  AppLocalizations().reason_mismatch_info,
  AppLocalizations().reason_changed_mind,
  AppLocalizations().reason_other,
];
