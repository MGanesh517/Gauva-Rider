import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/order_response/order_model/order/order.dart';
import '../../../data/repositories/interfaces/ride_history_repo_interface.dart';
class RideHistoryState {
  final DateTime dateTime;
  final String? status;
  final bool isCompleteSelected;
  final List<Order> list;

  RideHistoryState({
    DateTime? dateTime,
    this.status,
    this.isCompleteSelected = true,
    List<Order>? list,
  })  : dateTime = dateTime ?? DateTime.now(),
        list = list ?? [];

  RideHistoryState copyWith({
    DateTime? dateTime,
    String? status,
    bool? isCompleteSelected,
    List<Order>? list,
  }) => RideHistoryState(
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      isCompleteSelected: isCompleteSelected ?? this.isCompleteSelected,
      list: list ?? this.list,
    );
}


class RideHistoryNotifier extends StateNotifier<AppState<List<Order>>> {
  final Ref ref;
  final IRideHistoryRepo service;

  RideHistoryNotifier(this.ref, this.service) : super(const AppState.initial()) {
    fetchRideHistory();
  }

  Future<void> fetchRideHistory({String? status, String? date}) async {
    state = const AppState.loading();

    final result = await service.getRideHistory(status, date);

    result.fold(
          (failure) {
        state = AppState.error(failure);
      },
          (data) {

        state = AppState.success(data.data?.orders ?? []);
      },
    );
  }
}

