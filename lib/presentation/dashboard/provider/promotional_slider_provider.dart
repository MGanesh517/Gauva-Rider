import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/promotional_slider_model/promotional_slider_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/promotional_slider_repo_interface.dart';
import 'package:gauva_userapp/data/repositories/promotional_slider_repo_impl.dart';
import 'package:gauva_userapp/data/services/promotional_slider_service.dart';
import 'package:gauva_userapp/domain/interfaces/promotional_slider_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/promotional_slider_notifier.dart';

import '../../../core/state/app_state.dart';


// Service Provider
final promotionalSliderServiceProvider = Provider<IPromotionalSliderService>((ref) => PromotionalSliderService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final promotionalSliderRepoProvider = Provider<IPromotionalSliderRepo>((ref) => PromotionalSliderRepoImpl(service: ref.read(promotionalSliderServiceProvider)));

// ViewModel Providers
final promotionalSliderProvider = StateNotifierProvider<PromotionalSliderNotifier, AppState<List<Promotions>>>(
        (ref) => PromotionalSliderNotifier(repo: ref.read(promotionalSliderRepoProvider),));
