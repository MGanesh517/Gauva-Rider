import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/models/notification_model/notification_response.dart';
import 'package:gauva_userapp/data/repositories/notification_repo_impl.dart';
import 'package:gauva_userapp/data/repositories/interfaces/notification_repo_interface.dart';
import 'package:gauva_userapp/data/services/notification_api_service.dart';
import 'package:gauva_userapp/domain/interfaces/notification_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';
import 'package:gauva_userapp/presentation/notifications/view_model/notification_notifier.dart';

// Service Provider
final notificationServiceProvider = Provider<INotificationService>(
  (ref) => NotificationApiService(dioClient: ref.read(dioClientProvider)),
);

// Repo Provider
final notificationRepoProvider = Provider<INotificationRepo>(
  (ref) => NotificationRepoImpl(notificationService: ref.read(notificationServiceProvider)),
);

// View Model Providers
final notificationNotifierProvider = StateNotifierProvider<NotificationNotifier, AppState<NotificationResponse>>(
  (ref) => NotificationNotifier(
    ref: ref,
    notificationRepo: ref.read(notificationRepoProvider),
  ),
);

final unreadCountNotifierProvider = StateNotifierProvider<UnreadCountNotifier, AppState<int>>(
  (ref) => UnreadCountNotifier(
    notificationRepo: ref.read(notificationRepoProvider),
  ),
);
