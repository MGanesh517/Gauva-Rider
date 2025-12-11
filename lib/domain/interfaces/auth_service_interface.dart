import 'package:dio/dio.dart';

abstract class IAuthService {
  Future<Response> login({required String phone, required String countryCode, String? deviceToken});
  Future<Response> resendSignIn({required num? userId, required String? deviceToken});
  Future<Response> loginWithPassword({
    required String mobile,
    required String password,
    String? deviceToken,
    String? wantLogin,
  });
  Future<Response> verifyOtp({required String mobile, required String otp, String? deviceToken, String? wantLogin});
  Future<Response> updatePassword({required String password});
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required newConfirmPassword,
  });
  Future<Response> updateProfile({required Map<String, dynamic> data});
  Future<Response> resendOTP({required String mobile});
  Future<Response> forgotPassword({required String mobile});
  Future<Response> updateProfilePhoto({required String imagePath});
  Future<Response> riderDetails();
  Future<Response> requestOTP({required String mobile});
  Future<Response> forgetVerifyOtp({required String mobile, required String otp});
  Future<Response> resetPassword({required Map<String, dynamic> data});
  Future<Response> logout();
  Future<Response> signup({
    required String email,
    required String fullName,
    required String password,
    required String phone,
  });
  Future<Response> signInWithGoogle({
    required String idToken,
    String? name,
    String? email,
    String? phone,
    String? deviceToken,
  });
}
