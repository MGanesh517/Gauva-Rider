import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../core/utils/color_palette.dart';
import '../../account_page/provider/theme_provider.dart';
import '../provider/auth_providers.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_bottom_buttons.dart';
import '../widgets/required_title.dart';

class SetPasswordPage extends ConsumerStatefulWidget {
  const SetPasswordPage({super.key});

  @override
  ConsumerState<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends ConsumerState<SetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;
  bool codeLengthIsSafe = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool isDark() => ref.watch(themeModeProvider) == ThemeMode.dark;

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      body: AuthAppBar(
        title: AppLocalizations().password_label,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations().password_hint,
                style: context.bodyMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark() ? const Color(0xFF687387) : ColorPalette.neutral24,
                ),
              ),
              Gap(8.h),
              Text(
                AppLocalizations.of(context).password_requirements(6.toString()),
                style: context.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  color: const Color(0xFF687387),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(24.h),

              // Password Field
              _buildPasswordField(
                title: AppLocalizations().password_label,
                controller: _passwordController,
                isVisible: showPassword,
                toggleVisibility: () => setState(() => showPassword = !showPassword),
                onChanged: (value) {
                  setState(() {
                    codeLengthIsSafe = value.length >= 6 && value.length <= 16;
                  });
                },
              ),

              Gap(20.h),

              // Confirm Password Field
              _buildPasswordField(
                title: AppLocalizations().confirm_password,
                controller: _confirmPasswordController,
                isVisible: showConfirmPassword,
                toggleVisibility: () => setState(() => showConfirmPassword = !showConfirmPassword),
                isConfirm: true,
              ),
            ],
          ),
        ),
      ),

      // Bottom Save Button
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final updatePassState = ref.watch(updatePasswordNotifierProvider);
          final notifier = ref.read(updatePasswordNotifierProvider.notifier);

          final isLoading = updatePassState.maybeWhen(loading: () => true, orElse: () => false);

          return AuthBottomButtons(
            isLoading: isLoading,
            title: AppLocalizations().otp_save_button,
            onTap: () {
              final isValid = _formKey.currentState?.validate() ?? false;
              if (!isValid) return;

              final password = _passwordController.text.trim();
              final confirmPassword = _confirmPasswordController.text.trim();

              if (password != confirmPassword) {
                showNotification(message: AppLocalizations().password_mismatch);
                return;
              }

              notifier.updatePassword(password: password);
            },
          );
        },
      ),
    ),
  );

  Widget _buildPasswordField({
    required String title,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    ValueChanged<String>? onChanged,
    bool isConfirm = false,
    bool isRequired = true,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      requiredTitle(context, title: title, isRequired: isRequired, isDark: isDark()),
      Gap(12.h),
      TextFormField(
        controller: controller,
        obscureText: !isVisible,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: title,
          filled: true,
          fillColor: context.surface,
          suffixIcon: CupertinoButton(
            onPressed: toggleVisibility,
            child: Icon(
              isVisible ? Ionicons.eye : Ionicons.eye_off,
              color: context.theme.inputDecorationTheme.suffixIconColor,
            ),
          ),
        ),
        validator: (value) {
          final trimmed = value?.trim() ?? '';
          if (trimmed.isEmpty) {
            return AppLocalizations().field_required;
          }

          if (trimmed.length < 6) {
            return AppLocalizations.of(context).password_requirements('6');
          }

          if (isConfirm && trimmed != _passwordController.text.trim()) {
            return AppLocalizations().password_mismatch;
          }

          return null;
        },
      ),
    ],
  );
}
