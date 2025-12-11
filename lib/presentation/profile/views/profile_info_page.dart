import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_primary_button.dart';
import 'package:gauva_userapp/core/widgets/custom_dropdown.dart';
import 'package:gauva_userapp/data/models/gender_model/gender_model.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/auth/widgets/required_title.dart';

import '../../../common/error_view.dart';
import '../../../common/loading_view.dart';
import '../../../core/utils/change_status_bar.dart';
import '../../account_page/provider/theme_provider.dart';
import '../../auth/provider/auth_providers.dart';
import '../provider/rider_details_provider.dart';
import '../widgets/avatar_select_button.dart';

class ProfileInfoPage extends ConsumerStatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  ConsumerState<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends ConsumerState<ProfileInfoPage> {
  final _formKey = GlobalKey<FormState>();

  List<GenderModel> genderItems = <GenderModel>[
    GenderModel(id: 1, value: 'Male', name: AppLocalizations().gender_male),
    GenderModel(id: 2, value: 'Female', name: AppLocalizations().gender_female),
    GenderModel(id: 3, value: 'Other', name: AppLocalizations().gender_other),
  ];

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  GenderModel? selectedGender;

  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  @override
  void dispose() {
    setStatusBar(isDark: isDark);
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Fetch rider details if not already loaded
    Future.microtask(() {
      ref.read(riderDetailsNotifierProvider.notifier).getRiderDetails();
    });
  }

  void _populateFields(dynamic userData) {
    if (userData == null) return;

    final user = userData.data?.user;
    if (user != null) {
      // Only update if values are different to avoid cursor jumping
      if (nameController.text != (user.name ?? '')) {
        nameController.text = user.name ?? '';
      }
      if (mobileController.text != (user.mobile ?? '')) {
        mobileController.text = user.mobile ?? '';
      }
      if (emailController.text != (user.email ?? '')) {
        emailController.text = user.email ?? '';
      }

      // Set gender if available
      if (user.gender != null) {
        for (var g in genderItems) {
          if (g.value.toLowerCase() == user.gender?.toLowerCase()) {
            if (selectedGender != g) {
              selectedGender = g;
            }
            break;
          }
        }
      }

      if (mounted) {
        setState(() {});
      }
    }
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Prepare update data - phone is not included as it cannot be changed
      final updateData = <String, dynamic>{'fullName': nameController.text.trim(), 'email': emailController.text.trim()};

      // Add gender if selected
      if (selectedGender != null) {
        updateData['gender'] = selectedGender?.value.toLowerCase();
      }

      ref.read(profileUpdateNotifierProvider.notifier).updateProfile(context, data: updateData, isUpdatingProfile: true);
    }
  }

  void onchange(GenderModel? value) {
    setState(() {
      if (value != null) {
        selectedGender = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(riderDetailsNotifierProvider);

    // Populate fields when data becomes available or when data changes
    state.maybeWhen(
      success: (data) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _populateFields(data);
        });
      },
      orElse: () {},
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: isDark ? Colors.white : Colors.white,
          onPressed: () => Navigator.pop(context),
        ),

        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).my_profile,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.white,
          ),
        ),

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF397098), Color(0xFF942FAF)],
            ),
          ),
        ),

        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 8.h, width: double.infinity, color: isDark ? Colors.black : const Color(0xFFF6F7F9)),
            state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const LoadingView(),
              success: (data) => Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    color: isDark ? context.surface : Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AvatarSelectButton(avatarPath: data.data?.user?.profilePicture),
                          Gap(16.h),
                          _buildTextField(
                            context,
                            title: AppLocalizations.of(context).full_name,
                            controller: nameController,
                            isDark: isDark,
                            keyboardType: TextInputType.name,
                          ),
                          Gap(16.h),
                          _buildTextField(
                            context,
                            readOnly: true,
                            enabled: false, // Disable phone field as it cannot be changed
                            title: AppLocalizations.of(context).mobile_number,
                            controller: mobileController,
                            isDark: isDark,
                            keyboardType: TextInputType.number,
                          ),
                          Gap(16.h),
                          _buildTextField(
                            context,
                            title: AppLocalizations.of(context).email_label,
                            controller: emailController,
                            isDark: isDark,
                          ),
                          Gap(16.h),

                          LabeledDropdownField(
                            selectedGender: selectedGender,
                            items: genderItems,
                            label: AppLocalizations().gender_label,
                            name: AppLocalizations().gender_label.toLowerCase(),
                            onChanged: onchange,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              error: (e) => ErrorView(message: e.message),
            ),
            Container(
              padding: EdgeInsets.all(12.r),
              width: double.infinity,
              color: isDark ? Colors.black : Colors.white,
              child: AppPrimaryButton(
                onPressed: _saveProfile,
                child: Text(
                  AppLocalizations.of(context).save,
                  style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required bool isDark,
    bool readOnly = false,
    bool enabled = true,
    TextInputType? keyboardType,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      requiredTitle(context, title: title, isRequired: true, isDark: isDark),
      Gap(12.h),
      TextFormField(
        controller: controller,
        readOnly: readOnly,
        enabled: enabled,
        keyboardType: keyboardType,
        style: context.bodyMedium?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: enabled ? const Color(0xFF687387) : const Color(0xFF687387).withOpacity(0.5), // Dimmed when disabled
        ),
        decoration: InputDecoration(
          filled: !enabled,
          fillColor: enabled ? null : (isDark ? Colors.grey.shade900 : Colors.grey.shade100),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            (value == null || value.trim().isEmpty) ? AppLocalizations.of(context).field_required : null,
      ),
    ],
  );
}

class LabeledDropdownField extends StatelessWidget {
  final GenderModel? selectedGender;
  final String label;
  final String name;
  final List<GenderModel> items;
  final ValueChanged<GenderModel?> onChanged;
  final bool isDark;

  const LabeledDropdownField({
    required this.selectedGender,
    required this.label,
    required this.name,
    required this.items,
    required this.onChanged,
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      requiredTitle(context, title: label, isRequired: true, isDark: isDark),
      Gap(12.h),
      customDropdown<GenderModel>(
        context,
        value: selectedGender,
        items: items
            .map(
              (e) => DropdownMenuItem<GenderModel>(
                value: e,
                child: Text(
                  e.name ?? '',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF687387),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? AppLocalizations.of(context).field_required : null,
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    ],
  );
}
