import '../order_response/order_model/service_option/service_options.dart';

class RidePreferenceModel {
  RidePreferenceModel({
      this.message, 
      this.data,});

  RidePreferenceModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceOption.fromJson(v));
      });
    }
  }
  String? message;
  List<ServiceOption>? data;
RidePreferenceModel copyWith({  String? message,
  List<ServiceOption>? data,
}) => RidePreferenceModel(  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

// class ServiceOption {
//   ServiceOption({
//       this.value,
//       this.name,});
//
//   ServiceOption.fromJson(dynamic json) {
//     value = json['value'];
//     name = json['name'];
//   }
//   num? value;
//   String? name;
// ServiceOption copyWith({  num? value,
//   String? name,
// }) => ServiceOption(  value: value ?? this.value,
//   name: name ?? this.name,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['value'] = value;
//     map['name'] = name;
//     return map;
//   }
//
// }