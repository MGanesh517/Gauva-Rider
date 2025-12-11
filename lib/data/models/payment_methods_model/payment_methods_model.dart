class PaymentMethodsModel {
  PaymentMethodsModel({
      this.success, 
      this.message, 
      this.data,});

  PaymentMethodsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
PaymentMethodsModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => PaymentMethodsModel(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.paymentMethods,});

  Data.fromJson(dynamic json) {
    if (json['paymentMethods'] != null) {
      paymentMethods = [];
      json['paymentMethods'].forEach((v) {
        paymentMethods?.add(PaymentMethods.fromJson(v));
      });
    }
  }
  List<PaymentMethods>? paymentMethods;
Data copyWith({  List<PaymentMethods>? paymentMethods,
}) => Data(  paymentMethods: paymentMethods ?? this.paymentMethods,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (paymentMethods != null) {
      map['paymentMethods'] = paymentMethods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PaymentMethods {
  PaymentMethods({
      this.id, 
      this.value, 
      this.logo,
      this.type,
      this.amount,
      this.notes,
      this.referenceType,
      this.status,
      this.createdAt,
  });

  PaymentMethods.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
    logo = json['logo'];
    // Transaction fields
    type = json['type'];
    amount = json['amount'];
    notes = json['notes'];
    referenceType = json['referenceType'];
    status = json['status'];
    createdAt = json['createdAt'];
  }
  int? id;
  String? value;
  String? logo;
  // Transaction fields
  String? type;
  num? amount;
  String? notes;
  String? referenceType;
  String? status;
  String? createdAt;
  
PaymentMethods copyWith({  
  int? id,
  String? value,
  String? logo,
  String? type,
  num? amount,
  String? notes,
  String? referenceType,
  String? status,
  String? createdAt,
}) => PaymentMethods(  
  id: id ?? this.id,
  value: value ?? this.value,
  logo: logo ?? this.logo,
  type: type ?? this.type,
  amount: amount ?? this.amount,
  notes: notes ?? this.notes,
  referenceType: referenceType ?? this.referenceType,
  status: status ?? this.status,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;
    map['logo'] = logo;
    map['type'] = type;
    map['amount'] = amount;
    map['notes'] = notes;
    map['referenceType'] = referenceType;
    map['status'] = status;
    map['createdAt'] = createdAt;
    return map;
  }

}