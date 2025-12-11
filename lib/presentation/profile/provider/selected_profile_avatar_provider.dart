import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/selected_profile_avatar_notifier.dart';

final selectedProfileAvatarNotifierProvider =
    StateNotifierProvider<SelectedProfileAvatarNotifier, Tuple2<int?, String?>>(
        (ref) => SelectedProfileAvatarNotifier());
