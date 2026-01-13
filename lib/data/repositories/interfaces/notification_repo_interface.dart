import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/notification_model/notification_response.dart';

abstract class INotificationRepo {
  Future<Either<Failure, NotificationResponse>> getNotifications({
    int page = 0,
    int size = 20,
    bool unreadOnly = false,
  });
  
  Future<Either<Failure, int>> getUnreadCount();
  
  Future<Either<Failure, void>> markAsRead(int id);
  
  Future<Either<Failure, void>> markAllAsRead();
  
  Future<Either<Failure, void>> clearAllNotifications();
}
