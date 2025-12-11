import 'package:flutter/foundation.dart';

import '../user_model/user_model.dart';

@immutable
class Data {
  final User? user;
  final num? totalRides;
  final num? distanceTravelled;
  final num? rating;

  const Data({
    this.user,
    this.totalRides,
    this.distanceTravelled,
    this.rating,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        totalRides: json['total_rides'],
        distanceTravelled: json['distance_travelled'],
        rating: json['rating'],
      );

  Map<String, dynamic> toMap() => {
        'user': user?.toJson(),
        'total_rides': totalRides,
        'distance_travelled': distanceTravelled,
        'rating': rating,
      };
}
