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
    final carTypeState = ref.watch(carTypeNotifierProvider);
    final carTypeStateNotifier = ref.watch(carTypeNotifierProvider.notifier);

    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: carTypeState.viewType == CarViewType.grid ? Axis.vertical : Axis.horizontal,
      itemCount: data.data?.servicesList?.length,

      itemBuilder: (context, index) {
        final service = data.data?.servicesList ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ServiceItem(
            entity: service[index],
            isSelected: carTypeState.selectedCarType?.id == service[index].id,
            onPressed: () {
              carTypeStateNotifier.selectCar(service[index]);
            },
          ),
        );
      },
    );
  }
}
