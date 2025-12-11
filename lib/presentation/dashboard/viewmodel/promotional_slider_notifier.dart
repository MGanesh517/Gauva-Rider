import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/promotional_slider_model/promotional_slider_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/promotional_slider_repo_interface.dart';

class PromotionalSliderNotifier extends StateNotifier<AppState<List<Promotions>>> {
  final IPromotionalSliderRepo repo;
  PromotionalSliderNotifier({
    required this.repo,
  }) : super(const AppState.initial());

  Future<void> getPromotionalData() async {
    state = const AppState.loading();
    final result = await repo.getPromotionalData();
    result.fold(
          (failure) {
            state = AppState.error(failure);
            showNotification(message: failure.message);
          },
          (data) => state = AppState.success(data.data ?? []),
    );
  }
}
