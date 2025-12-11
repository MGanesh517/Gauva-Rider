import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/change_status_bar.dart';
import 'package:gauva_userapp/core/utils/date_picker.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_bottom_buttons.dart';
import 'package:gauva_userapp/presentation/payment_method/provider/provider.dart';
import 'package:gauva_userapp/presentation/payment_method/widgets/payment_method_dropdown.dart';
import 'package:gauva_userapp/presentation/payment_method/widgets/text_field_with_title.dart';
import 'package:gauva_userapp/presentation/wallet/provider/provider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../../../core/widgets/is_ios.dart';
import '../../account_page/provider/theme_provider.dart';

class CountryModeTest {
  final int id;
  final String value;
  CountryModeTest({required this.id, required this.value});
}

class AddPaymentGateway extends ConsumerStatefulWidget {
  const AddPaymentGateway({super.key});

  @override
  ConsumerState<AddPaymentGateway> createState() => _AddPaymentGatewayState();
}

class _AddPaymentGatewayState extends ConsumerState<AddPaymentGateway> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expDateController = TextEditingController();
  final cvvController = TextEditingController();
  // final countryController = TextEditingController(text: 'Bangladesh');

  List<DropdownMenuItem<CountryModeTest>> countries = [];

  CountryModeTest? selectedCountry;

  late bool _isDark;

  Future<void> _pickDate() async {
    final date = await customDatePickerReturnString(context, dateFormat: DateFormat('MM/yyyy', 'en'));
    if (date != null) {
      expDateController.text = date;
    }
  }

  void setCountries() {
    countries.clear();
    countries = [
      DropdownMenuItem(
        value: CountryModeTest(id: 1, value: 'Bangladesh'),
        child: Text(
          'Bangladesh',
          style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
      ),
      DropdownMenuItem(
        value: CountryModeTest(id: 2, value: 'India'),
        child: Text(
          'India',
          style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
      ),
      DropdownMenuItem(
        value: CountryModeTest(id: 3, value: 'USA'),
        child: Text(
          'USA',
          style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
      ),
      DropdownMenuItem(
        value: CountryModeTest(id: 4, value: 'UK'),
        child: Text(
          'UK',
          style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
      ),
    ];
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(selectedPayMethodProvider.notifier).reset();
      ref.read(paymentMethodsNotifierProvider.notifier).getPaymentMethods();
      setCountries();
    });
  }

  TextStyle? textStyle(BuildContext context) =>
      context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF979899));

  void _onSavePressed() {
    if (_formKey.currentState?.validate() ?? false) {
      final exp = expDateController.text.trim();
      final parts = exp.split('/');

      final expMonth = parts.length == 2 ? parts[0] : '';
      final expYear = parts.length == 2 ? parts[1] : '';

      ref
          .read(addCardProvider.notifier)
          .addCard(
            body: {
              'number': cardNumberController.text.trim(),
              'exp_month': expMonth,
              'exp_year': expYear,
              'cvc': cvvController.text.trim(),
              'address_country': selectedCountry?.value.trim(),
              'name': nameController.text.trim(),
            },
          );
    } else {
      showNotification(message: AppLocalizations.of(context).form_is_not_valid);
    }
  }

  @override
  void dispose() {
    setStatusBar(isDark: _isDark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        AppLocalizations.of(context).add_payment_gateway,
        style: context.bodyMedium?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: _isDark ? Colors.white : Colors.black,
        ),
      ),
    ),
    resizeToAvoidBottomInset: false,
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    // floatingActionButton: AuthBottomButtons(
    //   isLoading:
    //       ref.watch(addCardProvider).whenOrNull(loading: () => true) ?? false,
    //   title: AppLocalizations.of(context).save,
    //   onTap: _onSavePressed,
    // ),
    body: Column(
      children: [
        Expanded(
          child: Container(
            color: _isDark ? AppColors.surface : Colors.white,
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.only(top: 8.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    paymentMethodDropdown(context, isDark: _isDark, isRequired: true),
                    Gap(16.h),
                    textFieldWithTitle(
                      context,
                      isDark: _isDark,
                      label: AppLocalizations.of(context).cardholder_name,
                      controller: nameController,
                      validator: (v) =>
                          v == null || v.isEmpty ? AppLocalizations.of(context).enter_cardholder_name : null,
                    ),
                    textFieldWithTitle(
                      context,
                      isDark: _isDark,
                      label: AppLocalizations.of(context).card_number,
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.length < 12 ? AppLocalizations.of(context).enter_valid_card_number : null,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: textFieldWithTitle(
                            context,
                            isDark: _isDark,
                            label: AppLocalizations.of(context).exp_date,
                            controller: expDateController,
                            readOnly: true,
                            onTap: _pickDate,
                            suffix: const Icon(Icons.calendar_today, size: 20),
                            validator: (v) => v == null || v.isEmpty ? AppLocalizations.of(context).pick_a_date : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: textFieldWithTitle(
                            context,
                            isDark: _isDark,
                            label: AppLocalizations.of(context).cvv,
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            validator: (v) =>
                                v == null || v.length != 3 ? AppLocalizations.of(context).enter_3_digit_cvv : null,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      AppLocalizations.of(context).country,
                      textAlign: TextAlign.start,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: _isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const Gap(6),
                    customDropdown<CountryModeTest>(
                      context,
                      hint: AppLocalizations.of(context).select_a_country,
                      value: selectedCountry,
                      items: countries,
                      onChanged: (value) {
                        selectedCountry = value;
                        setState(() {});
                      },
                      validator: (v) =>
                          v == null || v.value.isEmpty ? AppLocalizations.of(context).select_a_country : null,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      menuPadding: EdgeInsets.only(left: 16.w),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AuthBottomButtons(
          isLoading: ref.watch(addCardProvider).whenOrNull(loading: () => true) ?? false,
          title: AppLocalizations.of(context).save,
          onTap: _onSavePressed,
        ),
        // Gap(isIos() ? 0 : 16.h)
      ],
    ),
  );
}
