import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/notification_model/notification_response.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';
import 'package:gauva_userapp/data/repositories/interfaces/notification_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/notification_service_interface.dart';

class NotificationRepoImpl extends BaseRepository implements INotificationRepo {
  final INotificationService notificationService;

  NotificationRepoImpl({required this.notificationService});

  @override
  Future<Either<Failure, NotificationResponse>> getNotifications({
    int page = 0,
    int size = 20,
    bool unreadOnly = false,
  }) async {
    return await safeApiCall(() async {
      // PERFORMANCE: Removed verbose debug prints (saves 10-50ms per request)
      final response = await notificationService.getNotifications(
        page: page,
        size: size,
        unreadOnly: unreadOnly,
      );
      
      try {
        // Handle both paginated response and direct array
        dynamic responseData = response.data;
        NotificationResponse result;
        
        if (responseData is Map && responseData.containsKey('content')) {
          // Paginated response
          result = NotificationResponse.fromJson(responseData as Map<String, dynamic>);
        } else if (responseData is List) {
          // Direct array response
          result = NotificationResponse.fromJson({
            'content': responseData,
            'totalElements': responseData.length,
            'totalPages': 1,
            'size': responseData.length,
            'number': 0,
            'first': true,
            'last': true,
          });
        } else {
          throw Exception('Unexpected response format');
        }
        
        return result;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('🔴 GET NOTIFICATIONS - Parsing error: $e');
        }
        rethrow;
      }
    });
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    return await safeApiCall(() async {
      // PERFORMANCE: Removed verbose debug prints
      final response = await notificationService.getUnreadCount();
      
      try {
        dynamic responseData = response.data;
        int count = 0;
        
        if (responseData is Map && responseData.containsKey('count')) {
          count = (responseData['count'] as num?)?.toInt() ?? 0;
        } else if (responseData is int) {
          count = responseData;
        } else if (responseData is num) {
          count = responseData.toInt();
        }
        
        return count;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('🔴 UNREAD COUNT - Parsing error: $e');
        }
        rethrow;
      }
    });
  }

  @override
  Future<Either<Failure, void>> markAsRead(int id) async {
    return await safeApiCall(() async {
      // PERFORMANCE: Removed verbose debug prints
      await notificationService.markAsRead(id);
    });
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    return await safeApiCall(() async {
      // PERFORMANCE: Removed verbose debug prints
      await notificationService.markAllAsRead();
    });
  }

  @override
  Future<Either<Failure, void>> clearAllNotifications() async {
    return await safeApiCall(() async {
      // PERFORMANCE: Removed verbose debug prints
      await notificationService.clearAllNotifications();
    });
  }
}
