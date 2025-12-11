import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/cancel_ride_dialogue.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/driver_details.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/location_time.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/read_able_location_view.dart';

import '../../../generated/l10n.dart';

Widget orderAcceptSheet(BuildContext context, Order order, {required bool isDark}) {
  final String distance = order.distance != null ? '${(order.distance! / 1000).toStringAsFixed(2)} km' : 'N/A';
  final String time = order.duration != null ? '${(order.duration! / 60).toStringAsFixed(2)} min' : 'N/A';
  return Column(
    children: [
      driverDetails(context, order.driver, isDark: isDark),
      Gap(8.h),
      locationTime(context, distance: distance, time: time, isDark: isDark),
      Gap(8.h),
      readAbleLocationView(context, order.addresses, isDark: isDark, backGroundColor: isDark ? Colors.black : null),
      Gap(16.h),

      AppPrimaryButton(
        onPressed: () {
          cancelRideDialogue(context);
          // showModalBottomSheet(
          //   context: context,
          //   isDismissible: false,
          //   isScrollControlled: true,
          //   enableDrag: false,
          //   builder: (context) => Padding(
          //       padding: EdgeInsets.only(
          //         bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard overlap
          //       ),
          //       child: CancelRideReason(isDark: isDark,),
          //     ),
          // );
        },
        backgroundColor: context.surface,
        showBorder: isDark ? true : false,
        child: Text(
          AppLocalizations.of(context).cancel_ride,
          style: context.bodyMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFF5630),
          ),
        ),
      ),
    ],
  );
}
