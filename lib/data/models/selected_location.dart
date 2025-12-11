import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedLocation {
  final LatLng? defaultLocation;
  final LatLng? selectedLocation;
  final String? address;

  SelectedLocation({
    this.defaultLocation,
    this.selectedLocation,
    // this.title,
    this.address
  });

  SelectedLocation copyWith({
    LatLng? defaultLocation,
    LatLng? selectedLocation,
    String? title,
    String? address,
  }) => SelectedLocation(
      defaultLocation: defaultLocation ?? this.defaultLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      // title: title ?? this.title,
      address: address ?? this.address,
    );

  // empty constructor
  SelectedLocation.empty()
      : defaultLocation = null,
        selectedLocation = null,
        // title = null,
        address = null;
}
