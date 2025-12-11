class LoginResponse {
  LoginResponse({
    this.message,
    this.success,
    this.data,});

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    success = json['success'] ?? true; // Spring Boot uses 'success' instead of 'status'
    data = json['data'] != null ? Data.fromJson(json['data']) : 
           json['phoneNumber'] != null ? Data.fromJson({'phoneNumber': json['phoneNumber']}) : null;
  }
  String? message;
  bool? success;
  Data? data;
  LoginResponse copyWith({  String? message,
    bool? success,
    Data? data,
  }) => LoginResponse(  message: message ?? this.message,
    success: success ?? this.success,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.mobile,
    this.phoneNumber,
    this.otp,
    this.isNewRider,});

  Data.fromJson(dynamic json) {
    mobile = json['mobile'] ?? json['phoneNumber']; // Support both old and new format
    phoneNumber = json['phoneNumber'];
    otp = json['otp'];
    isNewRider = json['is_new_rider'] ?? json['isNewRider'];
  }
  String? mobile;
  String? phoneNumber;
  num? otp;
  bool? isNewRider;
  Data copyWith({  String? mobile,
    String? phoneNumber,
    num? otp,
    bool? isNewRider,
  }) => Data(  mobile: mobile ?? this.mobile,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    otp: otp ?? this.otp,
    isNewRider: isNewRider ?? this.isNewRider,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['phoneNumber'] = phoneNumber;
    map['otp'] = otp;
    map['is_new_rider'] = isNewRider;
    return map;
  }

}