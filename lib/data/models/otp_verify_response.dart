import 'user_model/user_model.dart';

class OtpVerifyResponse {
  OtpVerifyResponse({
    this.message,
    this.type,
    this.data,});

  OtpVerifyResponse.fromJson(dynamic json) {
    message = json['message'];
    type = json['type']; // Spring Boot returns 'type': 'NORMAL_USER'
    // Spring Boot returns accessToken and refreshToken at root level
    if (json['accessToken'] != null || json['refreshToken'] != null) {
      data = Data.fromJson({
        'accessToken': json['accessToken'],
        'refreshToken': json['refreshToken'],
        'user': json['user'],
        'other_device': json['otherDevice'] ?? json['other_device'],
      });
    } else {
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }
  }
  String? message;
  String? type;
  Data? data;
  OtpVerifyResponse copyWith({  String? message,
    String? type,
    Data? data,
  }) => OtpVerifyResponse(  message: message ?? this.message,
    type: type ?? this.type,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['type'] = type;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.user,
    this.token,
    this.accessToken,
    this.refreshToken,
    this.otherDevice
  });

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    // Support both old format (token) and new format (accessToken/refreshToken)
    token = json['token'] ?? json['accessToken'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    otherDevice = json['other_device'] ?? json['otherDevice'];
  }
  User? user;
  String? token; // For backward compatibility
  String? accessToken; // Spring Boot access token
  String? refreshToken; // Spring Boot refresh token
  bool? otherDevice;
  Data copyWith({  User? user,
    String? token,
    String? accessToken,
    String? refreshToken,
  }) => Data(  user: user ?? this.user,
    token: token ?? this.token,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['token'] = token ?? accessToken;
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }

}

