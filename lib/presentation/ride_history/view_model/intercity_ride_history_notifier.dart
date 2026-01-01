import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/state/app_state.dart';
import '../../../data/models/intercity_ride_history_model/intercity_ride_history_model.dart';
import '../../../data/repositories/interfaces/order_repo_interface.dart';

class IntercityRideHistoryNotifier extends StateNotifier<AppState<List<IntercityRideHistoryModel>>> {
  final IOrderRepo orderRepo;

  IntercityRideHistoryNotifier(this.orderRepo) : super(const AppState.initial());

  Future<void> fetchIntercityRideHistory() async {
    state = const AppState.loading();
    final result = await orderRepo.getIntercityRideHistory();
    result.fold((failure) => state = AppState.error(failure), (data) => state = AppState.success(data));
  }
}
