import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/enums/car_view_type.dart';
import 'package:gauva_userapp/presentation/booking/widgets/service_item.dart';

import '../../../data/models/ride_service_response.dart';
import '../../dashboard/viewmodel/car_type_notifier.dart';

class ServiceList extends ConsumerWidget {
  final RideServiceResponse data;
  const ServiceList({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // PERFORMANCE OPTIMIZATION: Watch only specific values to reduce rebuilds
    final viewType = ref.watch(carTypeNotifierProvider.select((state) => state.viewType));
    final selectedCarId = ref.watch(carTypeNotifierProvider.select((state) => state.selectedCarType?.id));
    final carTypeStateNotifier = ref.read(carTypeNotifierProvider.notifier);

    final servicesList = data.data?.servicesList ?? [];
    final itemCount = servicesList.length;

    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: viewType == CarViewType.grid ? Axis.vertical : Axis.horizontal,
      itemCount: itemCount,
      // PERFORMANCE OPTIMIZATION: Add cacheExtent for better scroll performance
      cacheExtent: 500, // Cache 500 pixels worth of items off-screen
      // PERFORMANCE OPTIMIZATION: Add itemExtent for fixed-height items (if applicable)
      // itemExtent: 120, // Uncomment if all items have same height
      itemBuilder: (context, index) {
        final service = servicesList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ServiceItem(
            entity: service,
            isSelected: selectedCarId == service.id,
            onPressed: () {
              carTypeStateNotifier.selectCar(service);
            },
          ),
        );
      },
    );
  }
}
