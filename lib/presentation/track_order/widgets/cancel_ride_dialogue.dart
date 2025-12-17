import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/presentation/booking/provider/cancel_ride_provider.dart';

void cancelRideDialogue(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(cancelRideNotifierProvider);
        final stateNotifier = ref.read(cancelRideNotifierProvider.notifier);

        return AlertDialog(
          title: const Text('Cancel Ride'),
          content: const Text('Are you sure you want to cancel this ride?'),
          actions: [
            TextButton(
              onPressed: state.whenOrNull(loading: () => true) == true ? null : () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: state.whenOrNull(loading: () => true) == true
                  ? null
                  : () {
                      stateNotifier.cancelRide();
                      Navigator.of(context).pop();
                    },
              child: state.whenOrNull(loading: () => true) == true
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    ),
  );
}
