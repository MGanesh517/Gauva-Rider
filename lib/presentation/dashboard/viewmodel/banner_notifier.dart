import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/banner_model/banner_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/banner_repo_interface.dart';

class BannerNotifier extends StateNotifier<AppState<List<BannerModel>>> {
  final IBannerRepo repo;
  
  // PERFORMANCE OPTIMIZATION: Cache banners response for 10 minutes
  // Banners are relatively static and don't change frequently
  List<BannerModel>? _cachedBanners;
  DateTime? _bannersCacheTime;
  static const _bannersCacheDuration = Duration(minutes: 10);

  BannerNotifier({
    required this.repo,
  }) : super(const AppState.initial());

  Future<void> getBanners() async {
    // Return cached data if available and not expired
    if (_cachedBanners != null && 
        _bannersCacheTime != null &&
        DateTime.now().difference(_bannersCacheTime!) < _bannersCacheDuration) {
      state = AppState.success(_cachedBanners!);
      return;
    }

    state = const AppState.loading();
    final result = await repo.getBanners();
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        // Cache the banners list
        _cachedBanners = data;
        _bannersCacheTime = DateTime.now();
        state = AppState.success(data);
      },
    );
  }
  
  /// Clear banners cache (useful when banners might have changed)
  void clearBannersCache() {
    _cachedBanners = null;
    _bannersCacheTime = null;
  }
}

