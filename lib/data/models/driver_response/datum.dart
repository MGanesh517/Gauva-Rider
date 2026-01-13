import 'dart:convert';

class Datum {
  int? id;
  String? name;
  String? email;
  String? mobile;
  double? rating;
  double? latitude;
  double? longitude;
  int? carAngle;
  bool? available;
  Vehicle? vehicle;
  bool? subscriptionActive;
  String? subscriptionType;

  Datum({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.rating,
    this.latitude,
    this.longitude,
    this.carAngle,
    this.available,
    this.vehicle,
    this.subscriptionActive,
    this.subscriptionType,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        mobile: data['mobile'] as String?,
        rating: (data['rating'] as num?)?.toDouble(),
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),
        carAngle: data['car_angle'] as int? ?? data['carAngle'] as int?,
        available: data['available'] as bool?,
        vehicle: data['vehicle'] != null ? Vehicle.fromMap(data['vehicle'] as Map<String, dynamic>) : null,
        subscriptionActive: data['subscriptionActive'] as bool?,
        subscriptionType: data['subscriptionType'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'mobile': mobile,
        'rating': rating,
        'latitude': latitude,
        'longitude': longitude,
        'car_angle': carAngle,
        'available': available,
        'vehicle': vehicle?.toMap(),
        'subscriptionActive': subscriptionActive,
        'subscriptionType': subscriptionType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) => Datum.fromMap(json.decode(data) as Map<String, dynamic>);

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());
}

class Vehicle {
  int? id;
  String? company;
  String? model;
  String? color;
  int? year;
  String? licensePlate;
  int? capacity;
  int? seatCapacity;
  String? vehicleType;
  String? serviceType; // "BIKE", "MEGA", "CAR"

  Vehicle({
    this.id,
    this.company,
    this.model,
    this.color,
    this.year,
    this.licensePlate,
    this.capacity,
    this.seatCapacity,
    this.vehicleType,
    this.serviceType,
  });

  factory Vehicle.fromMap(Map<String, dynamic> data) => Vehicle(
        id: data['id'] as int?,
        company: data['company'] as String?,
        model: data['model'] as String?,
        color: data['color'] as String?,
        year: data['year'] as int?,
        licensePlate: data['licensePlate'] as String?,
        capacity: data['capacity'] as int?,
        seatCapacity: data['seatCapacity'] as int?,
        vehicleType: data['vehicleType'] as String?,
        serviceType: data['serviceType'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'company': company,
        'model': model,
        'color': color,
        'year': year,
        'licensePlate': licensePlate,
        'capacity': capacity,
        'seatCapacity': seatCapacity,
        'vehicleType': vehicleType,
        'serviceType': serviceType,
      };
}
