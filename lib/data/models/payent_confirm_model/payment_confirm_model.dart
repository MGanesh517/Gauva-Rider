class PaymentConfirmModel {
  PaymentConfirmModel({
    this.message,
    this.data,});

  PaymentConfirmModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
  PaymentConfirmModel copyWith({  String? message,
    Data? data,
  }) => PaymentConfirmModel(  message: message ?? this.message,
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
    this.redirectUrl,});

  Data.fromJson(dynamic json) {
    redirectUrl = json['redirectUrl'];
  }
  String? redirectUrl;
  Data copyWith({  String? redirectUrl,
  }) => Data(  redirectUrl: redirectUrl ?? this.redirectUrl,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redirectUrl'] = redirectUrl;
    return map;
  }

}
// class PaymentConfirmModel {
//   PaymentConfirmModel({
//       this.status,
//       this.message,
//       this.redirectUrl,});
//
//   PaymentConfirmModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     redirectUrl = json['redirectUrl'];
//   }
//   String? status;
//   String? message;
//   String? redirectUrl;
// PaymentConfirmModel copyWith({  String? status,
//   String? message,
//   String? redirectUrl,
// }) => PaymentConfirmModel(  status: status ?? this.status,
//   message: message ?? this.message,
//   redirectUrl: redirectUrl ?? this.redirectUrl,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['redirectUrl'] = redirectUrl;
//     return map;
//   }
//
// }