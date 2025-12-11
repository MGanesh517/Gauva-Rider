class WalletModel {
  WalletModel({
    this.message,
    this.data,});

  WalletModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  Data? data;
  WalletModel copyWith({  String? message,
    Data? data,
  }) => WalletModel(  message: message ?? this.message,
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
    this.balance,
    this.razorpayOrderId,
    this.razorpayKey,
    this.amount,
    this.currency,
    this.paymentLinkUrl,
    this.paymentLinkId,
    this.transactionId,
    this.status,
  });

  Data.fromJson(dynamic json) {
    balance = json['balance'];
    razorpayOrderId = json['razorpayOrderId'] ?? json['orderId'];
    razorpayKey = json['razorpayKey'] ?? json['key'];
    amount = json['amount'];
    currency = json['currency'];
    paymentLinkUrl = json['paymentLinkUrl'];
    paymentLinkId = json['paymentLinkId'];
    transactionId = json['transactionId'];
    status = json['status'];
  }
  num? balance;
  String? razorpayOrderId;
  String? razorpayKey;
  num? amount;
  String? currency;
  String? paymentLinkUrl;
  String? paymentLinkId;
  num? transactionId;
  String? status;
  
  Data copyWith({
    num? balance,
    String? razorpayOrderId,
    String? razorpayKey,
    num? amount,
    String? currency,
    String? paymentLinkUrl,
    String? paymentLinkId,
    num? transactionId,
    String? status,
  }) => Data(
    balance: balance ?? this.balance,
    razorpayOrderId: razorpayOrderId ?? this.razorpayOrderId,
    razorpayKey: razorpayKey ?? this.razorpayKey,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    paymentLinkUrl: paymentLinkUrl ?? this.paymentLinkUrl,
    paymentLinkId: paymentLinkId ?? this.paymentLinkId,
    transactionId: transactionId ?? this.transactionId,
    status: status ?? this.status,
  );
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    map['razorpayOrderId'] = razorpayOrderId;
    map['razorpayKey'] = razorpayKey;
    map['amount'] = amount;
    map['currency'] = currency;
    map['paymentLinkUrl'] = paymentLinkUrl;
    map['paymentLinkId'] = paymentLinkId;
    map['transactionId'] = transactionId;
    map['status'] = status;
    return map;
  }

}