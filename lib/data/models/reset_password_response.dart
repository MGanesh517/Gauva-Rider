import 'package:flutter/foundation.dart';

@immutable
class ResetPasswordResponse {
  final bool? success;
  final String? message;
  final List<dynamic>? data;

  const ResetPasswordResponse({this.success, this.message, this.data});

  factory ResetPasswordResponse.fromMap(Map<String, dynamic> json) => ResetPasswordResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as List<dynamic>?,
    );

  Map<String, dynamic> toMap() => {
        'success': success,
        'message': message,
        'data': data,
      };
}
