import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyClusterItem with ClusterItem {
  final LatLng position;
  final int angle;
  final String title;
  MyClusterItem(this.position, this.angle, this.title);

  @override
  LatLng get location => position;
}
