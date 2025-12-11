import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/track_order_state.dart';

class TrackOrderNotifier extends StateNotifier<TrackOrderState> {
  TrackOrderNotifier() : super(const TrackOrderState.lookingForDriver());

  void goToChat() {
    state = const TrackOrderState.chat();
  }

  void goToLookingForDriver() {
    state = const TrackOrderState.lookingForDriver();
  }

  void goToInProgress() {
    state = const TrackOrderState.inProgress();
  }

  void hideChat() {
    state = const TrackOrderState.inProgress();
  }

  void reset() {
    state = const TrackOrderState.lookingForDriver();
  }
}
