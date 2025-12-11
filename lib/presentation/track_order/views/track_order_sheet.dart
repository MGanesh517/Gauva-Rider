import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gauva_userapp/presentation/track_order/views/looking_for_driver_sheet.dart';
import 'package:gauva_userapp/presentation/track_order/views/order_in_progress_sheet.dart';

import '../../../core/theme/animation_duration.dart';
import '../provider/track_order_provider.dart';

class TrackOrderSheet extends ConsumerWidget {
  const TrackOrderSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trackOrderNotifierProvider);
    return AnimatedSwitcher(
      duration: AnimationDuration.pageStateTransitionMobile,
      child: state.when(
        chat: () => const SizedBox.shrink(),
        // chat: () => const ChatSheet(),
        lookingForDriver: () => const LookingForDriverSheet(),
        inProgress: () => const OrderInProgressSheet(),
      ),
    );
  }
}
