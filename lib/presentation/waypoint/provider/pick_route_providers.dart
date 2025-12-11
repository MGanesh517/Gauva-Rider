import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/pick_route_state.dart';
import '../view_model/pick_route_notifier.dart';

final pickRouteNotifierProvider =
    StateNotifierProvider<PickRouteNotifier, PickRouteState>((ref) => PickRouteNotifier(ref));
