import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/notification_model/notification_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/notification_repo_interface.dart';

class NotificationNotifier extends StateNotifier<AppState<NotificationResponse>> {
  final INotificationRepo notificationRepo;
  final Ref ref;

  NotificationNotifier({required this.ref, required this.notificationRepo})
      : super(const AppState.initial());

  Future<void> getNotifications({
    int page = 0,
    int size = 20,
    bool unreadOnly = false,
    bool refresh = false,
  }) async {
    // Don't show loading if refreshing and we already have data
    if (!refresh || state.maybeWhen(initial: () => true, orElse: () => false)) {
      state = const AppState.loading();
    }

    final result = await notificationRepo.getNotifications(
      page: page,
      size: size,
      unreadOnly: unreadOnly,
    );

    result.fold(
      (failure) {
        state = AppState.error(failure);
        if (!refresh) {
          showNotification(message: failure.message);
        }
      },
      (data) {
        state = AppState.success(data);
      },
    );
  }

  Future<void> markAsRead(int id) async {
    final result = await notificationRepo.markAsRead(id);
    result.fold(
      (failure) {
        showNotification(message: failure.message);
      },
      (_) {
        // Refresh notifications after marking as read
        getNotifications(refresh: true);
      },
    );
  }

  Future<void> markAllAsRead() async {
    final result = await notificationRepo.markAllAsRead();
    result.fold(
      (failure) {
        showNotification(message: failure.message);
      },
      (_) {
        // Refresh notifications after marking all as read
        getNotifications(refresh: true);
      },
    );
  }

  Future<void> clearAllNotifications() async {
    final result = await notificationRepo.clearAllNotifications();
    result.fold(
      (failure) {
        showNotification(message: failure.message);
      },
      (_) {
        // Clear state after clearing notifications
        state = AppState.success(NotificationResponse(content: []));
      },
    );
  }
}

class UnreadCountNotifier extends StateNotifier<AppState<int>> {
  final INotificationRepo notificationRepo;
  
  // PERFORMANCE OPTIMIZATION: Prevent duplicate API calls
  bool _isFetching = false;
  DateTime? _lastFetchTime;
  static const _minFetchInterval = Duration(seconds: 5); // Minimum 5 seconds between calls

  UnreadCountNotifier({required this.notificationRepo}) : super(const AppState.initial());

  Future<void> getUnreadCount() async {
    // PERFORMANCE OPTIMIZATION: Skip if already fetching
    if (_isFetching) {
      debugPrint('⏭️ Unread count fetch skipped - already in progress');
      return;
    }
    
    // PERFORMANCE OPTIMIZATION: Skip if called too recently
    if (_lastFetchTime != null && 
        DateTime.now().difference(_lastFetchTime!) < _minFetchInterval) {
      debugPrint('⏭️ Unread count fetch skipped - called too recently');
      return;
    }
    
    _isFetching = true;
    _lastFetchTime = DateTime.now();
    
    try {
      final result = await notificationRepo.getUnreadCount();
      result.fold(
        (failure) {
          state = AppState.error(failure);
        },
        (count) {
          state = AppState.success(count);
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  void refresh() {
    // Reset last fetch time to allow immediate refresh when explicitly called
    _lastFetchTime = null;
    getUnreadCount();
  }
}
