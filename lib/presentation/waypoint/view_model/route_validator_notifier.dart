import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/way_point_list_providers.dart';

class RouteValidatorNotifier extends StateNotifier<bool> {
  final Ref ref;
  RouteValidatorNotifier(this.ref) : super(false);

  void validate() {
    final wayPointsState = ref.read(wayPointListNotifierProvider);
    if (wayPointsState.length == 2) {
      final bool isValid = wayPointsState[0].location != wayPointsState[1].location;
      state = isValid;
    }
    if (wayPointsState.length == 3) {
      final bool isValid = wayPointsState[0].location != wayPointsState[1].location &&
          wayPointsState[1].location != wayPointsState[2].location;
      state = isValid;
    }
  }
}
