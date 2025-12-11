import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/order_in_progress_state.dart';
import 'package:gauva_userapp/presentation/track_order/view_model/order_in_progress_notifier.dart';

final orderInProgressNotifier = StateNotifierProvider<OrderInProgressNotifier, OrderInProgressState>(
  (ref) => OrderInProgressNotifier(ref: ref),
);
