import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';
import 'package:gauva_userapp/presentation/track_order/widgets/read_able_location_view.dart';

import '../../booking/provider/order_providers.dart';

void showOrderLocationDetailDialogue(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final order = ref.read(createOrderNotifierProvider);
        final orderData = order.whenOrNull(success: (data) => data.addresses);
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isDarkMode() ? Colors.black12 : null,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              border: isDarkMode() ? Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.2))) : null,
            ),
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(color: const Color(0xFFD7DAE0), borderRadius: BorderRadius.circular(10)),
                      height: 4.h,
                      width: 40.w,
                    ),
                    readAbleLocationView(
                      context,
                      orderData,
                      isDark: isDarkMode(),
                      backGroundColor: isDarkMode() ? Colors.black : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
