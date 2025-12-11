import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../core/utils/change_status_bar.dart';
import '../../account_page/provider/theme_provider.dart';
import '../provider/auth_providers.dart';
import '../widgets/auth_bottom_buttons.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isCurrentVisible = false;
  bool _isNewVisible = false;
  bool _isConfirmVisible = false;

  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  @override
  void dispose() {
    setStatusBar(isDark: isDark);
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(changePasswordProvider.notifier)
          .changePassword(
            currentPassword: _currentPasswordController.text.trim(),
            newPassword: _passwordController.text.trim(),
            newConfirmPassword: _confirmPasswordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          color: isDark ? Colors.white : Colors.white,
          onPressed: () => Navigator.pop(context),
        ),

        title: Text(
          AppLocalizations.of(context).change_password,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white, // Always white
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
      body: Column(
        children: [
          /// Scrollable Form
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  margin: EdgeInsets.only(top: 8.h),
                  color: isDark ? context.surface : Colors.white,
                  child: Column(
                    children: [
                      _buildPasswordField(
                        title: AppLocalizations.of(context).current_password,
                        controller: _currentPasswordController,
                        isVisible: _isCurrentVisible,
                        toggleVisibility: () => setState(() => _isCurrentVisible = !_isCurrentVisible),
                        isDark: isDark,
                      ),
                      Gap(24.h),
                      _buildPasswordField(
                        title: AppLocalizations.of(context).new_password,
                        controller: _passwordController,
                        isVisible: _isNewVisible,
                        toggleVisibility: () => setState(() => _isNewVisible = !_isNewVisible),
                        isDark: isDark,
                      ),
                      Gap(24.h),
                      _buildPasswordField(
                        title: AppLocalizations.of(context).confirm_new_password,
                        controller: _confirmPasswordController,
                        isVisible: _isConfirmVisible,
                        toggleVisibility: () => setState(() => _isConfirmVisible = !_isConfirmVisible),
                        isConfirm: true,
                        isDark: isDark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Fixed Bottom Button
          AuthBottomButtons(
            title: AppLocalizations.of(context).save,
            isLoading: state.whenOrNull(loading: () => true) ?? false,
            onTap: _onSavePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String title,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    bool isConfirm = false,
    required bool isDark,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: context.bodyMedium?.copyWith(
          color: isDark ? Colors.white : const Color(0xFF24262D),
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      Gap(12.h),
      TextFormField(
        controller: controller,
        obscureText: !isVisible,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: title,
          suffixIcon: CupertinoButton(
            onPressed: toggleVisibility,
            padding: EdgeInsets.zero,
            child: Icon(
              isVisible ? Ionicons.eye : Ionicons.eye_off,
              color: context.theme.inputDecorationTheme.suffixIconColor,
            ),
          ),
        ),
        validator: (value) {
          final trimmed = value?.trim() ?? '';
          if (trimmed.isEmpty) {
            return AppLocalizations.of(context).field_required;
          }
          if (trimmed.length < 6) {
            return AppLocalizations.of(context).min_length_error(6);
          }
          if (isConfirm && trimmed != _passwordController.text.trim()) {
            return AppLocalizations.of(context).password_mismatch;
          }
          return null;
        },
      ),
    ],
  );
}
