import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class InAppUpdateService {
  /// Check for app updates and show update dialog if available
  /// This uses Google Play's in-app update API (Android only)
  static Future<void> checkForUpdate(BuildContext context) async {
    // Only check for updates on Android
    if (!Platform.isAndroid) {
      return;
    }

    try {
      // Check if update is available
      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        // Update is available
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update (blocks user until update is complete)
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          // Perform flexible update (allows user to continue using app while downloading)
          await InAppUpdate.startFlexibleUpdate();

          // Listen for download completion
          InAppUpdate.completeFlexibleUpdate()
              .then((_) {
                // Update installed successfully
                debugPrint('Flexible update completed');
              })
              .catchError((error) {
                debugPrint('Error completing flexible update: $error');
              });
        }
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
      // Don't show error to user - silently fail
    }
  }

  /// Check for update with custom dialog (flexible update)
  static Future<void> checkForUpdateWithDialog(BuildContext context) async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (context.mounted) {
          _showUpdateDialog(context, updateInfo);
        }
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
  }

  static void _showUpdateDialog(BuildContext context, AppUpdateInfo updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Available'),
          content: const Text(
            'A new version of the app is available. Please update to get the latest features and improvements.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Later'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                if (updateInfo.immediateUpdateAllowed) {
                  await InAppUpdate.performImmediateUpdate();
                } else if (updateInfo.flexibleUpdateAllowed) {
                  await InAppUpdate.startFlexibleUpdate();
                  await InAppUpdate.completeFlexibleUpdate();
                }
              },
              child: const Text('Update Now'),
            ),
          ],
        );
      },
    );
  }
}
