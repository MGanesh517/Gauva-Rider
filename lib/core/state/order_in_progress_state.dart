import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_in_progress_state.freezed.dart';

@freezed
class OrderInProgressState<T> with _$OrderInProgressState<T> {
  const factory OrderInProgressState.orderAccept() = _OrderAccept<T>;
  const factory OrderInProgressState.headingToPickup() = _HeadingToPickup<T>;
  const factory OrderInProgressState.inPickupPoint() = _inPickupPoint<T>;
  const factory OrderInProgressState.inSideCarReadyToMove() = _InSideCarReadyToMove<T>;
  const factory OrderInProgressState.headingToDestination() = _HeadingToDestination<T>;
  const factory OrderInProgressState.confirmPay() = _ConfirmPay<T>;
  const factory OrderInProgressState.feedback() = _Feedback<T>;
}
