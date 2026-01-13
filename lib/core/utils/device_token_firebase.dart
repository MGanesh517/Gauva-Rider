import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> deviceTokenFirebase() async => Platform.isIOS
    ? await iosDeviceToken()
    : await FirebaseMessaging.instance.getToken();

Future<String?> iosDeviceToken()async{
  // Request notification permissions with sound enabled
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  final token = await FirebaseMessaging.instance.getAPNSToken();
  // print("🔥 FCM Token: $token");
  return token;

}