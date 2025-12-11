import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/repositories/interfaces/ride_preference_repo_interface.dart';

import '../../../data/models/order_response/order_model/service_option/service_options.dart';

class RidePreferenceNotifier extends StateNotifier<AppState<List<ServiceOption>>> {
  final IRidePreferenceRepo repo;
  RidePreferenceNotifier({
    required this.repo,
  }) : super(const AppState.initial());

  Future<void> getPreference() async {
    state = const AppState.loading();
    final result = await repo.getPreference();
    result.fold(
          (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
          (data) => state = AppState.success(data.data ?? []),
    );
  }
}
