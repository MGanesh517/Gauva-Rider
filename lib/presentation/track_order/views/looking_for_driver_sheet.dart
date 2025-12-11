import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/cancel_ride_dialogue.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/show_order_location_detail_dialogue.dart';

import '../../../gen/assets.gen.dart';

class LookingForDriverSheet extends ConsumerStatefulWidget {
  const LookingForDriverSheet({super.key});

  @override
  ConsumerState<LookingForDriverSheet> createState() => _LookingForDriverSheetState();
}

class _LookingForDriverSheetState extends ConsumerState<LookingForDriverSheet> {
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? Colors.black87 : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: const Color(0xFFD7DAE0), borderRadius: BorderRadius.circular(10)),
                ),
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).searching_for_driver,
                            style: context.bodyMedium?.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            AppLocalizations.of(context).wait_message,
                            style: context.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: isDark ? Colors.white70 : const Color(0xFF687387),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(12.w),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: isDark ? Colors.white : Colors.black, size: 24.sp),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      style: ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.1))),
                      onSelected: (value) {
                        if (value == 'cancel') {
                          cancelRideDialogue(context);
                        } else if (value == 'details') {
                          showOrderLocationDetailDialogue(context);
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'details',
                          child: Text(
                            AppLocalizations().view_details,
                            style: context.bodyMedium?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'cancel',
                          child: Text(
                            AppLocalizations().cancel_ride,
                            style: context.bodyMedium?.copyWith(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(24.h),
                // Animation
                Center(
                  child: Assets.lottie.searchingDriver.image(height: 150.h, width: 150.w, fit: BoxFit.contain),
                ),
                Gap(16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
