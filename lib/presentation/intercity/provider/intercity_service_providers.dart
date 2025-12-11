import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/interfaces/intercity_service_repo_interface.dart';
import '../../../data/repositories/intercity_service_repo_impl.dart';
import '../../../data/services/intercity_service.dart';
import '../../../domain/interfaces/intercity_service_interface.dart';
import '../../auth/provider/auth_providers.dart';
import '../viewmodel/intercity_service_notifier.dart';

// Service Provider
final intercityServiceProvider = Provider<IIntercityService>(
  (ref) => IntercityService(dioClient: ref.read(dioClientProvider)),
);

// Repo Provider
final intercityServiceRepoProvider = Provider<IIntercityServiceRepo>(
  (ref) => IntercityServiceRepoImpl(ref.read(intercityServiceProvider)),
);

// View Model Provider
final intercityServiceNotifierProvider = StateNotifierProvider<IntercityServiceNotifier, IntercityServiceState>(
  (ref) => IntercityServiceNotifier(ref, ref.read(intercityServiceRepoProvider)),
);
