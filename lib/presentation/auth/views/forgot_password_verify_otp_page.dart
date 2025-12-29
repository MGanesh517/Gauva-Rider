import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/provider/forgot_password_providers.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_app_bar.dart';
import 'package:gauva_userapp/presentation/auth/widgets/auth_bottom_buttons.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/utils/app_colors.dart';

class ForgotPasswordVerifyOtpPage extends ConsumerStatefulWidget {
  final String email;

  const ForgotPasswordVerifyOtpPage({super.key, required this.email});

  @override
  ConsumerState<ForgotPasswordVerifyOtpPage> createState() => _ForgotPasswordVerifyOtpPageState();
}

class _ForgotPasswordVerifyOtpPageState extends ConsumerState<ForgotPasswordVerifyOtpPage> {
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final state = ref.watch(forgotPasswordNotifierProvider);

    ref.listen(forgotPasswordNotifierProvider, (previous, next) {
      next.whenData((data) {
        if (data.success) {
          // Navigate back to login page
          showNotification(message: 'Password reset successful! Please login with your new password.');
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
        }
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthAppBar(
        title: "Reset Password",
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the 6-digit OTP sent to',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    color: isDark ? Colors.grey[400] : const Color(0xFF687387),
                  ),
                ),
                Gap(4.h),
                Text(
                  widget.email,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : ColorPalette.primary50,
                  ),
                ),
                Gap(24.h),
                // OTP Field
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 8,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '000000',
                    counterText: '',
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      letterSpacing: 8,
                      color: isDark ? Colors.grey[600] : const Color(0xFFE0E0E0),
                    ),
                    filled: true,
                    fillColor: isDark ? AppColors.surface : const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorPalette.primary50, width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the OTP';
                    }
                    if (value.trim().length != 6) {
                      return 'OTP must be 6 digits';
                    }
                    return null;
                  },
                ),
                Gap(24.h),
                // New Password Field
                Text(
                  'New Password',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[400] : const Color(0xFF687387),
                  ),
                ),
                Gap(8.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: TextStyle(fontSize: 16.sp, color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Enter new password',
                    hintStyle: TextStyle(fontSize: 16.sp, color: isDark ? Colors.grey[600] : const Color(0xFF9E9E9E)),
                    filled: true,
                    fillColor: isDark ? AppColors.surface : const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorPalette.primary50, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: isDark ? Colors.grey[600] : const Color(0xFF9E9E9E),
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a new password';
                    }
                    if (value.trim().length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                Gap(16.h),
                // Confirm Password Field
                Text(
                  'Confirm Password',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.grey[400] : const Color(0xFF687387),
                  ),
                ),
                Gap(8.h),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: TextStyle(fontSize: 16.sp, color: isDark ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Confirm new password',
                    hintStyle: TextStyle(fontSize: 16.sp, color: isDark ? Colors.grey[600] : const Color(0xFF9E9E9E)),
                    filled: true,
                    fillColor: isDark ? AppColors.surface : const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: ColorPalette.primary50, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: isDark ? Colors.grey[600] : const Color(0xFF9E9E9E),
                      ),
                      onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                Gap(24.h),
                // Resend OTP
                Center(
                  child: TextButton(
                    onPressed: () {
                      ref.read(forgotPasswordNotifierProvider.notifier).sendOtp(widget.email);
                    },
                    child: Text(
                      'Resend OTP',
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.primary50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: isDark ? AppColors.surface : Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: AuthBottomButtons(
            isLoading: state.isLoading,
            title: 'Reset Password',
            onTap: () {
              if (_formKey.currentState!.validate()) {
                ref
                    .read(forgotPasswordNotifierProvider.notifier)
                    .resetPassword(
                      email: widget.email,
                      otp: _otpController.text.trim(),
                      newPassword: _passwordController.text.trim(),
                    );
              }
            },
          ),
        ),
      ),
    );
  }
}
