import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gauva_userapp/data/models/ride_service_response.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/car_type_state.dart';
import '../viewmodel/car_type_notifier.dart';
import 'car_type_card.dart';

Widget carGridView({required List<Services> list, required CarTypeNotifier notifier, required CarTypeState state}) {
  // Calculate number of rows needed (3 items per row)
  final rows = (list.length / 3).ceil();
  final height = rows * 120.0 + (rows - 1) * 8.0; // 120 height per row + 8 spacing between rows

  return SizedBox(
    height: height,
    child: Builder(
      builder: (context) {
        // Calculate card width based on screen width and grid layout
        final screenWidth = MediaQuery.of(context).size.width;
        final padding = 16.0 * 2; // Left and right padding from parent
        final spacing = 8.0 * 2; // Spacing between 3 items (2 gaps)
        final availableWidth = screenWidth - padding - spacing;
        final cardWidth = availableWidth / 3; // 3 items per row

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling since it's in a DraggableScrollableSheet
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 8.0, // Horizontal spacing between items
            mainAxisSpacing: 8.0, // Vertical spacing between rows
            childAspectRatio: 1.0, // Adjust based on card width/height ratio
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final type = list[index];
            final isSelected = state.selectedCarType == type;
            return buildCarCard(
              type,
              isSelected,
              notifier,
              context,
              cardWidth: cardWidth.clamp(80.0, 120.0), // Pass calculated width
              onTap: () {
                debugPrint('');
                debugPrint('🚗 ═══════════════════════════════════════════════════════');
                debugPrint('🚗 SERVICE TAPPED');
                debugPrint('🚗 Service ID: ${type.id}');
                debugPrint('🚗 Service Name: ${type.name}');
                debugPrint('🚗 Service Display Name: ${type.displayName}');
                debugPrint('🚗 isIntercity: ${type.isIntercity}');
                debugPrint('🚗 isIntercity == true: ${type.isIntercity == true}');
                debugPrint('🚗 isIntercity runtimeType: ${type.isIntercity.runtimeType}');
                debugPrint('🚗 ═══════════════════════════════════════════════════════');
                debugPrint('');

                // Check if service is intercity (handle null case)
                final isIntercityService = type.isIntercity == true;
                debugPrint('🔍 isIntercityService check result: $isIntercityService');

                if (isIntercityService) {
                  debugPrint('✅ Service is INTERCITY - Navigating to intercity selection page');
                  debugPrint('📍 Route: ${AppRoutes.intercitySelection}');

                  // Use Navigator directly with context to ensure navigation works
                  final navigatorContext = NavigationService.navigatorKey.currentContext;
                  if (navigatorContext != null) {
                    Navigator.pushNamed(navigatorContext, AppRoutes.intercitySelection);
                    debugPrint('✅ Navigation initiated successfully using Navigator.pushNamed');
                  } else {
                    debugPrint('❌ Navigation failed - navigatorKey.currentContext is null');
                    // Fallback: try using NavigationService
                    NavigationService.pushNamed(AppRoutes.intercitySelection);
                  }
                } else {
                  debugPrint('✅ Service is REGULAR - Navigating to destination search');
                  // Regular service - navigate to destination search
                  notifier.selectCar(type, resetSelectedLocationState: true);
                  Future.delayed(Duration.zero).then((_) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      NavigationService.pushNamed(AppRoutes.searchDestinationPage);
                    });
                  });
                }
              },
            );
          },
        );
      },
    ),
  );
}
