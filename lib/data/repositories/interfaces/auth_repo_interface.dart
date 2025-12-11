import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/request_otp_response/request_otp_response.dart';
import 'package:gauva_userapp/data/models/reset_password_response.dart';

import '../../../core/errors/failure.dart';
import '../../models/common_response.dart';
import '../../models/forgot_verify_otp_response/forgot_verify_otp_response.dart';
import '../../models/login_response.dart';
import '../../models/login_with_password_response.dart';
import '../../models/logout_response.dart';
import '../../models/otp_verify_response.dart';
import '../../models/profile_update_response.dart';
import '../../models/resend_otp_model/resend_otp_mode.dart';
import '../../models/rider_details_response/rider_details_response.dart';

abstract class IAuthRepo {
  Future<Either<Failure, LoginResponse>> login({
    required String phone,
    required String countryCode,
    String? deviceToken,
  });
  Future<Either<Failure, LoginWithPasswordResponse>> resendSignIn({required num? userId, required String? deviceToken});
  Future<Either<Failure, LoginWithPasswordResponse>> loginWithPassword({
    required String mobile,
    required String password,
    String? deviceToken,
    String? wantLogin,
  });
  Future<Either<Failure, OtpVerifyResponse>> verifyOtp({
    required String mobile,
    required String otp,
    String? deviceToken,
    String? wantLogin,
  });
  Future<Either<Failure, CommonResponse>> updatePassword({required String password});
  Future<Either<Failure, ProfileUpdateResponse>> profileUpdate({required Map<String, dynamic> data});
  Future<Either<Failure, ResendOtpModel>> resendOTP({required String mobile});
  Future<Either<Failure, CommonResponse>> forgotPassword({required String mobile});
  Future<Either<Failure, CommonResponse>> updateProfilePhoto({required String imagePath});
  Future<Either<Failure, CommonResponse>> changePassword({
    required String currentPassword,
    required String newPassword,
    required newConfirmPassword,
  });
  Future<Either<Failure, RiderDetailsResponse>> riderDetails();
  Future<Either<Failure, RequestOtpResponse>> requestOTP({required String mobile});
  Future<Either<Failure, ForgotVerifyOtpResponse>> forgetVerifyOtp({required String mobile, required String otp});
  Future<Either<Failure, ResetPasswordResponse>> resetPassword({required Map<String, dynamic> data});
  Future<Either<Failure, LogoutResponse>> logout();
  Future<Either<Failure, OtpVerifyResponse>> signup({
    required String email,
    required String fullName,
    required String password,
    required String phone,
  });
  Future<Either<Failure, LoginWithPasswordResponse>> signInWithGoogle({
    required String idToken,
    String? name,
    String? email,
    String? phone,
    String? deviceToken,
  });
}
