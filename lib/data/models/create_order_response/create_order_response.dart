import '../order_response/order_model/driver/driver.dart';
import '../order_response/order_model/order/order.dart';

class CreateOrderResponse {
  bool? success;
  String? message;
  Data? data;

  CreateOrderResponse({this.success, this.message, this.data});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Order? order;
  List<Driver>? drivers;
  String? userUuid; // Store user UUID from order response for Socket.IO

  Data({this.order, this.drivers, this.userUuid});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    userUuid = json['_userUuid']?.toString(); // Extract user UUID if stored
    if (json['driver'] != null) {
      drivers = <Driver>[];
      json['driver'].forEach((v) {
        drivers!.add(Driver.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (drivers != null) {
      data['driver'] = drivers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
