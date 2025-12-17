import 'package:gauva_userapp/data/models/ride_service_response.dart';

import '../address/address.dart';
import '../driver/driver.dart';
import '../points/points.dart';
import '../rider/rider.dart';

class Order {
  Order({
    this.id,
    this.status,
    this.distance,
    this.duration,
    this.waitMinutes,
    this.points,
    this.addresses,
    this.startTimestamp,
    this.finishTimestamp,
    this.payMethod,
    this.paymentStatus,
    this.pickupAt,
    this.subTotal,
    this.discount,
    this.payableAmount,
    this.currency,
    this.directions,
    this.rating,
    this.service,
    this.driver,
    this.rider,
    this.otp,
  });

  Order.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    distance = json['distance'];
    duration = json['duration'];
    waitMinutes = json['wait_minutes'];
    points = json['points'] != null ? Points.fromJson(json['points']) : null;
    addresses = json['addresses'] != null ? Addresses.fromJson(json['addresses']) : null;
    orderTime = json['order_time'];
    startTimestamp = json['start_timestamp'];
    finishTimestamp = json['finish_timestamp'];
    payMethod = json['pay_method'];
    paymentStatus = json['payment_status'];
    pickupAt = json['pickup_at'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    payableAmount = json['payable_amount'];
    currency = json['currency'];
    directions = json['directions'];
    rating = json['rating'];
    service = json['service'] != null ? Services.fromJson(json['service']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    rider = json['rider'] != null ? Rider.fromJson(json['rider']) : null;
    otp = json['otp'];
  }
  int? id;
  String? status;
  num? distance;
  num? duration;
  num? waitMinutes;
  Points? points;
  Addresses? addresses;
  String? orderTime;
  String? startTimestamp;
  String? finishTimestamp;
  String? payMethod;
  bool? paymentStatus;
  num? subTotal;
  num? discount;
  dynamic pickupAt;
  num? payableAmount;
  dynamic currency;
  dynamic directions;
  num? rating;
  Services? service;
  Driver? driver;
  Rider? rider;
  int? otp;
  Order copyWith({  int? id,
    String? status,
    num? distance,
    num? duration,
    num? waitMinutes,
    Points? points,
    Addresses? addresses,
    dynamic startTimestamp,
    dynamic finishTimestamp,
    String? payMethod,
    dynamic pickupAt,
    num? payableAmount,
    dynamic currency,
    dynamic directions,
    num? rating,
    Services? service,
    Driver? driver,
    Rider? rider,
    int? otp,
  }) => Order(  id: id ?? this.id,
    status: status ?? this.status,
    distance: distance ?? this.distance,
    duration: duration ?? this.duration,
    waitMinutes: waitMinutes ?? this.waitMinutes,
    points: points ?? this.points,
    addresses: addresses ?? this.addresses,
    startTimestamp: startTimestamp ?? this.startTimestamp,
    finishTimestamp: finishTimestamp ?? this.finishTimestamp,
    payMethod: payMethod ?? this.payMethod,
    pickupAt: pickupAt ?? this.pickupAt,
    payableAmount: payableAmount ?? this.payableAmount,
    currency: currency ?? this.currency,
    directions: directions ?? this.directions,
    service: service ?? this.service,
    driver: driver ?? this.driver,
    rider: rider ?? this.rider,
    otp: otp ?? this.otp,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['distance'] = distance;
    map['duration'] = duration;
    map['wait_minutes'] = waitMinutes;
    if (points != null) {
      map['points'] = points?.toJson();
    }
    if (addresses != null) {
      map['addresses'] = addresses?.toJson();
    }
    map['start_timestamp'] = startTimestamp;
    map['finish_timestamp'] = finishTimestamp;
    map['pay_method'] = payMethod;
    map['pickup_at'] = pickupAt;
    map['payable_amount'] = payableAmount;
    map['currency'] = currency;
    map['directions'] = directions;
    if (service != null) {
      map['service'] = service?.toJson();
    }
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    if (rider != null) {
      map['rider'] = rider?.toJson();
    }
    map['otp'] = otp;
    return map;
  }

}