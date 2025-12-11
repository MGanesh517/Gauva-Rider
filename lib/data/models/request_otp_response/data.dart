import 'package:flutter/foundation.dart';

@immutable
class Data {
  final String? mobile;
  final String? otp;

  const Data({this.mobile, this.otp});

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        mobile: json['mobile'] as String?,
        otp: json['otp'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'mobile': mobile,
        'otp': otp,
      };
}
