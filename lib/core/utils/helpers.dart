import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

enum MessageType {
  snackBar,
  toast,

}

void showNotification({
  required String? message,
  MessageType type = MessageType.toast,
  bool isSuccess = false,
  String? title,
  Duration duration = const Duration(seconds: 3),
  IconData? icon,
}) {
  final backgroundColor = isSuccess ? ColorPalette.primary50 : Colors.red;
  final iconData =
      icon ?? (isSuccess ? Icons.check_circle_outline : Icons.error_outline);
  final BuildContext? context = NavigationService.navigatorKey.currentContext;
  if(context == null){
    return;
  }
  switch (type) {
    case MessageType.snackBar:
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: duration,
            backgroundColor: backgroundColor,
            behavior: SnackBarBehavior.floating,
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(iconData, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null)
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (title != null) const SizedBox(height: 4),
                      Text(message ?? '', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      break;

    case MessageType.toast:
      Fluttertoast.showToast(
        msg: title != null ? '$title\n$message' : message ?? '',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,

      );
      break;
  }
}
