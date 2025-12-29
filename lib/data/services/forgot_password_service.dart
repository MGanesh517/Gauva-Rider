import 'package:dio/dio.dart';
import '../../core/config/api_endpoints.dart';
import '../models/forgot_password_request.dart';
import '../models/reset_password_request.dart';
import 'api/dio_client.dart';

class ForgotPasswordService {
  final DioClient dioClient;

  ForgotPasswordService({required this.dioClient});

  Future<Response> sendOtp(String email) async {
    final request = ForgotPasswordRequest(email: email);
    return await dioClient.dio.post(ApiEndpoints.forgotPassword, data: request.toJson());
  }

  Future<Response> resetPassword({required String email, required String otp, required String newPassword}) async {
    final request = ResetPasswordRequest(email: email, otp: otp, newPassword: newPassword);
    return await dioClient.dio.post(ApiEndpoints.resetPassword, data: request.toJson());
  }
}
