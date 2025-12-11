import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/selected_loc_text_field_notifier.dart';

final selectedLocTextFieldNotifierProvider =
    StateNotifierProvider.autoDispose<SelectedLocTextFieldNotifier, int?>((ref) => SelectedLocTextFieldNotifier());
