import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/services/rating_service.dart';
import 'package:gauva_userapp/domain/interfaces/rating_service_interface.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/repositories/interfaces/rating_repo_interface.dart';
import '../../../data/repositories/rating_repo_impl.dart';
import '../view_model/rating_notifier.dart';
import '../../auth/provider/auth_providers.dart';

// Service Provider
final ratingProvider = Provider<IRatingService>((ref) => RatingService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final ratingRepoProvider = Provider<IRatingRepo>((ref) => RatingRepoImpl(ratingService: ref.read(ratingProvider)));

final ratingNotifierProvider = StateNotifierProvider<RatingNotifier, AppState<CommonResponse>>(
  (ref) => RatingNotifier(ref, ref.watch(ratingRepoProvider)),
);
