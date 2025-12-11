import 'package:flutter/foundation.dart';

import 'data.dart';

@immutable
class RequestOtpResponse {
  final bool? success;
  final String? message;
  final Data? data;

  const RequestOtpResponse({this.success, this.message, this.data});

  factory RequestOtpResponse.fromMap(Map<String, dynamic> json) => RequestOtpResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromMap(json['data'] as Map<String, dynamic>),
    );

  Map<String, dynamic> toMap() => {
        'success': success,
        'message': message,
        'data': data?.toMap(),
      };
}
