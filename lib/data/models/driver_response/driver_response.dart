import 'dart:convert';

import 'datum.dart';

class DriverResponse {
  bool? success;
  String? message;
  List<Datum>? data;

  DriverResponse({this.success, this.message, this.data});

  factory DriverResponse.fromMap(Map<String, dynamic> data) => DriverResponse(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      data: (data['data'] as List<dynamic>?)?.map((e) => Datum.fromMap(e as Map<String, dynamic>)).toList(),
    );

  Map<String, dynamic> toMap() => {
        'success': success,
        'message': message,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DriverResponse].
  factory DriverResponse.fromJson(String data) => DriverResponse.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [DriverResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
