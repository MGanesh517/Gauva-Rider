import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

Widget textFieldWithTitle(
  BuildContext context, {
  required bool isDark,
  String? label = '',
  String? Function(String?)? validator,
  required TextEditingController controller,
  bool readOnly = false,
  TextInputType keyboardType = TextInputType.text,
  Function()? onTap,
  Widget? suffix,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      label ?? '',
      style: context.bodyMedium?.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
    const Gap(6),
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
      style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintText: label!.toLowerCase().contains('card no') ? 'Write $label' : label,
        suffixIcon: suffix,
      ),
    ),
    const Gap(16),
  ],
);
