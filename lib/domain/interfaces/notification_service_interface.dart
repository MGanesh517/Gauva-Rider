import 'package:dio/dio.dart';

abstract class INotificationService {
  Future<Response> getNotifications({
    int page = 0,
    int size = 20,
    bool unreadOnly = false,
  });
  
  Future<Response> getUnreadCount();
  
  Future<Response> markAsRead(int id);
  
  Future<Response> markAllAsRead();
  
  Future<Response> clearAllNotifications();
}
