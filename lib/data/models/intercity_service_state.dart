import 'package:gauva_userapp/data/models/intercity_service_type.dart';
import '../../core/state/app_state.dart';

class IntercityServiceState {
  final IntercityServiceType? selectedServiceType;
  final AppState<List<IntercityServiceType>> serviceListState;

  IntercityServiceState({
    required this.selectedServiceType,
    required this.serviceListState,
  });

  IntercityServiceState copyWith({
    IntercityServiceType? selectedServiceType,
    bool resetSelectedServiceType = false,
    AppState<List<IntercityServiceType>>? serviceListState,
  }) =>
      IntercityServiceState(
        selectedServiceType: resetSelectedServiceType
            ? null
            : selectedServiceType ?? this.selectedServiceType,
        serviceListState: serviceListState ?? this.serviceListState,
      );

  factory IntercityServiceState.initial() => IntercityServiceState(
        selectedServiceType: null,
        serviceListState: const AppState.initial(),
      );
}
