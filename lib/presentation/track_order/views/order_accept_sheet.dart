import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/address/address.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/cancel_ride_dialogue.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/driver_details.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/location_time.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/read_able_location_view.dart';
import 'package:gauva_userapp/presentation/waypoint/provider/way_point_list_providers.dart';

import '../../../generated/l10n.dart';

Widget orderAcceptSheet(BuildContext context, Order order, {required bool isDark}) {
  // Calculate distance - handle both meters and kilometers
  final String distance;
  if (order.distance != null) {
    if (order.distance! < 1000) {
      distance = '${order.distance!.toStringAsFixed(0)} m';
    } else {
      distance = '${(order.distance! / 1000).toStringAsFixed(2)} km';
    }
  } else {
    distance = 'N/A';
  }

  // Calculate time - handle both seconds and minutes
  final String time;
  if (order.duration != null) {
    if (order.duration! < 60) {
      time = '${order.duration!.toStringAsFixed(0)} sec';
    } else {
      time = '${(order.duration! / 60).toStringAsFixed(0)} min';
    }
  } else {
    time = 'N/A';
  }

  // Get addresses from order or waypoints
  Addresses? addresses = order.addresses;

  // If addresses are null, try to get from waypoints
  if (addresses == null || addresses.pickupAddress == null || addresses.dropAddress == null) {
    return Consumer(
      builder: (context, ref, _) {
        final waypoints = ref.watch(wayPointListNotifierProvider);

        // Use waypoint addresses if available
        if (waypoints.isNotEmpty) {
          final pickupAddress = waypoints.first.address.isNotEmpty
              ? waypoints.first.address
              : (addresses?.pickupAddress ?? 'Pickup location');
          final dropAddress = waypoints.length > 1 && waypoints.last.address.isNotEmpty
              ? waypoints.last.address
              : (addresses?.dropAddress ?? 'Destination location');

          addresses = Addresses(pickupAddress: pickupAddress, dropAddress: dropAddress);
        }

        return Column(
          children: [
            driverDetails(context, order.driver, isDark: isDark, otp: order.otp),
            Gap(8.h),
            locationTime(context, distance: distance, time: time, isDark: isDark),
            Gap(8.h),
            readAbleLocationView(context, addresses, isDark: isDark, backGroundColor: isDark ? Colors.black : null),
            Gap(16.h),
            _buildCancelButton(context, isDark),
          ],
        );
      },
    );
  }

  return Column(
    children: [
      driverDetails(context, order.driver, isDark: isDark, otp: order.otp),
      Gap(8.h),
      locationTime(context, distance: distance, time: time, isDark: isDark),
      Gap(8.h),
      readAbleLocationView(context, addresses, isDark: isDark, backGroundColor: isDark ? Colors.black : null),
      Gap(16.h),
      _buildCancelButton(context, isDark),
    ],
  );
}

Widget _buildCancelButton(BuildContext context, bool isDark) {
  return AppPrimaryButton(
    onPressed: () {
      cancelRideDialogue(context);
    },
    backgroundColor: context.surface,
    showBorder: isDark ? true : false,
    child: Text(
      AppLocalizations.of(context).cancel_ride,
      style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFFFF5630)),
    ),
  );
}
