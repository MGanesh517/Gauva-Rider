import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBar({bool isHome = false, required bool isDark}) {
  // Ensure system UI overlays (status bar and navigation bar) are visible
  WidgetsBinding.instance.addPostFrameCallback((_) {
    try {
      // Show both status bar and navigation bar
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );
      // Set transparent status bar with light icons for gradient backgrounds
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } catch (e) {
      if (true) {}
    }
  });
}

void setDarkStatusBar({Color? color}) {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  // Use transparent to allow app bars to extend behind status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

/// Apply light mode status bar (transparent background + dark icons)
void setLightStatusBar() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  // Use transparent to allow app bars to extend behind status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
