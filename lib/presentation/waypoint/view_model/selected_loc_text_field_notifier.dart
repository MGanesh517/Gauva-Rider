import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedLocTextFieldNotifier extends StateNotifier<int?> {
  SelectedLocTextFieldNotifier() : super(null);

  void setSelectedLocation(int index) {
    state = index;
  }

  void resetState(){
    state = null;
  }
}
