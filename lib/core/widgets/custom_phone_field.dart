import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';

import '../../generated/l10n.dart';
import '../../presentation/account_page/provider/select_country_provider.dart';
import 'country_code_bottom_sheet.dart';

class AppPhoneNumberTextField extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? initialValue;

  const AppPhoneNumberTextField({super.key, required this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(selectedCountry);
              // Default to India (+91) if no phone code is selected
              final phoneCode = state.selectedPhoneCode?.phoneCode ?? '+91';
              final flag = state.selectedPhoneCode?.flag ?? 'https://flagcdn.com/w320/in.png';

              return InkWell(
                onTap: () async {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const CountryCodeBottomSheet(selectCountryCode: true),
                    isScrollControlled: true,
                  );
                },
                child: Container(
                  height: 48.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.theme.inputDecorationTheme.enabledBorder!.borderSide.color),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildNetworkImage(
                        imageUrl: flag,
                        width: 24.w,
                        height: 24.h,
                        // filterQuality: FilterQuality.high,
                        // isAntiAlias: true,
                      ),
                      Gap(8.w),
                      Text(
                        phoneCode,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF687387),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: FormBuilderTextField(
                name: 'phoneNumber',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10), // Limit input to 10 digits
                ],
                initialValue: initialValue,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.equalLength(10, errorText: "Mobile number must be 10 digits"),
                ]),
                decoration: InputDecoration(
                  hintText: AppLocalizations().enterPhoneNumber,
                  fillColor: context.surface,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
