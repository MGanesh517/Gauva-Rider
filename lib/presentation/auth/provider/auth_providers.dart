import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/config/environment.dart';
import 'package:gauva_userapp/data/models/reset_password_response.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';
import 'package:gauva_userapp/data/services/auth_service.dart';
import 'package:gauva_userapp/domain/interfaces/auth_service_interface.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/login_response.dart';
import '../../../data/models/login_with_password_response.dart';
import '../../../data/models/logout_response.dart';
import '../../../data/models/otp_verify_response.dart';
import '../../../data/models/profile_update_response.dart';
import '../../../data/models/resend_otp_model/resend_otp_mode.dart';
import '../../../data/repositories/auth_repo_impl.dart';
import '../../../data/repositories/interfaces/auth_repo_interface.dart';
import '../view_model/auth_notifier.dart';

// DioClint provider to provide DioClient instance
final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final dioClientChattingProvider = Provider<DioClient>((ref) => DioClient(baseUrl: '${Environment.baseUrl}/api'));

// Service Provider
final authServiceProvider = Provider<IAuthService>((ref) => AuthService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final authRepoProvider = Provider<IAuthRepo>((ref) => AuthRepoImpl(authService: ref.watch(authServiceProvider)));

// View Model Providers
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, AppState<LoginResponse>>(
  (ref) => LoginNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final loginWithPassNotifierProvider = StateNotifierProvider<LoginWithPassNotifier, AppState<LoginWithPasswordResponse>>(
  (ref) => LoginWithPassNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final resendSignInProvider = StateNotifierProvider<ResendSignInNotifier, AppState<LoginWithPasswordResponse>>(
  (ref) => ResendSignInNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final logoutNotifierProvider = StateNotifierProvider<LogoutNotifier, AppState<LogoutResponse>>(
  (ref) => LogoutNotifier(authRepo: ref.read(authRepoProvider)),
);

final otpVerifyNotifierProvider = StateNotifierProvider.autoDispose<OtpVerifyNotifier, AppState<OtpVerifyResponse>>(
  (ref) => OtpVerifyNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final resendOTPNotifierProvider = StateNotifierProvider<ResendOtpNotifier, AppState<ResendOtpModel>>(
  (ref) => ResendOtpNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final updatePasswordNotifierProvider = StateNotifierProvider<UpdatePassNotifier, AppState<CommonResponse>>(
  (ref) => UpdatePassNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final changePasswordProvider = StateNotifierProvider.autoDispose<ChangePasswordNotifier, AppState<CommonResponse>>(
  (ref) => ChangePasswordNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final profileUpdateNotifierProvider = StateNotifierProvider<ProfileUpdateNotifier, AppState<ProfileUpdateResponse>>(
  (ref) => ProfileUpdateNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final resetPasswordNotifierProvider =
    StateNotifierProvider.autoDispose<ResetPasswordNotifier, AppState<ResetPasswordResponse>>(
      (ref) => ResetPasswordNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
    );

final signupNotifierProvider = StateNotifierProvider.autoDispose<SignupNotifier, AppState<OtpVerifyResponse>>(
  (ref) => SignupNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);

final googleSignInNotifierProvider = StateNotifierProvider<GoogleSignInNotifier, AppState<LoginWithPasswordResponse>>(
  (ref) => GoogleSignInNotifier(ref: ref, authRepo: ref.read(authRepoProvider)),
);
