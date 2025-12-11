import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/domain/interfaces/google_api_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';

import '../../../data/repositories/google_api_repo_impl.dart';
import '../../../data/repositories/interfaces/way_point_repo_interface.dart';
import '../../../data/services/gogole_api_service.dart';

// Service Provider
final googleApiServiceProvider = Provider<IGoogleApiService>(
  (ref) => GoogleApiService(dioClient: ref.read(dioClientProvider)),
);

// Repo Provider
final googleAPIRepoProvider = Provider<IGoogleAPIRepo>((ref) => GoogleAPIRepoImpl(ref.read(googleApiServiceProvider)));
