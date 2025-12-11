import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';

import 'cancel_ride_reason.dart';

void cancelRideDialogue(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    enableDrag: false,
    builder: (context) => SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // handle keyboard overlap
        ),
        child: CancelRideReason(isDark: isDarkMode()),
      ),
    ),
  );
}
