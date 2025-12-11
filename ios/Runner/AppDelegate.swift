import Flutter
import UIKit
import GoogleMaps
import Firebase
import FirebaseMessaging

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Google Maps API Key
    GMSServices.provideAPIKey("AIzaSyDNesExi2V6RPZFyBEsH2FWSoefGKIldik")

    // Firebase initialize
    FirebaseApp.configure()

    // Notification delegate সেট করা
    UNUserNotificationCenter.current().delegate = self
    application.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
