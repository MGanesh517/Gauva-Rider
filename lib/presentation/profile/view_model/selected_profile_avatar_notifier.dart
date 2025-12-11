import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedProfileAvatarNotifier extends StateNotifier<Tuple2<int?, String?>> {
  SelectedProfileAvatarNotifier() : super(const Tuple2(null, null));

  void selectLocalAvater({required int index, required String path}) => state = Tuple2(index, path);

  void selectRemoteAvatar({required String path}) => state = Tuple2(null, path);

  void reset() => state = const Tuple2(null, null);
}
