import 'package:gauva_userapp/data/models/ride_service_response.dart';
import '../../core/enums/car_view_type.dart';
import '../../core/state/app_state.dart';

class CarTypeState {
  final Services? selectedCarType;
  final AppState<List<Services>> serviceListState;
  final CarViewType viewType;

  CarTypeState({
    required this.selectedCarType,
    required this.serviceListState,
    required this.viewType,
  });

  CarTypeState copyWith({
    Services? selectedCarType,
    bool resetSelectedCarType = false,
    AppState<List<Services>>? serviceListState,
    CarViewType? viewType,
  }) => CarTypeState(
      selectedCarType: resetSelectedCarType ? null : selectedCarType ?? this.selectedCarType,
      serviceListState: serviceListState ?? this.serviceListState,
      viewType: viewType ?? this.viewType,
    );


  factory CarTypeState.initial() => CarTypeState(
    selectedCarType: null,
    serviceListState: const AppState.initial(),
    viewType: CarViewType.grid,
  );
}
