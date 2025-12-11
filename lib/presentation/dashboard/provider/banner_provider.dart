import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/banner_model/banner_model.dart';
import 'package:gauva_userapp/data/repositories/banner_repo_impl.dart';
import 'package:gauva_userapp/data/repositories/interfaces/banner_repo_interface.dart';
import 'package:gauva_userapp/data/services/banner_service.dart';
import 'package:gauva_userapp/domain/interfaces/banner_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/banner_notifier.dart';

import '../../../core/state/app_state.dart';

// Service Provider
final bannerServiceProvider = Provider<IBannerService>(
    (ref) => BannerService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final bannerRepoProvider = Provider<IBannerRepo>(
    (ref) => BannerRepoImpl(service: ref.read(bannerServiceProvider)));

// ViewModel Provider
final bannerProvider = StateNotifierProvider<BannerNotifier, AppState<List<BannerModel>>>(
    (ref) => BannerNotifier(repo: ref.read(bannerRepoProvider)));

