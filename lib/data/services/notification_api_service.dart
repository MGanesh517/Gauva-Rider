import 'package:dio/dio.dart';
import 'package:gauva_userapp/core/config/api_endpoints.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';
import 'package:gauva_userapp/domain/interfaces/notification_service_interface.dart';

class NotificationApiService implements INotificationService {
  final DioClient dioClient;

  NotificationApiService({required this.dioClient});

  @override
  Future<Response> getNotifications({
    int page = 0,
    int size = 20,
    bool unreadOnly = false,
  }) async {
    return dioClient.dio.get(
      ApiEndpoints.notificationsInbox,
      queryParameters: {
        'page': page,
        'size': size,
        'unreadOnly': unreadOnly,
      },
    );
  }

  @override
  Future<Response> getUnreadCount() async {
    return dioClient.dio.get(ApiEndpoints.unreadCount);
  }

  @override
  Future<Response> markAsRead(int id) async {
    return dioClient.dio.post(ApiEndpoints.markAsRead(id));
  }

  @override
  Future<Response> markAllAsRead() async {
    return dioClient.dio.post(ApiEndpoints.markAllAsRead);
  }

  @override
  Future<Response> clearAllNotifications() async {
    return dioClient.dio.delete(ApiEndpoints.clearNotifications);
  }
}
