import 'package:google_maps_flutter/google_maps_flutter.dart';

class Waypoint {
  final String name;
  final String address;
  final LatLng location;

  Waypoint({required this.name, required this.address, required this.location});

  Waypoint copyWith({
    String? name,
    String? address,
    LatLng? location,
  }) => Waypoint(
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
    );
}
