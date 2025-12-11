import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/order_in_progress_state.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/services/navigation_service.dart';
import '../provider/track_order_provider.dart';

class OrderInProgressNotifier extends StateNotifier<OrderInProgressState> {
  final Ref ref;

  OrderInProgressNotifier({required this.ref}) : super(const OrderInProgressState.orderAccept());

  void goToOrderAccept() {
    state = const OrderInProgressState.orderAccept();
  }

  void goToHeadingPickup() {
    state = const OrderInProgressState.headingToPickup();
  }

  void goToPickupPoint() {
    state = const OrderInProgressState.inPickupPoint();
  }

  void goToInsideCarReadyToMove() {
    state = const OrderInProgressState.inSideCarReadyToMove();
  }

  void goToHeadingToDestination() {
    state = const OrderInProgressState.headingToDestination();
  }

  void goToConfirmPay() {
    state = const OrderInProgressState.confirmPay();
  }

  void gotToFeedback() {
    state = const OrderInProgressState.feedback();
  }

  void resetState() {
    state = const OrderInProgressState.orderAccept();
  }

  void goToHome() {
    resetState();
    ref.read(trackOrderNotifierProvider.notifier).goToLookingForDriver();
    NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
  }
}
