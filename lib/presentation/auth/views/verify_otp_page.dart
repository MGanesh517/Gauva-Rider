import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';

import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/utils/color_palette.dart';
import 'package:gauva_userapp/core/widgets/otp_textfield.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

import '../provider/auth_providers.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_bottom_buttons.dart';

class VerifyOtpPage extends ConsumerStatefulWidget {
  final num? otp;
  const VerifyOtpPage({super.key, this.otp});

  @override
  ConsumerState<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends ConsumerState<VerifyOtpPage> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController otpController = TextEditingController();
  Timer? _timer;
  int secondsRemaining = 60;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    if (widget.otp != null) {
      otpController.text = (widget.otp ?? '').toString();
    }
    _startResendCountdown();
  }

  void _startResendCountdown() {
    setState(() {
      canResend = false;
      secondsRemaining = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        setState(() {
          canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      body: AuthAppBar(
        title: AppLocalizations().otp_title_short,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_sentOtpText(context), Gap(12.h), _buildOtpField(), Gap(24.h), _buildResendButtonOrTimer()],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    ),
  );

  Widget _sentOtpText(BuildContext context) => Consumer(
    builder: (context, ref, _) {
      final loginResponse = ref.watch(loginNotifierProvider).maybeWhen(success: (data) => data, orElse: () => null);
      final bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations().otp_enter_title,
            style: context.bodyMedium?.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? const Color(0xFF687387) : ColorPalette.neutral24,
            ),
          ),
          RichText(
            text: TextSpan(
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                color: const Color(0xFF687387),
                fontWeight: FontWeight.w400,
              ),
              text: '${AppLocalizations().otp_sent_message} ',
              children: [
                TextSpan(
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    color: ColorPalette.primary50,
                    fontWeight: FontWeight.w500,
                  ),
                  text: loginResponse?.data?.mobile,
                ),
              ],
            ),
          ),

          Gap(24.h),
          Text(
            AppLocalizations().otp_input_hint,
            style: context.bodyMedium?.copyWith(
              color: isDarkMode ? const Color(0xFF687387) : const Color(0xFF24262D),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    },
  );

  Widget _buildOtpField() => Center(child: OtpTextField(otpController: otpController, length: 6));

  Widget _buildResendButtonOrTimer() {
    if (canResend) {
      return Consumer(
        builder: (context, ref, _) {
          final resendState = ref.watch(resendOTPNotifierProvider);
          final resendNotifier = ref.read(resendOTPNotifierProvider.notifier);
          final loginResponse = ref.read(loginNotifierProvider).maybeWhen(success: (data) => data, orElse: () => null);

          return Center(
            child: resendState.when(
              initial: () => TextButton(
                onPressed: () {
                  final mobile = loginResponse?.data?.mobile ?? '';
                  resendNotifier.resendOtp(
                    mobile: mobile,
                    onSuccess: (otp) {
                      otpController.text = (otp.data?.otp ?? '').toString();
                    },
                  );
                  _startResendCountdown();
                },
                child: Text(
                  AppLocalizations().otp_resend,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF687387),
                  ),
                ),
              ),

              loading: () => const LoadingView(),
              success: (data) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showNotification(message: data.message, isSuccess: true);
                  resendNotifier.resetStateAfterDelay();
                  _startResendCountdown();
                });
                return const SizedBox.shrink();
              },
              error: (error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showNotification(message: error.message);
                  resendNotifier.resetStateAfterDelay();
                });
                return const SizedBox.shrink();
              },
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text(
          AppLocalizations.of(context).otp_resend_timer(secondsRemaining.toString().padLeft(2, '0')),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF687387),
          ),
        ),
      );
    }
  }

  Widget _buildBottomButtons() => Consumer(
    builder: (context, ref, _) {
      final verifyState = ref.watch(otpVerifyNotifierProvider);
      final verifyNotifier = ref.read(otpVerifyNotifierProvider.notifier);
      final loginResponse = ref.read(loginNotifierProvider).maybeWhen(success: (data) => data, orElse: () => null);

      final isLoading =
          otpController.text.trim().length < 6 || verifyState.maybeWhen(loading: () => true, orElse: () => false);

      return AuthBottomButtons(
        isLoading: isLoading,
        title: '${AppLocalizations().confirm} OTP',
        onTap: () {
          final mobile = loginResponse?.data?.mobile ?? '';
          verifyNotifier.verifyOtp(mobile: mobile, otp: otpController.text.trim());
        },
      );
    },
  );
}
