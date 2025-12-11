import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/waypoint.dart';
import '../view_model/way_point_notifier.dart';

final wayPointListNotifierProvider = StateNotifierProvider<WayPointNotifier, List<Waypoint>>(
  (ref) => WayPointNotifier(ref),
);
