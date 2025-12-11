import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  void nextPage() => state++;
  void previousPage() => state--;
  void setIndex(int index) => state = index;
  void reset() => state = 0;
  void skip() => state = 2;
}
