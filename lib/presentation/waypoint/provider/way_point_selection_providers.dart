import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/way_point_notifier.dart';

final wayPointSelectionNotifierProvider = StateNotifierProvider<WayPointSelectionNotifier, bool>((ref) => WayPointSelectionNotifier(ref));
