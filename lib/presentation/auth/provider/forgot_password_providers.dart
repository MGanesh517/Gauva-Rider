import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/password_reset_response.dart';
import '../../../data/services/api/dio_client.dart';
import '../../../data/services/forgot_password_service.dart';

// Service provider
final forgotPasswordServiceProvider = Provider<ForgotPasswordService>((ref) {
  return ForgotPasswordService(dioClient: DioClient());
});

// State notifier for forgot password flow
class ForgotPasswordNotifier extends StateNotifier<AsyncValue<PasswordResetResponse>> {
  final ForgotPasswordService service;

  ForgotPasswordNotifier(this.service) : super(AsyncValue.data(PasswordResetResponse(success: false, message: '')));

  Future<void> sendOtp(String email) async {
    state = const AsyncValue.loading();
    try {
      final response = await service.sendOtp(email);
      final result = PasswordResetResponse.fromJson(response.data);
      state = AsyncValue.data(result);
      showNotification(message: result.message);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      showNotification(message: 'Failed to send OTP. Please try again.');
    }
  }

  Future<void> resetPassword({required String email, required String otp, required String newPassword}) async {
    state = const AsyncValue.loading();
    try {
      final response = await service.resetPassword(email: email, otp: otp, newPassword: newPassword);
      final result = PasswordResetResponse.fromJson(response.data);
      state = AsyncValue.data(result);
      showNotification(message: result.message);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      showNotification(message: 'Failed to reset password. Please check your OTP and try again.');
    }
  }

  void reset() {
    state = AsyncValue.data(PasswordResetResponse(success: false, message: ''));
  }
}

// Provider for the notifier
final forgotPasswordNotifierProvider = StateNotifierProvider<ForgotPasswordNotifier, AsyncValue<PasswordResetResponse>>((
  ref,
) {
  final service = ref.watch(forgotPasswordServiceProvider);
  return ForgotPasswordNotifier(service);
});
