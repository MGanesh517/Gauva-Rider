import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

class UserModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'country_iso')
  final String? countryIso;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'profile_picture')
  final String? profilePicture;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'email_verified')
  final bool? emailVerified;

  @JsonKey(name: 'otp_verified')
  final bool? otpVerified;

  @JsonKey(name: 'status')
  final String? status;

  UserModel({
    required this.id,
    this.name,
    this.countryIso,
    this.mobile,
    this.gender,
    this.address,
    this.profilePicture,
    this.email,
    this.emailVerified,
    this.otpVerified,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    debugPrint('👤 Parsing UserModel from JSON: $json');
    
    // Handle different ID formats (String UUID, int, or null)
    int parsedId;
    final idValue = json['id'];
    
    if (idValue == null) {
      debugPrint('⚠️ User ID is null, using 0');
      parsedId = 0;
    } else if (idValue is int) {
      parsedId = idValue;
    } else if (idValue is String) {
      // Try to parse UUID or numeric string
      parsedId = int.tryParse(idValue) ?? idValue.hashCode;
      debugPrint('⚠️ User ID is String: $idValue, converted to: $parsedId');
    } else {
      debugPrint('⚠️ User ID is ${idValue.runtimeType}, using hashCode');
      parsedId = idValue.hashCode;
    }
    
    return UserModel(
      id: parsedId,
      name: json['name'],
      countryIso: json['country_iso'],
      mobile: json['mobile'],
      gender: json['gender'],
      address: json['address'],
      profilePicture: json['profile_picture'],
      email: json['email'],
      emailVerified: json['email_verified'],
      otpVerified: json['otp_verified'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'country_iso': countryIso,
    'mobile': mobile,
    'gender': gender,
    'address': address,
    'profile_picture': profilePicture,
    'email': email,
    'email_verified': emailVerified,
    'otp_verified': otpVerified,
    'status': status,
  };
}
