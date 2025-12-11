import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelInfoModel {
  final String? message;
  final TravelInfoData? data;

  TravelInfoModel({this.message, this.data});

  factory TravelInfoModel.fromJson(Map<String, dynamic> json) => TravelInfoModel(
      message: json['message'] as String?,
      data: json['data'] != null
          ? TravelInfoData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
}

class TravelInfoData {
  final String? minute;
  final String? distance;
  final num? progress;
  final LatLng? destination;
  final LatLng? driverLocation;
  final List<LatLng>? polyline;

  TravelInfoData({
    this.minute,
    this.distance,
    this.progress,
    this.destination,
    this.driverLocation,
    this.polyline,
  });

  factory TravelInfoData.fromJson(Map<String, dynamic> json) => TravelInfoData(
      minute: json['minute'] as String?,
      distance: json['distance'] as String?,
      progress: json['progress'] as num?,
      destination: _convertToLatLng(json['destination']),
      driverLocation: _convertToLatLng(json['driver_location']),
      polyline: _convertToPolyline(json['polyline']),
    );

  static LatLng? _convertToLatLng(dynamic list) {
    if (list is List && list.length == 2) {
      final lat = (list[0] as num?)?.toDouble();
      final lng = (list[1] as num?)?.toDouble();
      if (lat != null && lng != null) {
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  static List<LatLng>? _convertToPolyline(dynamic polylineJson) {
    if (polylineJson is List) {
      return polylineJson
          .where((e) => e is List && e.length == 2)
          .map((point) => _convertToLatLng(point))
          .whereType<LatLng>()
          .toList();
    }
    return null;
  }
}
