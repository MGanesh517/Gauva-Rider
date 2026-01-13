import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/enums/car_view_type.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';

import '../../../core/utils/color_palette.dart';
import '../../../data/models/ride_service_response.dart';

class ServiceItem extends StatelessWidget {
  final Services entity;

  final bool isSelected;
  final Function() onPressed;

  const ServiceItem({
    super.key,
    required this.entity,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Consumer(
      builder: (context, ref, _){
        // PERFORMANCE OPTIMIZATION: Watch only viewType instead of entire state
        final bool isGridView = ref.watch(
          carTypeNotifierProvider.select((state) => state.viewType == CarViewType.grid),
        );

        return Padding(
          padding: isGridView ? EdgeInsets.zero : const EdgeInsets.only(right: 8.0),
          child: CupertinoButton(
            onPressed: onPressed,
            padding: EdgeInsets.zero, minimumSize: const Size(0, 0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: context.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: isGridView ? Row(
                children: [
                  buildNetworkImage(imageUrl: entity.logo, width: 56,
                    height: 48, fit: BoxFit.contain),
                  const SizedBox(width: 12),
                  Expanded(child: description(context, isGridView: isGridView))

                ],
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildNetworkImage(imageUrl: entity.logo, width: 60,
                      height: 48, fit: BoxFit.contain),

                  const SizedBox(width: 12),
                  description(context, isGridView: isGridView)
                ],
              ),
            ),
          ),
        );
      },
    );
  
  Widget description(BuildContext context, {required bool isGridView})=> SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          !isGridView ? Text(entity.name?.capitalize() ?? '', style: context.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,) : const SizedBox.shrink(),
          Row(
            children: [
              !isGridView ? const SizedBox.shrink() : Expanded(
                child: Text(
                  entity.name?.capitalize() ?? '',
                  style: context.labelLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              (entity.totalFare ?? 0) > 0 ? Text(
                '₹${((entity.totalFare ?? 0)+ 5).toStringAsFixed(2)}',
                style: context.titleSmall?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade300,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.grey.shade300,
                ),
              ) : const SizedBox.shrink(),
              Gap(4.w),
              Text(
                '₹${entity.totalFare?.toStringAsFixed(2)}',
                style: context.titleSmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.primary40,
                ),
              ),
            ],
          ),
          Gap(5.h),
          Row(
            children: [
              ...[
                const Icon(
                  Ionicons.person,
                  color: ColorPalette.neutral70,
                  size: 16,
                ),
                Transform.translate(
                  offset: const Offset(0, -3),
                  child: Text(
                    entity.personCapacity.toString(),
                    style: context.bodySmall,
                  ),
                ),
              ],
              Expanded(child: Text('7 min away', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end, style: context.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500, color: ColorPalette.neutral40),))
            ],
          )
        ],
      ),
    );

  Color get borderColor => isSelected ? ColorPalette.primary40 : Colors.grey.shade100;

}
