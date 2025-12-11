import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';

class NavBarItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool selected;
  final EdgeInsets? margin;
  final bool isDark;

  const NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    super.key,
    this.margin,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = selected ? Colors.white : Colors.grey;
    final textColor = selected ? Colors.white : const Color(0xFF565F73);
    final double iconSize = selected ? 24 : 19;

    final iconWidget = ColorFiltered(
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      child: SizedBox(height: iconSize, width: iconSize, child: icon),
    );

    final labelWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontFamily: 'Inter', fontSize: 12.sp, fontWeight: FontWeight.w500, color: textColor),
    );
    return Container(
      constraints: const BoxConstraints(maxWidth: 80, maxHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        gradient: selected
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF397098), Color(0xFF942FAF)],
              )
            : null,
        color: selected
            ? null
            : isDark
            ? AppColors.surface
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: selected
            ? null
            : isDark
            ? Border.all(color: Colors.white, width: 1.w)
            : null,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: iconWidget),
          SizedBox(height: 2.h, width: double.infinity),
          Flexible(child: labelWidget),
        ],
      ),
    );
  }
}
