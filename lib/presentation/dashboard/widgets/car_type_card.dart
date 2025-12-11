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
      constraints: BoxConstraints(
        minWidth: 70,
        maxWidth: 120,
      ),
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
          Flexible(
            flex: 2,
            child: type.icon != null && type.icon!.isNotEmpty
                ? Center(child: Text(type.icon!, style: TextStyle(fontSize: width < 90 ? 40 : 50)))
                : buildNetworkImage(
                    imageUrl: type.iconUrl ?? type.logo,
                    height: width < 90 ? 50 : 60,
                    width: width < 90 ? 50 : 60,
                    fit: BoxFit.contain,
                  ),
          ),
          const SizedBox(height: 4),
          Flexible(
            flex: 1,
            child: Text(
              type.displayNameOrName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: context.bodyMedium?.copyWith(
                fontSize: width < 90 ? 12.sp : 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
