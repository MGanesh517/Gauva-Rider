import 'package:flutter/foundation.dart';

import 'data.dart';

@immutable
class RiderDetailsResponse {
  final bool? success;
  final String? message;
  final Data? data;

  const RiderDetailsResponse({this.success, this.message, this.data});

  factory RiderDetailsResponse.fromMap(Map<String, dynamic> json) => RiderDetailsResponse(
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
