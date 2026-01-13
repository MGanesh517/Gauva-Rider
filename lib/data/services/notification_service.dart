import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Android Notification Channel with custom sound enabled
    // IMPORTANT: Changed channel ID to force recreation with custom sound
    // If sound still doesn't play, uninstall and reinstall the app
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel_v3', // Changed ID to force channel recreation with WAV sound
      'High Importance Notifications',
      description: 'Notifications for ride updates and messages',
      importance: Importance.max,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('not'), // Custom sound file (not.wav)
      enableVibration: true,
      showBadge: true,
    );

    // Delete old channels if exists, then create new one with custom sound
    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation != null) {
      // Delete old channels to ensure clean recreation
      await androidImplementation.deleteNotificationChannel('high_importance_channel');
      await androidImplementation.deleteNotificationChannel('high_importance_channel_v2');
      // Create new channel with custom sound
      await androidImplementation.createNotificationChannel(channel);
    }

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS Notification Settings with sound enabled
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Request notification permissions with sound enabled
    await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        showNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(showNotification);
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification != null) {
      // Android notification with custom sound and vibration
      final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel_v3', // Updated to match new channel ID
        'High Importance Notifications',
        channelDescription: 'Notifications for ride updates and messages',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('not'), // Custom sound file (not.wav)
        enableVibration: true,
        showWhen: true,
        icon: '@mipmap/ic_launcher',
      );

      // iOS notification with custom sound
      const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: 'not.wav', // Custom sound file
      );

      final NotificationDetails platformChannelSpecifics = NotificationDetails(
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

  Future<void> showCustomNotification({required String title, required String body}) async {
    // Android notification with custom sound and vibration
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel_v3', // Updated to match new channel ID
      'High Importance Notifications',
      channelDescription: 'Notifications for ride updates and messages',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('not'), // Custom sound file (not.wav)
      enableVibration: true,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    // iOS notification with custom sound
    const DarwinNotificationDetails iosPlatformChannelSpecifics = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'not.wav', // Custom sound file
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
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
