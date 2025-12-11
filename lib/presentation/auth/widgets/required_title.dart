import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

Widget requiredTitle(BuildContext context, {required String title, bool isRequired = false, required bool isDark}) =>
    RichText(
      text: TextSpan(
        text: title,
        style: context.bodyMedium?.copyWith(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red, fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ]
            : [],
      ),
    );
