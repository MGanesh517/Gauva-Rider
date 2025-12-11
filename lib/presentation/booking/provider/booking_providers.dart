import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/booking_state.dart';
import '../view_model/booking_notifier.dart';

final bookingNotifierProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) => BookingNotifier(ref));
