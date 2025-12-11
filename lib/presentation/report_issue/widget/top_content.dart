import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/generated/l10n.dart';

Widget topContent(BuildContext context, {required bool isDark}) => Column(
  children: [
    Text(
      AppLocalizations.of(context).reportIssueTitle,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
      ),
    ),
    Gap(8.h),
    Text(
      AppLocalizations.of(context).reportIssueSubtitle,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
    ),
  ],
);
