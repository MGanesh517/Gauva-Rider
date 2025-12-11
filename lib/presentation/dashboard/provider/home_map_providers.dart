import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/home_map_repo_impl.dart';
import '../../../data/repositories/interfaces/home_map_repo_interface.dart';
import '../viewmodel/home_map_notifier.dart';

final homeMapRepoProvider = Provider<IHomeMapRepo>((ref) => HomeMapRepoImpl());

final homeMapNotifierProvider = StateNotifierProvider<HomeMapNotifier, HomeMapState>((ref) => HomeMapNotifier(ref));
