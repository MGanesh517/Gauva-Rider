import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/app.dart';
import 'package:gauva_userapp/core/widgets/connectivity_wrapper.dart';
import 'package:gauva_userapp/data/services/notification_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'data/services/local_storage_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationService().handleBackgroundNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure system UI overlays (status bar and navigation bar) are visible
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  // // Set global system UI overlay style - transparent status bar with light icons
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent, // Transparent status bar
  //     statusBarIconBrightness: Brightness.light, // White icons for dark backgrounds
  //     statusBarBrightness: Brightness.dark, // For iOS
  //     systemNavigationBarColor: Colors.transparent, // Transparent navigation bar
  //     systemNavigationBarIconBrightness: Brightness.light, // Light icons for navigation bar
  //   ),
  // );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Platform.isAndroid) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  }
  await initializeFirebase();
  await dotenv.load();

  await LocalStorageService().init();

  await NotificationService().init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: GlobalConnectivityWrapper(child: MyApp())));
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}
