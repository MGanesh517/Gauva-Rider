import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/widgets/custom_dropdown.dart';
import 'package:gauva_userapp/data/models/gender_model/gender_model.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/widgets/required_title.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/color_palette.dart';
import '../provider/auth_providers.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_bottom_buttons.dart';

class SetProfilePage extends ConsumerStatefulWidget {
  const SetProfilePage({super.key});

  @override
  ConsumerState<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends ConsumerState<SetProfilePage> {
  final formKey = GlobalKey<FormBuilderState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GenderModel? selectedGender;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    selectedGender = null;
  }

  bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();
  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthAppBar(
        title: AppLocalizations.of(context).profile_info_title,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleSection(isDark: isDark()),
            Gap(24.h),
            FormBuilder(
              key: formKey,
              child: ProfileFormFields(
                nameController: nameController,
                emailController: emailController,
                selectedGender: selectedGender,
                onChanged: (GenderModel v) {
                  selectedGender = v;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final profileUpdateState = ref.watch(profileUpdateNotifierProvider);
          final profileUpdateNotifier = ref.read(profileUpdateNotifierProvider.notifier);

          return AuthBottomButtons(
            isLoading: profileUpdateState.maybeWhen(loading: () => true, orElse: () => false),
            showBothButtons: true,
            onSkip: () {
              LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
              NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
              profileUpdateNotifier.resetStateAfterDelay();
            },
            title: AppLocalizations.of(context).otp_save_button,
            onTap: () {
              if (formKey.currentState?.validate() != true) return;
              formKey.currentState?.save();
              profileUpdateNotifier.updateProfile(context, data: getFormData());
            },
          );
        },
      ),
    ),
  );

  Map<String, dynamic> getFormData() => {
    'name': nameController.text.trim(),
    'email': emailController.text.trim(),
    'gender': selectedGender?.value,
  };
}

class _TitleSection extends StatelessWidget {
  final bool isDark;
  const _TitleSection({required this.isDark});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations().profile_info_subtitle,
        style: context.bodyMedium?.copyWith(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: isDark ? const Color(0xFF687387) : ColorPalette.neutral24,
        ),
      ),
      Gap(8.h),
      Text(
        AppLocalizations().profile_info_description,
        style: context.bodyMedium?.copyWith(
          fontSize: 16.sp,
          color: const Color(0xFF687387),
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

class ProfileFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final GenderModel? selectedGender;
  final Function(GenderModel v) onChanged;

  const ProfileFormFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _LabeledTextField(
        controller: nameController,
        // name: 'name',
        name: AppLocalizations.of(context).name_label.toLowerCase(),
      ),
      const Gap(16),
      _LabeledTextField(
        controller: emailController,
        // label: AppLocalizations.of(context).email_label,
        name: AppLocalizations.of(context).email_label.toLowerCase(),
        isEmail: true,
      ),
      const Gap(16),
      LabeledDropdownField(
        selectedGender: selectedGender,
        label: AppLocalizations.of(context).gender_label,
        name: AppLocalizations.of(context).gender_label.toLowerCase(),
        onChanged: onChanged,
      ),
    ],
  );
}

class _LabeledTextField extends ConsumerWidget {
  final String name;
  final bool isEmail;
  final TextEditingController controller;

  const _LabeledTextField({required this.name, this.isEmail = false, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = isEmail ? AppLocalizations.of(context).email_label : AppLocalizations.of(context).name_label;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        requiredTitle(
          context,
          title: label,
          isRequired: true,
          isDark: ref.read(themeModeProvider.notifier).isDarkMode(),
        ),
        Gap(6.h),
        FormBuilderTextField(
          controller: controller,
          name: name,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(hintText: label, filled: true, fillColor: context.surface),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            if (isEmail) FormBuilderValidators.email(),
          ]),
        ),
      ],
    );
  }
}

class LabeledDropdownField extends ConsumerStatefulWidget {
  final String label;
  final String name;
  final GenderModel? selectedGender;
  final Function(GenderModel v) onChanged;

  const LabeledDropdownField({
    super.key,
    required this.label,
    required this.name,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  ConsumerState<LabeledDropdownField> createState() => _LabeledDropdownFieldState();
}

class _LabeledDropdownFieldState extends ConsumerState<LabeledDropdownField> {
  late GenderModel? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.selectedGender;
  }

  bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      requiredTitle(context, title: widget.label, isRequired: true, isDark: isDark()),
      Gap(6.h),
      customDropdown<GenderModel>(
        context,
        hint: AppLocalizations.of(context).gender_select,
        value: _selectedGender,
        items:
            <GenderModel>[
                  GenderModel(name: AppLocalizations().gender_male, value: 'Male', id: 1),
                  GenderModel(name: AppLocalizations().gender_female, value: 'Female', id: 2),
                  GenderModel(name: AppLocalizations().gender_other, value: 'Other', id: 3),
                ]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name ?? '', style: context.bodyMedium),
                  ),
                )
                .toList(),
        onChanged: (gender) {
          if (gender != null) {
            setState(() {
              _selectedGender = gender;
              widget.onChanged(gender);
            });
          }
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: FormBuilderValidators.required(),
      ),
      // FormBuilderDropdown<GenderModel>(
      //   name: widget.name,
      //   initialValue: _selectedGender,
      //   items: items,
      //   dropdownColor: context.surface,
      //   decoration: InputDecoration(
      //     filled: true,
      //     fillColor: context.surface,
      //   ),
      //   style: context.bodyMedium?.copyWith(
      //     fontSize: 15.sp,
      //     fontWeight: FontWeight.w500,
      //     color: ColorPalette.neutral24,
      //   ),
      //   hint: Text(
      //     AppLocalizations.of(context).gender_select,
      //     style: context.bodyMedium?.copyWith(
      //       fontSize: 15.sp,
      //       fontWeight: FontWeight.w400,
      //     ),
      //   ),
      //   autovalidateMode: AutovalidateMode.onUserInteraction,
      //   validator: FormBuilderValidators.required(),
      //   onChanged: (gender) {
      //     if (gender != null) {
      //       setState(() {
      //         _selectedGender = gender;
      //         widget.onChanged(gender);
      //       });
      //     }
      //   },
      // ),
    ],
  );
}
