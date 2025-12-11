import 'dart:convert';

class Datum {
  String? name;
  double? latitude;
  double? longitude;
  int? carAngle;
  bool? available;

  Datum({
    this.name,
    this.latitude,
    this.longitude,
    this.carAngle,
    this.available,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        name: data['name'] as String?,
        latitude: (data['latitude'] as num?)?.toDouble(),
        longitude: (data['longitude'] as num?)?.toDouble(),
        carAngle: data['car_angle'] as int?,
        available: data['available'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'car_angle': carAngle,
        'available': available,
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
