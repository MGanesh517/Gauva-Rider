import 'package:gauva_userapp/data/models/user_model/user_model.dart';

class ProfileUpdateResponse {
  ProfileUpdateResponse({
    this.message,
    this.data,});

  ProfileUpdateResponse.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
  ProfileUpdateResponse copyWith({  String? message,
    Data? data,
  }) => ProfileUpdateResponse(  message: message ?? this.message,
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
    this.user,});

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;
  Data copyWith({  User? user,
  }) => Data(  user: user ?? this.user,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

