import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/repositories/interfaces/rating_repo_interface.dart';
import 'package:gauva_userapp/presentation/track_order/provider/order_in_progress_provider.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';

class RatingNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IRatingRepo ratingRepo;
  final Ref ref;
  RatingNotifier(this.ref, this.ratingRepo) : super(const AppState.initial());

  Future<void> rating({required double rating, String? comment, int? orderId}) async {
    state = const AppState.loading();
    final result = await ratingRepo.rating(rating: rating, comment: comment, orderId: orderId);

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        showNotification(message: data.message, isSuccess: true);
        state = AppState.success(data);
        ref.read(orderInProgressNotifier.notifier).goToHome();
      },
    );
  }

  void clearRating() {
    state = const AppState.initial();
  }
}
