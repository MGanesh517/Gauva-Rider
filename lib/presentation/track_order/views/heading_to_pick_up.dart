import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';

import '../../../generated/l10n.dart';
import '../widgets/driver_details.dart';

Widget headingToPickUp(BuildContext context, Order order, {required bool isDark}) => Column(
  children: [
    driverDetails(context, order.driver, isDark: isDark, otp: order.otp),
    Gap(8.h),
    Text(
      AppLocalizations.of(context).ride_on_the_way,
      style: context.bodyMedium?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
      ),
    ),
    Text(
      AppLocalizations.of(context).driver_heading_to_you,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
    ),
    Gap(8.h),
    Assets.images.headingPickUp.image(height: 160.h, width: double.infinity, fit: BoxFit.fill),
  ],
);
