import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/presentation/booking/provider/route_providers.dart';

import '../../../generated/l10n.dart';

Widget headingToDestination(BuildContext context, {required bool isDark}) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      AppLocalizations.of(context).ride_started,
      style: context.bodyMedium?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
      ),
    ),
    Text(
      AppLocalizations.of(context).ride_in_progress,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
    ),
    Gap(8.h),
    estimatedTimeWidget(context, isDark: isDark),

    Assets.images.carAnimation.image(height: 200.h, width: 358.w, fit: BoxFit.fill),
  ],
);

Widget estimatedTimeWidget(BuildContext context, {required bool isDark}) => Consumer(
  builder: (context, ref, _) {
    final state = ref.watch(travelInfoNotifierProvider);

    final progress = ref.watch(routeProgressProvider);

    final String timeText = state.time ?? '0 min';
    final String distanceText = state.distance ?? '0 km';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time + Distance Info
        Row(
          children: [
            CircleAvatar(
              radius: 15.r,
              backgroundColor: const Color(0xFFF1F7FE),
              child: Icon(Icons.access_time, color: const Color(0xFF1469B5), size: 20.r),
            ),
            Gap(5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).estimated_time,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF687387),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: timeText,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
                      ),
                      children: [
                        TextSpan(
                          text: ' $distanceText',
                          style: context.bodyMedium?.copyWith(
                            fontSize: 10.sp,
                            color: const Color(0xFF1469B5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Gap(4.h),

        // Progress Bar with Car
        SizedBox(
          height: 50.h,
          child: Stack(
            children: [
              // Light background bar
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF687387) : const Color(0xFFF1F7FE),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),

              // Blue progress bar
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 10.h,
                  width: MediaQuery.of(context).size.width * 0.8 * progress,
                  margin: EdgeInsets.only(top: 1.h), // Optional fine-tune
                  decoration: BoxDecoration(color: const Color(0xFF1469B5), borderRadius: BorderRadius.circular(16.r)),
                ),
              ),

              // Car image
              Positioned(
                left: (progress * MediaQuery.of(context).size.width * 0.8 - 27.5.w).clamp(
                  0.0,
                  MediaQuery.of(context).size.width * 0.8 - 55.w,
                ),
                top: 3.h, // optional: center vertically
                child: Assets.images.carToViewLeftToRight.image(height: 43.h, width: 55.w, fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      ],
    );
  },
);
