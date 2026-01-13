import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/data/models/notification_model/notification_model.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationItem extends ConsumerWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final isUnread = notification.read == false;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: isUnread
              ? Border.all(color: Colors.blue.withOpacity(0.5), width: 1.5)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unread indicator
            if (isUnread)
              Container(
                width: 8.w,
                height: 8.h,
                margin: EdgeInsets.only(top: 6.h, right: 12.w),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              )
            else
              SizedBox(width: 8.w + 12.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notification.title != null && notification.title!.isNotEmpty)
                    Text(
                      notification.title!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  if (notification.title != null && notification.title!.isNotEmpty) Gap(4.h),
                  if (notification.message != null && notification.message!.isNotEmpty)
                    Text(
                      notification.message!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: isDark ? Colors.grey[300] : Colors.grey[700],
                      ),
                    ),
                  if (notification.createdAt != null) ...[
                    Gap(8.h),
                    Text(
                      _formatDate(notification.createdAt!),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Icon
            Icon(
              _getNotificationIcon(notification.type),
              color: isUnread ? Colors.blue : Colors.grey,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String? type) {
    switch (type?.toUpperCase()) {
      case 'RIDE':
      case 'ORDER':
        return Icons.directions_car;
      case 'PAYMENT':
        return Icons.payment;
      case 'PROMOTION':
      case 'OFFER':
        return Icons.local_offer;
      case 'MESSAGE':
      case 'CHAT':
        return Icons.chat_bubble_outline;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}
