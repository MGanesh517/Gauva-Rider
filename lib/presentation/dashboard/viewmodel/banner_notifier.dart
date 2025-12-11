import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/banner_model/banner_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/banner_repo_interface.dart';

class BannerNotifier extends StateNotifier<AppState<List<BannerModel>>> {
  final IBannerRepo repo;

  BannerNotifier({
    required this.repo,
  }) : super(const AppState.initial());

  Future<void> getBanners() async {
    state = const AppState.loading();
    final result = await repo.getBanners();
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) => state = AppState.success(data),
    );
  }
}

