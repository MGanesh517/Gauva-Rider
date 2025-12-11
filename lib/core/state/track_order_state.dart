import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_order_state.freezed.dart';

@freezed
class TrackOrderState<T> with _$TrackOrderState<T> {
  const factory TrackOrderState.chat() = _Chat<T>;
  const factory TrackOrderState.lookingForDriver() = _LookingForDriver<T>;
  const factory TrackOrderState.inProgress() = _InProgress<T>;
}
