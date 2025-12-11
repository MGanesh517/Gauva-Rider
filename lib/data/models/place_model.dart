import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final String placeId;
  final String title;
  final String subtitle;
  final String distance;
  final LatLng latLng;
  PlaceModel({
    required this.placeId,
    required this.title,
    required this.subtitle,
    required this.distance,
    required this.latLng,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        placeId: json['placeId'],
        title: json['title'],
        subtitle: json['subtitle'],
        distance: json['distance'],
        latLng: json['latlng']);
}
