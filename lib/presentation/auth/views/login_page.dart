import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_app_bar.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_bottom_buttons.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_message.dart';
import 'package:gauva_userapp/presentation/auth/widgets/google_sign_in_button.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_phone_field.dart';
import '../../../data/models/login_response.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../generated/l10n.dart';
import '../../account_page/provider/select_country_provider.dart';
import '../provider/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();

  bool isPhoneValidLength = false;

  String phoneNumber = '';
  // String version = '';

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Future.microtask(() => loadVersion());
  //   });
  // }

  // Future<void> loadVersion() async {
  //   version = await getVersion();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthAppBar(
        showLeading: false,
        title: "Login",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            authMessage(context, isDarkMode: ref.read(themeModeProvider.notifier).isDarkMode()),
            Gap(12.h),
            FormBuilder(
              key: formKey,
              child: AppPhoneNumberTextField(
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
            ),
            Gap(12.h),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(loginNotifierProvider);
            final stateNotifier = ref.read(loginNotifierProvider.notifier);
            final isDark = ref.read(themeModeProvider.notifier).isDarkMode();

            // handle navigation
            return Container(
              color: isDark ? AppColors.surface : Colors.white,
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
                    title: AppLocalizations().loginSignup,
                    onTap: () async {
                      if (phoneNumber.trim().length < 6) {
                        showNotification(message: AppLocalizations().phoneMinLengthError);
                        return;
                      }
                      // Try to get phone code from selected country, fallback to saved phone code, or use default
                      String phoneCode =
                          ref.read(selectedCountry).selectedPhoneCode?.phoneCode ??
                          await LocalStorageService().getPhoneCode();
                      if (phoneCode.isEmpty) {
                        // Final fallback to default (India +91)
                        phoneCode = '+91';
                      }
                      final String phone = phoneNumber;
                      stateNotifier.login(phone: phone, countryCode: phoneCode);
                    },
                  ),
                  // Gap(8.h),
                  GoogleSignInButton(),
                  // Sign Up Link
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h, top: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: context.bodyMedium?.copyWith(fontSize: 14.sp, color: const Color(0xFF687387)),
                        ),
                        GestureDetector(
                          onTap: () {
                            NavigationService.pushNamed(AppRoutes.signup);
                          },
                          child: Text(
                            'Sign Up',
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

  bool isNewRider(LoginResponse response) => response.data?.isNewRider ?? false;
}
