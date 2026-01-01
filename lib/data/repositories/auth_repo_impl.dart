import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/forgot_verify_otp_response/forgot_verify_otp_response.dart';
import 'package:gauva_userapp/data/models/request_otp_response/request_otp_response.dart';
import 'package:gauva_userapp/data/models/reset_password_response.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';
import 'package:gauva_userapp/domain/interfaces/auth_service_interface.dart';

import '../../core/errors/failure.dart';
import '../models/common_response.dart';
import '../models/login_response.dart';
import '../models/login_with_password_response.dart';
import '../models/logout_response.dart';
import '../models/otp_verify_response.dart';
import '../models/profile_update_response.dart';
import '../models/resend_otp_model/resend_otp_mode.dart';
import '../models/rider_details_response/rider_details_response.dart';
import 'interfaces/auth_repo_interface.dart';

class AuthRepoImpl extends BaseRepository implements IAuthRepo {
  final IAuthService _authService;

  AuthRepoImpl({required IAuthService authService}) : _authService = authService;

  @override
  Future<Either<Failure, LoginResponse>> login({
    required String phone,
    required String countryCode,
    String? deviceToken,
  }) async => await safeApiCall(() async {
    debugPrint('📱 LOGIN - Phone: $phone, Country: $countryCode');
    final response = await _authService.login(phone: phone, countryCode: countryCode, deviceToken: deviceToken);
    debugPrint('📥 LOGIN Response Data: ${response.data}');
    try {
      final result = LoginResponse.fromJson(response.data);
      debugPrint('✅ LOGIN - Parsed successfully');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 LOGIN - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, LoginWithPasswordResponse>> resendSignIn({
    required num? userId,
    required String? deviceToken,
  }) async => await safeApiCall(() async {
    final response = await _authService.resendSignIn(userId: userId, deviceToken: deviceToken);
    return LoginWithPasswordResponse.fromJson(response.data);
  });

  @override
  Future<Either<Failure, LoginWithPasswordResponse>> loginWithPassword({
    required String mobile,
    required String password,
    String? deviceToken,
    String? wantLogin,
  }) async => await safeApiCall(() async {
    debugPrint('🔐 LOGIN WITH PASSWORD - Mobile: $mobile');
    final response = await _authService.loginWithPassword(
      mobile: mobile,
      password: password,
      deviceToken: deviceToken,
      wantLogin: wantLogin,
    );
    debugPrint('📥 LOGIN WITH PASSWORD Response: ${response.data}');
    try {
      final result = LoginWithPasswordResponse.fromJson(response.data);
      debugPrint('✅ LOGIN WITH PASSWORD - Parsed successfully');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 LOGIN WITH PASSWORD - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      throw Failure(message: 'Failed to parse login response: $e');
    }
  });

  @override
  Future<Either<Failure, OtpVerifyResponse>> verifyOtp({
    required String mobile,
    required String otp,
    String? deviceToken,
    String? wantLogin,
  }) => safeApiCall(() async {
    debugPrint('✉️ VERIFY OTP - Mobile: $mobile, OTP: $otp');
    final response = await _authService.verifyOtp(
      mobile: mobile,
      otp: otp,
      deviceToken: deviceToken,
      wantLogin: wantLogin,
    );
    debugPrint('📥 VERIFY OTP Response: ${response.data}');
    try {
      final result = OtpVerifyResponse.fromJson(response.data);
      debugPrint('✅ VERIFY OTP - Parsed successfully');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 VERIFY OTP - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, CommonResponse>> updatePassword({required String password}) async => safeApiCall(() async {
    final response = await _authService.updatePassword(password: password);
    return CommonResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, CommonResponse>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newConfirmPassword,
  }) async => await safeApiCall(() async {
    final response = await _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newConfirmPassword: newConfirmPassword,
    );
    return CommonResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, ProfileUpdateResponse>> profileUpdate({required Map<String, dynamic> data}) async =>
      safeApiCall(() async {
        final response = await _authService.updateProfile(data: data);
        return ProfileUpdateResponse.fromJson(response.data);
      });

  @override
  Future<Either<Failure, LogoutResponse>> logout() async => safeApiCall(() async {
    final response = await _authService.logout();
    return LogoutResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, ResendOtpModel>> resendOTP({required String mobile}) async => safeApiCall(() async {
    debugPrint('🔄 RESEND OTP - Mobile: $mobile');
    final response = await _authService.resendOTP(mobile: mobile);
    debugPrint('📥 RESEND OTP Response: ${response.data}');
    try {
      final result = ResendOtpModel.fromJson(response.data);
      debugPrint('✅ RESEND OTP - Parsed successfully');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 RESEND OTP - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, CommonResponse>> forgotPassword({required String mobile}) async => safeApiCall(() async {
    final response = await _authService.forgotPassword(mobile: mobile);
    return CommonResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, CommonResponse>> updateProfilePhoto({required String imagePath}) async => safeApiCall(() async {
    final response = await _authService.updateProfilePhoto(imagePath: imagePath);
    return CommonResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, RiderDetailsResponse>> riderDetails() async => safeApiCall(() async {
    debugPrint('👤 GET RIDER DETAILS API CALL');
    final response = await _authService.riderDetails();
    debugPrint('📥 RIDER DETAILS Response: ${response.data}');
    debugPrint('📥 Response Type: ${response.data.runtimeType}');

    try {
      // Check if response is direct user object (Spring Boot returns user directly)
      if (response.data is Map && response.data.containsKey('id') && response.data.containsKey('fullName')) {
        debugPrint('📦 RIDER DETAILS - Direct user object detected, wrapping...');
        // Wrap the user object in expected format
        final wrappedData = {
          'success': true,
          'message': 'User details fetched',
          'data': {
            'user': {
              'id': response.data['id'],
              'name': response.data['fullName'],
              'email': response.data['email'],
              'mobile': response.data['phone'],
              'country_iso': response.data['countryIso'],
              'gender': response.data['gender'],
              'address': response.data['address'],
              'profile_picture': response.data['profilePicture'],
              'email_verified': response.data['emailVerified'],
              'otp_verified': response.data['otpVerified'],
              'status': response.data['status'],
            },
          },
        };
        final result = RiderDetailsResponse.fromMap(wrappedData);
        debugPrint('✅ RIDER DETAILS - Wrapped and parsed successfully');
        debugPrint('✅ User data: ${result.data?.user?.name}');
        return result;
      }

      // Handle normal wrapped response
      final result = RiderDetailsResponse.fromMap(response.data);
      debugPrint('✅ RIDER DETAILS - Parsed successfully');
      debugPrint('✅ User data: ${result.data?.user}');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 RIDER DETAILS - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      debugPrint('🔴 Raw response data: ${response.data}');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, RequestOtpResponse>> requestOTP({required String mobile}) async => safeApiCall(() async {
    final response = await _authService.requestOTP(mobile: mobile);
    return RequestOtpResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, ForgotVerifyOtpResponse>> forgetVerifyOtp({
    required String mobile,
    required String otp,
  }) async => safeApiCall(() async {
    final response = await _authService.forgetVerifyOtp(mobile: mobile, otp: otp);
    return ForgotVerifyOtpResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, ResetPasswordResponse>> resetPassword({required Map<String, dynamic> data}) async =>
      safeApiCall(() async {
        final response = await _authService.resetPassword(data: data);
        return ResetPasswordResponse.fromMap(response.data);
      });

  @override
  Future<Either<Failure, OtpVerifyResponse>> signup({
    required String email,
    required String fullName,
    required String password,
    required String phone,
  }) async => safeApiCall(() async {
    debugPrint('📝 SIGNUP - Email: $email, Phone: $phone, Name: $fullName');
    final response = await _authService.signup(email: email, fullName: fullName, password: password, phone: phone);
    debugPrint('📥 SIGNUP Response: ${response.data}');
    try {
      final result = OtpVerifyResponse.fromJson(response.data);
      debugPrint('✅ SIGNUP - Parsed successfully');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 SIGNUP - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, LoginWithPasswordResponse>> signInWithGoogle({
    required String idToken,
    String? name,
    String? email,
    String? phone,
    String? deviceToken,
  }) async => await safeApiCall(() async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 AUTH REPOSITORY - GOOGLE SIGN-IN');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('📥 Input Parameters:');
    debugPrint('   🔑 idToken: ${idToken.substring(0, 30)}... (length: ${idToken.length})');
    debugPrint('   👤 name: $name');
    debugPrint('   📧 email: $email');
    debugPrint('   📱 phone: $phone');
    debugPrint('   📲 deviceToken: ${deviceToken != null ? "${deviceToken.substring(0, 20)}..." : "null"}');

    debugPrint('📤 Calling auth service...');
    final response = await _authService.signInWithGoogle(
      idToken: idToken,
      name: name,
      email: email,
      phone: phone,
      deviceToken: deviceToken,
    );

    debugPrint('📥 Response received from service:');
    debugPrint('   📊 Status Code: ${response.statusCode}');
    debugPrint('   📦 Response Data: ${response.data}');
    debugPrint('   📦 Response Type: ${response.data.runtimeType}');

    debugPrint('🔄 Parsing response...');
    try {
      final result = LoginWithPasswordResponse.fromJson(response.data);
      debugPrint('✅ GOOGLE SIGN-IN - Parsed successfully');
      debugPrint('   ✅ Message: ${result.message}');
      debugPrint('   ✅ Has Data: ${result.data != null}');
      if (result.data != null) {
        debugPrint('   ✅ Has Access Token: ${result.data?.accessToken != null}');
        debugPrint('   ✅ Has Refresh Token: ${result.data?.refreshToken != null}');
        debugPrint('   ✅ Has User: ${result.data?.user != null}');
        if (result.data?.user != null) {
          debugPrint('   ✅ User ID: ${result.data?.user?.id}');
          debugPrint('   ✅ User Name: ${result.data?.user?.name}');
          debugPrint('   ✅ User Email: ${result.data?.user?.email}');
        }
      }
      debugPrint('🔵 ═══════════════════════════════════════════════════════');
      debugPrint('');
      return result;
    } catch (e, stackTrace) {
      debugPrint('');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('🔴 GOOGLE SIGN-IN - PARSING ERROR');
      debugPrint('🔴 Error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      debugPrint('🔴 Raw response data: ${response.data}');
      debugPrint('🔴 ═══════════════════════════════════════════════════════');
      debugPrint('');
      rethrow;
    }
  });
  @override
  Future<Either<Failure, CommonResponse>> submitFcmToken({required String fcmToken}) async => safeApiCall(() async {
    final response = await _authService.submitFcmToken(fcmToken: fcmToken);
    return CommonResponse.fromMap(response.data);
  });
}
