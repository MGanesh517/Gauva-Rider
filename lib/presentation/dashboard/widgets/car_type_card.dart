import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/data/models/ride_service_response.dart';

import '../../../core/theme/color_palette.dart';
import '../viewmodel/car_type_notifier.dart';

Widget buildCarCard(
  Services type,
  bool isSelected,
  CarTypeNotifier notifier,
  BuildContext context, {
  Function()? onTap,
  double? cardWidth,
}) {
  final width = cardWidth ?? 114;
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      width: width,
      constraints: BoxConstraints(minWidth: 70, maxWidth: 120),
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: width < 90 ? 4 : 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? ColorPalette.primary50 : Colors.grey, width: isSelected ? 2 : 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon/Image section with proper constraints
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(width < 90 ? 4 : 6),
              child: Center(
                child: (type.iconUrl != null && type.iconUrl!.isNotEmpty) || (type.logo != null && type.logo!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: buildNetworkImage(
                          imageUrl: type.iconUrl ?? type.logo,
                          height: width < 90 ? 40 : 50,
                          width: width < 90 ? 40 : 50,
                          fit: BoxFit.contain,
                        ),
                      )
                    : type.icon != null && type.icon!.isNotEmpty
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(type.icon!, style: TextStyle(fontSize: width < 90 ? 35 : 45)),
                      )
                    : Icon(Icons.directions_car, size: width < 90 ? 35 : 45, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Text section
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                type.displayNameOrName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: context.bodyMedium?.copyWith(fontSize: width < 90 ? 11.sp : 13.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
