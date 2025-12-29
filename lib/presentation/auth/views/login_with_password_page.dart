import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';

import '../../../core/utils/color_palette.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_bottom_buttons.dart';

class LoginWithPasswordPage extends ConsumerStatefulWidget {
  const LoginWithPasswordPage({super.key});

  @override
  ConsumerState<LoginWithPasswordPage> createState() => _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends ConsumerState<LoginWithPasswordPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool codeLengthIsSafe = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      body: AuthAppBar(
        title: AppLocalizations.of(context).password_label,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).login_with_your_password,
              style: context.bodyMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: ColorPalette.neutral24,
              ),
            ),
            Gap(8.h),
            Text(
              AppLocalizations.of(context).use_your_password_here,
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                color: const Color(0xFF687387),
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(24.h),
            Text(
              AppLocalizations.of(context).password_label,
              style: context.bodyMedium?.copyWith(
                color: const Color(0xFF24262D),
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(12.h),
            TextField(
              controller: passwordController,
              onChanged: (v) => setState(() {
                codeLengthIsSafe = v.length >= 6 && v.length <= 16;
              }),
              obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).password_label,
                suffixIcon: CupertinoButton(
                  onPressed: () => setState(() => showPassword = !showPassword),
                  child: Icon(
                    showPassword ? Ionicons.eye : Ionicons.eye_off,
                    color: context.theme.inputDecorationTheme.suffixIconColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final loginWithPassState = ref.watch(loginWithPassNotifierProvider);
          final stateNotifier = ref.read(loginWithPassNotifierProvider.notifier);
          final loginResponse = ref.read(loginNotifierProvider).maybeWhen(success: (data) => data, orElse: () => null);

          final isLoading =
              passwordController.text.trim().length < 6 ||
              loginWithPassState.maybeWhen(loading: () => true, orElse: () => false);

          return AuthBottomButtons(
            isLoading: isLoading,
            title: AppLocalizations.of(context).login,
            onTap: () {
              if (loginResponse?.data?.mobile == null || passwordController.text.trim().isEmpty) {
                showNotification(message: AppLocalizations.of(context).either_phone_number_is_null_or_password_is_empty);
              } else {
                stateNotifier.loginWithPassword(
                  mobile: loginResponse?.data?.mobile ?? '',
                  password: passwordController.text,
                );
              }
            },
          );
        },
      ),
    ),
  );
}
