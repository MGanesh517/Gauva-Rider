import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/provider/forgot_password_providers.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_app_bar.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_bottom_buttons.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/utils/app_colors.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final state = ref.watch(forgotPasswordNotifierProvider);

    ref.listen(forgotPasswordNotifierProvider, (previous, next) {
      next.whenData((data) {
        if (data.success) {
          // Navigate to OTP verification page
          NavigationService.pushNamed(AppRoutes.forgotPasswordVerifyOtp, arguments: _emailController.text.trim());
        }
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthAppBar(
        title: "Forgot Password",
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your email address',
                style: context.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: isDark ? Colors.grey[400] : const Color(0xFF687387),
                ),
              ),
              Gap(16.h),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 16.sp, color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: TextStyle(fontSize: 16.sp, color: isDark ? Colors.grey[600] : const Color(0xFF9E9E9E)),
                  filled: true,
                  fillColor: isDark ? AppColors.surface : const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: ColorPalette.primary50, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!_isValidEmail(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              Text(
                'We will send a 6-digit OTP to your email address to reset your password.',
                style: context.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: isDark ? Colors.grey[500] : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: isDark ? AppColors.surface : Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: AuthBottomButtons(
            isLoading: state.isLoading,
            title: 'Send OTP',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                ref.read(forgotPasswordNotifierProvider.notifier).sendOtp(_emailController.text.trim());
              }
            },
          ),
        ),
      ),
    );
  }
}
