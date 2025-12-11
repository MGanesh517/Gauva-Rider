import 'package:flutter_riverpod/flutter_riverpod.dart';

class TravelTimeDistance {
  final String? time;
  final String? distance;

  TravelTimeDistance({this.time, this.distance});

  TravelTimeDistance copyWith({String? time, String? distance}) => TravelTimeDistance(
      time: time ?? this.time,
      distance: distance ?? this.distance,
    );
}



class TravelInfoNotifier extends Notifier<TravelTimeDistance> {
  @override
  TravelTimeDistance build() => TravelTimeDistance();

  void setTime(String? time) {
    state = state.copyWith(time: time);
  }

  void setDistance(String? distance) {
    state = state.copyWith(distance: distance);
  }

  void setTimeAndDistance({String? time, String? distance}) {
    state = state.copyWith(time: time, distance: distance);
  }

  void clear() {
    state = TravelTimeDistance();
  }
}
