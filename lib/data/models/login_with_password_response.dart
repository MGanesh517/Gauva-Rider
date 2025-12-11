import 'user_model/user_model.dart';

class LoginWithPasswordResponse {
  LoginWithPasswordResponse({
    this.message,
    this.data,});

  LoginWithPasswordResponse.fromJson(dynamic json) {
    message = json['message'];
    // Spring Boot returns accessToken and refreshToken at root level (similar to OTP verify)
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
  Data? data;
  LoginWithPasswordResponse copyWith({  String? message,
    Data? data,
  }) => LoginWithPasswordResponse(  message: message ?? this.message,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
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

// class LoginWithPasswordResponse {
//   LoginWithPasswordResponse({
//     this.message,
//     this.data,});
//
//   LoginWithPasswordResponse.fromJson(dynamic json) {
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   String? message;
//   Data? data;
//   LoginWithPasswordResponse copyWith({  String? message,
//     Data? data,
//   }) => LoginWithPasswordResponse(  message: message ?? this.message,
//     data: data ?? this.data,
//   );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class Data {
//   Data({
//     this.user,
//     this.token,});
//
//   Data.fromJson(dynamic json) {
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     token = json['token'];
//   }
//   User? user;
//   String? token;
//   Data copyWith({  User? user,
//     String? token,
//   }) => Data(  user: user ?? this.user,
//     token: token ?? this.token,
//   );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     map['token'] = token;
//     return map;
//   }
//
// }

