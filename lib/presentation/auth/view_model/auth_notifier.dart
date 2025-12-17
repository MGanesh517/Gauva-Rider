import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/device_token_firebase.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/reset_password_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/auth_repo_interface.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';
import 'package:gauva_userapp/presentation/profile/provider/rider_details_provider.dart';

import '../../../data/models/common_response.dart';
import '../../../data/models/login_response.dart';
import '../../../data/models/login_with_password_response.dart';
import '../../../data/models/logout_response.dart';
import '../../../data/models/otp_verify_response.dart';
import '../../../data/models/profile_update_response.dart';
import '../../../data/models/resend_otp_model/resend_otp_mode.dart';
import '../../../data/services/local_storage_service.dart';
import '../provider/auth_providers.dart';
import '../widgets/warning.dart';

class LoginNotifier extends StateNotifier<AppState<LoginResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  LoginNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> login({required String phone, required String countryCode}) async {
    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    final result = await authRepo.login(phone: phone, deviceToken: deviceToken, countryCode: countryCode);
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (loginResponse) {
        _handleLoginSuccess(loginResponse, countryCode);
        return state = AppState.success(loginResponse);
      },
    );
  }

  void _handleLoginSuccess(LoginResponse loginResponse, String countryCode) {
    final localStorage = LocalStorageService();
    final isNewUser = loginResponse.data?.isNewRider == true;

    if (isNewUser) {
      showNotification(message: 'otp: ${loginResponse.data?.otp}', isSuccess: true);
      localStorage
        ..savePhoneCode(countryCode)
        ..setRegistrationProgress(AppRoutes.verifyOtp);
      NavigationService.pushNamed(AppRoutes.verifyOtp, arguments: loginResponse.data?.otp);
    } else {
      NavigationService.pushNamed(AppRoutes.loginWithPasswordPage);
    }
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class LoginWithPassNotifier extends StateNotifier<AppState<LoginWithPasswordResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;

  LoginWithPassNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> loginWithPassword({required String mobile, required String password, String? wantLogin}) async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 LOGIN WITH PASSWORD - Starting');
    debugPrint('🔵 Mobile: $mobile');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');

    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    final result = await authRepo.loginWithPassword(
      mobile: mobile,
      password: password,
      deviceToken: deviceToken,
      wantLogin: wantLogin,
    );
    result.fold(
      (failure) {
        debugPrint('🔴 LOGIN WITH PASSWORD FAILED: ${failure.message}');
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) async {
        debugPrint('🟢 LOGIN WITH PASSWORD SUCCESS');
        if (data.data?.otherDevice != null && data.data?.otherDevice == true) {
          final bool? wantLogin = await showWarning();
          if (wantLogin == true) {
            await loginWithPassword(mobile: mobile, password: password, wantLogin: 'yes');
          } else {
            NavigationService.pop();
            resetStateAfterDelay();
          }
          state = AppState.success(data);
          return;
        }
        // Spring Boot: Store accessToken and refreshToken
        final accessToken = data.data?.accessToken ?? data.data?.token ?? '';
        final refreshToken = data.data?.refreshToken ?? '';

        // Ensure token is not empty before saving
        if (accessToken.isEmpty) {
          showNotification(message: 'Login failed: No token received from server');
          state = AppState.error(Failure(message: 'No token received'));
          return;
        }

        await LocalStorageService().saveToken(accessToken);
        if (refreshToken.isNotEmpty) {
          await LocalStorageService().saveRefreshToken(refreshToken);
        }
        await LocalStorageService().saveUser(user: data.data?.user?.toJson() ?? {});
        LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
        ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
        state = AppState.success(data);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ResendSignInNotifier extends StateNotifier<AppState<LoginWithPasswordResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;

  ResendSignInNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> resendSignIn({required num? userId, required String? deviceToken}) async {
    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    final result = await authRepo.resendSignIn(userId: userId, deviceToken: deviceToken);
    // final res = await authRepo.login(phone: phone, countryCode: countryCode)
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
      (data) async {
        showNotification(message: data.message, isSuccess: true);

        // Spring Boot: Store accessToken and refreshToken
        final accessToken = data.data?.accessToken ?? data.data?.token ?? '';
        final refreshToken = data.data?.refreshToken ?? '';
        await LocalStorageService().saveToken(accessToken);
        if (refreshToken.isNotEmpty) {
          await LocalStorageService().saveRefreshToken(refreshToken);
        }
        await LocalStorageService().saveUser(user: data.data?.user?.toJson() ?? {});
        LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
        await ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
        state = AppState.success(data);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class OtpVerifyNotifier extends StateNotifier<AppState<OtpVerifyResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  OtpVerifyNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> verifyOtp({required String mobile, required String otp, String? wantLogin}) async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 VERIFY OTP - Starting');
    debugPrint('🔵 Mobile: $mobile');
    debugPrint('🔵 OTP: $otp');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');

    final String? deviceToken = await deviceTokenFirebase();
    final loginResponse = ref.read(loginNotifierProvider).maybeWhen(success: (data) => data, orElse: () => null);

    state = const AppState.loading();
    final result = await authRepo.verifyOtp(mobile: mobile, otp: otp, deviceToken: deviceToken, wantLogin: wantLogin);
    result.fold(
      (failure) {
        debugPrint('🔴 VERIFY OTP FAILED: ${failure.message}');
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (verifyResponse) async {
        debugPrint('🟢 VERIFY OTP SUCCESS');
        if (verifyResponse.data?.otherDevice == true) {
          final bool? wantLogin = await showWarning();
          if (wantLogin == true) {
            await verifyOtp(mobile: mobile, otp: otp, wantLogin: 'yes');
          } else {
            NavigationService.pop();
            resetStateAfterDelay();
          }
        } else {
          // Spring Boot: Store accessToken and refreshToken
          final accessToken = verifyResponse.data?.accessToken ?? verifyResponse.data?.token ?? '';
          final refreshToken = verifyResponse.data?.refreshToken ?? '';
          await LocalStorageService().saveToken(accessToken);
          debugPrint('✅ Token saved successfully (${accessToken.length} chars)');

          // Verify token was saved
          final savedToken = await LocalStorageService().getToken();
          if (savedToken == null || savedToken.isEmpty) {
            debugPrint('❌ ERROR: Token was not saved properly!');
            showNotification(message: 'Failed to save authentication token');
          } else {
            debugPrint('✅ Token verification: Token exists in storage (${savedToken.length} chars)');
          }

          if (refreshToken.isNotEmpty) {
            await LocalStorageService().saveRefreshToken(refreshToken);
          }
          await LocalStorageService().saveUser(user: verifyResponse.data?.user?.toJson() ?? {});
          if (loginResponse?.data?.isNewRider == true) {
            LocalStorageService().setRegistrationProgress(AppRoutes.setPassword);
            NavigationService.pushNamed(AppRoutes.setPassword);
          } else {
            LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
            ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
          }
        }

        state = AppState.success(verifyResponse);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ResendOtpNotifier extends StateNotifier<AppState<ResendOtpModel>> {
  final IAuthRepo authRepo;
  final Ref ref;

  ResendOtpNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> resendOtp({required String mobile, Function(ResendOtpModel data)? onSuccess}) async {
    state = const AppState.loading();
    final result = await authRepo.resendOTP(mobile: mobile);
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        state = AppState.success(data);
        onSuccess != null ? onSuccess(data) : null;
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class UpdatePassNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  UpdatePassNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> updatePassword({required String password}) async {
    state = const AppState.loading();
    final result = await authRepo.updatePassword(password: password);
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        LocalStorageService().setRegistrationProgress(AppRoutes.setProfile);
        NavigationService.pushNamed(AppRoutes.setProfile);
        state = AppState.success(data);
        showNotification(message: data.message, isSuccess: true);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ChangePasswordNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  ChangePasswordNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required newConfirmPassword,
  }) async {
    state = const AppState.loading();
    final result = await authRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newConfirmPassword: newConfirmPassword,
    );
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        LocalStorageService().clearUser();
        LocalStorageService().clearToken();
        showNotification(message: data.message, isSuccess: true);
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
        state = AppState.success(data);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ProfileUpdateNotifier extends StateNotifier<AppState<ProfileUpdateResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;

  ProfileUpdateNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> updateProfile(
    BuildContext context, {
    required Map<String, dynamic> data,
    bool isUpdatingProfile = false,
  }) async {
    state = const AppState.loading();
    final response = await authRepo.profileUpdate(data: data);
    response.fold(
      (failure) {
        showNotification(message: failure.message);

        return state = AppState.error(failure);
      },
      (data) {
        LocalStorageService().saveUser(user: data.data?.user?.toJson() ?? {});
        showNotification(message: data.message, isSuccess: true);
        if (!isUpdatingProfile) {
          LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
        } else {
          ref.read(riderDetailsNotifierProvider.notifier).getRiderDetails();
          NavigationService.pop();
        }

        state = AppState.success(data);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class LogoutNotifier extends StateNotifier<AppState<LogoutResponse>> {
  final IAuthRepo authRepo;
  LogoutNotifier({required this.authRepo}) : super(const AppState.initial());

  Future<void> logout() async {
    state = const AppState.loading();
    final result = await authRepo.logout();
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        LocalStorageService().clearStorage();
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
        showNotification(message: data.message, isSuccess: true);
        return state = AppState.success(data);
      },
    );
  }
}

class ResetPasswordNotifier extends StateNotifier<AppState<ResetPasswordResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  ResetPasswordNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> resetPassword({required Map<String, dynamic> data}) async {
    state = const AppState.loading();
    final result = await authRepo.resetPassword(data: data);
    result.fold((failure) => state = AppState.error(failure), (data) {
      NavigationService.pushNamed(AppRoutes.login);
      state = AppState.success(data);
      resetStateAfterDelay();
    });
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class SignupNotifier extends StateNotifier<AppState<OtpVerifyResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  SignupNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> signup({
    required String email,
    required String fullName,
    required String password,
    required String phone,
    required String countryCode,
  }) async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 SIGNUP NOTIFIER - Starting signup');
    debugPrint('🔵 Email: $email');
    debugPrint('🔵 Full Name: $fullName');
    debugPrint('🔵 Phone: $phone');
    debugPrint('🔵 Country Code: $countryCode');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');

    state = const AppState.loading();
    await deviceTokenFirebase();
    await LocalStorageService().clearToken();

    final result = await authRepo.signup(email: email, fullName: fullName, password: password, phone: phone);

    result.fold(
      (failure) {
        debugPrint('🔴 SIGNUP FAILED: ${failure.message}');
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (signupResponse) async {
        debugPrint('🟢 SIGNUP SUCCESS');
        debugPrint('🟢 Has Token: ${signupResponse.data?.accessToken != null || signupResponse.data?.token != null}');
        // Spring Boot: Store accessToken and refreshToken
        final accessToken = signupResponse.data?.accessToken ?? signupResponse.data?.token ?? '';
        final refreshToken = signupResponse.data?.refreshToken ?? '';

        if (accessToken.isNotEmpty) {
          await LocalStorageService().saveToken(accessToken);
          if (refreshToken.isNotEmpty) {
            await LocalStorageService().saveRefreshToken(refreshToken);
          }
          await LocalStorageService().saveUser(user: signupResponse.data?.user?.toJson() ?? {});
          LocalStorageService().savePhoneCode(countryCode);

          // Navigate to dashboard or appropriate screen after successful signup
          LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
          ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
          showNotification(message: signupResponse.message ?? 'Signup successful!', isSuccess: true);
          // Navigate to dashboard after successful signup
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
        } else {
          // If no token, signup was successful but user needs to login
          // Save phone code for later use
          LocalStorageService().savePhoneCode(countryCode);

          // Show success message
          showNotification(
            message: signupResponse.message ?? 'Account created successfully! Please login to continue.',
            isSuccess: true,
          );

          // Navigate to login page after successful signup
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
        }

        state = AppState.success(signupResponse);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class GoogleSignInNotifier extends StateNotifier<AppState<LoginWithPasswordResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;

  GoogleSignInNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> signInWithGoogle({required String idToken, String? name, String? email, String? phone}) async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 GOOGLE SIGN-IN NOTIFIER - Starting');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('📥 Input Parameters:');
    debugPrint('   🔑 idToken: ${idToken.substring(0, 30)}... (length: ${idToken.length})');
    debugPrint('   👤 name: $name');
    debugPrint('   📧 email: $email');
    debugPrint('   📱 phone: $phone');

    debugPrint('📱 Step 1: Setting state to loading...');
    state = const AppState.loading();
    
    debugPrint('📱 Step 2: Getting device token...');
    final String? deviceToken = await deviceTokenFirebase();
    debugPrint('   📲 Device Token: ${deviceToken != null ? "${deviceToken.substring(0, 20)}..." : "null"}');
    
    debugPrint('📱 Step 3: Clearing old token from storage...');
    await LocalStorageService().clearToken();
    debugPrint('✅ Step 3: Old token cleared');

    debugPrint('📱 Step 4: Calling auth repository...');
    final result = await authRepo.signInWithGoogle(
      idToken: idToken,
      name: name,
      email: email,
      phone: phone,
      deviceToken: deviceToken,
    );
    
    result.fold(
      (failure) {
        debugPrint('');
        debugPrint('🔴 ═══════════════════════════════════════════════════════');
        debugPrint('🔴 GOOGLE SIGN-IN NOTIFIER - FAILED');
        debugPrint('🔴 Error Message: ${failure.message}');
        debugPrint('🔴 ═══════════════════════════════════════════════════════');
        debugPrint('');
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) async {
        debugPrint('');
        debugPrint('🟢 ═══════════════════════════════════════════════════════');
        debugPrint('🟢 GOOGLE SIGN-IN NOTIFIER - SUCCESS');
        debugPrint('🟢 ═══════════════════════════════════════════════════════');
        debugPrint('📦 Response Data:');
        debugPrint('   📝 Message: ${data.message}');
        debugPrint('   ✅ Has Data: ${data.data != null}');
        
        if (data.data?.otherDevice != null && data.data?.otherDevice == true) {
          debugPrint('⚠️ Other device detected - showing warning...');
          final bool? wantLogin = await showWarning();
          if (wantLogin == true) {
            debugPrint('✅ User wants to login from this device - Retrying...');
            // Retry with wantLogin flag if needed
            await signInWithGoogle(idToken: idToken, name: name, email: email, phone: phone);
          } else {
            debugPrint('❌ User cancelled - Going back');
            NavigationService.pop();
            resetStateAfterDelay();
          }
          state = AppState.success(data);
          return;
        }
        
        debugPrint('📱 Step 5: Extracting tokens from response...');
        // Spring Boot: Store accessToken and refreshToken
        final accessToken = data.data?.accessToken ?? data.data?.token ?? '';
        final refreshToken = data.data?.refreshToken ?? '';
        debugPrint('   🔑 Access Token: ${accessToken.isNotEmpty ? "${accessToken.substring(0, 30)}... (length: ${accessToken.length})" : "EMPTY"}');
        debugPrint('   🔑 Refresh Token: ${refreshToken.isNotEmpty ? "${refreshToken.substring(0, 30)}... (length: ${refreshToken.length})" : "EMPTY"}');

        // Ensure token is not empty before saving
        if (accessToken.isEmpty) {
          debugPrint('❌ Step 5: Access token is EMPTY - Cannot proceed');
          showNotification(message: 'Google sign-in failed: No token received from server');
          state = AppState.error(Failure(message: 'No token received'));
          return;
        }

        debugPrint('✅ Step 5: Tokens extracted successfully');
        
        debugPrint('📱 Step 6: Saving tokens to storage...');
        await LocalStorageService().saveToken(accessToken);
        debugPrint('   ✅ Access token saved');
        
        if (refreshToken.isNotEmpty) {
          await LocalStorageService().saveRefreshToken(refreshToken);
          debugPrint('   ✅ Refresh token saved');
        } else {
          debugPrint('   ⚠️ No refresh token to save');
        }
        
        debugPrint('📱 Step 7: Saving user data...');
        await LocalStorageService().saveUser(user: data.data?.user?.toJson() ?? {});
        debugPrint('   ✅ User data saved');
        debugPrint('   👤 User ID: ${data.data?.user?.id}');
        debugPrint('   👤 User Name: ${data.data?.user?.name}');
        debugPrint('   📧 User Email: ${data.data?.user?.email}');
        
        debugPrint('📱 Step 8: Setting registration progress...');
        LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
        debugPrint('   ✅ Registration progress set to dashboard');
        
        debugPrint('📱 Step 9: Checking trip activity...');
        ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
        debugPrint('   ✅ Trip activity check initiated');
        
        debugPrint('📱 Step 10: Showing success notification...');
        // Show success message
        showNotification(message: 'Google sign-in successful!', isSuccess: true);
        debugPrint('   ✅ Success notification shown');
        
        debugPrint('📱 Step 11: Navigating to dashboard...');
        // Navigate to dashboard after successful Google Sign In
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
        debugPrint('   ✅ Navigation to dashboard initiated');
        
        debugPrint('📱 Step 12: Setting state to success...');
        state = AppState.success(data);
        debugPrint('   ✅ State set to success');
        
        debugPrint('🟢 ═══════════════════════════════════════════════════════');
        debugPrint('🟢 GOOGLE SIGN-IN COMPLETED SUCCESSFULLY');
        debugPrint('🟢 ═══════════════════════════════════════════════════════');
        debugPrint('');
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}
