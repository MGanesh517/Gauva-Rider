import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/get_version.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_app_bar.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_bottom_buttons.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/custom_phone_field.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../generated/l10n.dart';
import '../../account_page/provider/select_country_provider.dart';
import '../provider/auth_providers.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPhoneValidLength = false;
  String phoneNumber = '';
  String version = '';
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() => loadVersion());
    });
  }

  Future<void> loadVersion() async {
    version = await getVersion();
    setState(() {});
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthAppBar(
        showLeading: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Hello...',
                        style: context.bodyMedium?.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.primary50,
                        ),
                      ),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: Text(
                        version,
                        textAlign: TextAlign.end,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.primary50,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(4.h),
                Text(
                  'Create Account',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: ref.read(themeModeProvider.notifier).isDarkMode()
                        ? const Color(0xFF687387)
                        : ColorPalette.neutral24,
                  ),
                ),
                Gap(8.h),
                Text(
                  'Enter your details to create a new account and start your journey.',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    color: const Color(0xFF687387),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Gap(12.h),
            FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  // Full Name Field
                  FormBuilderTextField(
                    name: 'fullName',
                    controller: fullNameController,
                    decoration: InputDecoration(hintText: 'Full Name', prefixIcon: const Icon(Icons.person_outline)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  // Email Field
                  FormBuilderTextField(
                    name: 'email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email Address', prefixIcon: const Icon(Icons.email_outlined)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  // Phone Number Field
                  AppPhoneNumberTextField(
                    initialValue: '',
                    onChanged: (value) {
                      if (value != null) {
                        phoneNumber = value;
                        setState(() {
                          isPhoneValidLength = value.length >= 6;
                        });
                      }
                    },
                  ),
                  Gap(16.h),
                  // Password Field
                  FormBuilderTextField(
                    name: 'password',
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  // Confirm Password Field
                  FormBuilderTextField(
                    name: 'confirmPassword',
                    controller: confirmPasswordController,
                    obscureText: obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(signupNotifierProvider);
            final stateNotifier = ref.read(signupNotifierProvider.notifier);

            return Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthBottomButtons(
                    isLoading: state.when(
                      initial: () => false,
                      loading: () => true,
                      success: (data) => false,
                      error: (e) => false,
                    ),
                    onSkip: () {
                      NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
                    },
                    title: 'Sign Up',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      if (phoneNumber.trim().length < 6) {
                        showNotification(message: AppLocalizations().phoneMinLengthError);
                        return;
                      }

                      // Get country code
                      String? phoneCode = ref.read(selectedCountry).selectedPhoneCode?.phoneCode;
                      if (phoneCode == null) {
                        phoneCode = await LocalStorageService().getPhoneCode();
                      }
                      if (phoneCode == null || phoneCode.isEmpty) {
                        phoneCode = '+91'; // Default to India
                      }

                      // Check password match
                      if (passwordController.text != confirmPasswordController.text) {
                        showNotification(message: 'Passwords do not match', isSuccess: false);
                        return;
                      }

                      stateNotifier.signup(
                        email: emailController.text.trim(),
                        fullName: fullNameController.text.trim(),
                        password: passwordController.text,
                        phone: phoneNumber,
                        countryCode: phoneCode,
                      );
                    },
                  ),
                  // Back to Login Link
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: context.bodyMedium?.copyWith(fontSize: 14.sp, color: const Color(0xFF687387)),
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService.pop();
                          },
                          child: Text(
                            'Log In',
                            style: context.bodyMedium?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.primary50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
