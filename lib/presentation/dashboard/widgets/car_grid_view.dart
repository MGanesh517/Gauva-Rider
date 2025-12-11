import 'package:flutter/material.dart';
import 'package:gauva_userapp/data/models/ride_service_response.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/car_type_state.dart';
import '../viewmodel/car_type_notifier.dart';
import 'car_type_card.dart';

Widget carGridView({required List<Services> list, required CarTypeNotifier notifier, required CarTypeState state}) {
  // If 4 or fewer items, show in Row (no scroll) - adjust width to screen
  // If more than 4 items, show in ListView (scrollable)
  if (list.length <= 4) {
    return SizedBox(
      height: 120,
      child: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final padding = 16.0 * 2; // Left and right padding from parent
          final spacing = 8.0 * (list.length - 1); // Spacing between cards
          final availableWidth = screenWidth - padding - spacing;
          final cardWidth = (availableWidth / list.length).clamp(80.0, 120.0);
          
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: list.map((type) {
              final isSelected = state.selectedCarType == type;
              return Flexible(
                child: buildCarCard(
                  type,
                  isSelected,
                  notifier,
                  context,
                  cardWidth: cardWidth,
                  onTap: () {
                    notifier.selectCar(type, resetSelectedLocationState: true);
                    Future.delayed(Duration.zero).then((_) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        NavigationService.pushNamed(AppRoutes.searchDestinationPage);
                      });
                    });
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  } else {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final type = list[index];
          final isSelected = state.selectedCarType == type;
          return buildCarCard(
            type,
            isSelected,
            notifier,
            context,
            onTap: () {
              notifier.selectCar(type, resetSelectedLocationState: true);
              Future.delayed(Duration.zero).then((_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  NavigationService.pushNamed(AppRoutes.searchDestinationPage);
                });
              });
            },
          );
        },
      ),
    );
  }
}
