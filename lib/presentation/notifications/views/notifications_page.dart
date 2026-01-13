import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_back_button.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/notifications/provider/notification_providers.dart';
import 'package:gauva_userapp/presentation/notifications/widgets/notification_item.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load notifications on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationNotifierProvider.notifier).getNotifications();
      ref.read(unreadCountNotifierProvider.notifier).getUnreadCount();
    });

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh notifications when app comes to foreground
    if (state == AppLifecycleState.resumed) {
      ref.read(notificationNotifierProvider.notifier).getNotifications(refresh: true);
      ref.read(unreadCountNotifierProvider.notifier).refresh();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      _loadMoreNotifications();
    }
  }

  Future<void> _loadMoreNotifications() async {
    if (_isLoadingMore) return;

    final state = ref.read(notificationNotifierProvider);
    state.maybeWhen(
      success: (data) {
        if (data.last == false) {
          // Not last page, load more
          setState(() {
            _isLoadingMore = true;
            _currentPage++;
          });
          ref.read(notificationNotifierProvider.notifier).getNotifications(page: _currentPage, refresh: true).then((_) {
            setState(() {
              _isLoadingMore = false;
            });
          });
        }
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final notificationState = ref.watch(notificationNotifierProvider);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: AppBackButton(color: isDark ? Colors.white : null),
        title: Text(
          'Notifications',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        actions: [
          // Mark all as read button
          Consumer(
            builder: (context, ref, _) {
              final unreadState = ref.watch(unreadCountNotifierProvider);
              final unreadCount = unreadState.maybeWhen(success: (count) => count, orElse: () => 0);

              if (unreadCount > 0) {
                return IconButton(
                  icon: const Icon(Icons.done_all),
                  onPressed: () async {
                    await ref.read(notificationNotifierProvider.notifier).markAllAsRead();
                    ref.read(unreadCountNotifierProvider.notifier).refresh();
                  },
                  tooltip: 'Mark all as read',
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Clear all button
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear All Notifications'),
                  content: const Text('Are you sure you want to delete all notifications?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Clear')),
                  ],
                ),
              );

              if (confirmed == true) {
                await ref.read(notificationNotifierProvider.notifier).clearAllNotifications();
                ref.read(unreadCountNotifierProvider.notifier).refresh();
              }
            },
            tooltip: 'Clear all',
          ),
        ],
      ),
      body: notificationState.when(
        initial: () => const Center(child: LoadingView()),
        loading: () => const Center(child: LoadingView()),
        error: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
              Gap(16.h),
              Text(
                error.message,
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              Gap(16.h),
              ElevatedButton(
                onPressed: () {
                  ref.read(notificationNotifierProvider.notifier).getNotifications();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        success: (data) {
          final notifications = data.content ?? [];

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64.sp, color: Colors.grey),
                  Gap(16.h),
                  Text(
                    'No notifications',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              _currentPage = 0;
              await ref.read(notificationNotifierProvider.notifier).getNotifications(refresh: true);
              ref.read(unreadCountNotifierProvider.notifier).refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16.w),
              itemCount: notifications.length + (_isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == notifications.length) {
                  return const Center(
                    child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
                  );
                }

                final notification = notifications[index];
                return NotificationItem(
                  notification: notification,
                  onTap: () async {
                    if (notification.read == false && notification.id != null) {
                      await ref.read(notificationNotifierProvider.notifier).markAsRead(notification.id!);
                      ref.read(unreadCountNotifierProvider.notifier).refresh();
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
