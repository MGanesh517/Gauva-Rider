import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';

class AppCardSheet extends StatelessWidget {
  final Widget child;
  final bool showHandle;
  final bool isFullScreen;

  const AppCardSheet({super.key, required this.child, this.showHandle = true, this.isFullScreen = false});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16).copyWith(bottom: isIos() ? 24.h : 16),
    decoration: context.responsive(
      BoxDecoration(
        borderRadius: isFullScreen ? null : const BorderRadius.vertical(top: Radius.circular(16)),
        color: isDarkMode() ? context.surface : Colors.white,
        boxShadow: isFullScreen
            ? null
            : const [BoxShadow(color: Color(0x3F0E275D), blurRadius: 20, offset: Offset(2, 4))],
      ),
      xl: const BoxDecoration(),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: const Color(0xFFD7DAE0), borderRadius: BorderRadius.circular(10)),
          height: 4.h,
          width: 40.w,
        ),
        child,
      ],
    ),
  );
}
