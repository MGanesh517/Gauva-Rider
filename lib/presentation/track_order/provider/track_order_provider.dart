import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/track_order_state.dart';
import '../view_model/track_order_notifier.dart';

final trackOrderNotifierProvider =
    StateNotifierProvider<TrackOrderNotifier, TrackOrderState>((ref) => TrackOrderNotifier());
