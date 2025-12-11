import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import '../../../generated/l10n.dart';

Widget detailsField(BuildContext context, TextEditingController controller, {required bool isDark}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      AppLocalizations.of(context).details,
      textAlign: TextAlign.start,
      style: context.bodyMedium?.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : const Color(0xFF24262D),
      ),
    ),
    Gap(12.h),
    TextFormField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        hintText: AppLocalizations.of(context).writeIssueDetails,
        hintStyle: context.bodyMedium?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF687387),
        ),
      ),
    ),
  ],
);
