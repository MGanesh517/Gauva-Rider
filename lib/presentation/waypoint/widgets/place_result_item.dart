import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';

import '../../../core/utils/color_palette.dart';

class PlaceResultItem extends StatelessWidget {
  final String? title;
  final String subtitle;
  final String? trailing;
  final bool isRecent;
  final VoidCallback? onPressed;
  final bool isDark;

  const PlaceResultItem({
    super.key,
    this.title,
    required this.subtitle,
    this.isRecent = false,
    required this.onPressed,
    this.trailing,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
    onPressed: onPressed,
    padding: const EdgeInsets.all(0),
    minimumSize: const Size(0, 0),
    child: Row(
      children: [
        Assets.images.locationPin.image(height: 24.h, width: 24.w, fit: BoxFit.fill, color: ColorPalette.primary50),
        Gap(20.w),
        Expanded(
          child: Text(
            subtitle,
            style: context.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
        ),
      ],
    ),
  );

  IconData get icon => isRecent ? Ionicons.time : Ionicons.location;

  Color get iconColor => isRecent ? ColorPalette.neutral70 : ColorPalette.tertiary60;
}
