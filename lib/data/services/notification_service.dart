import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await FirebaseMessaging.instance.requestPermission(
      
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(showNotification);
  }

  Future<void> showNotification(RemoteMessage message) async {

    if (message.notification != null) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails();

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title,
        message.notification?.body,
        platformChannelSpecifics,
      );
    }
  }

  Future<void> handleBackgroundNotification(RemoteMessage message) async {
    showNotification(message);
  }

  Future<void> showCustomNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformChannelSpecifics,
    );
  }

}
