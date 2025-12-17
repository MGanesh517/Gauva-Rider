import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/rider_details_response/rider_details_response.dart';
import '../../../data/repositories/interfaces/auth_repo_interface.dart';
import '../../../data/services/local_storage_service.dart';

class RiderDetailsNotifier extends StateNotifier<AppState<RiderDetailsResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  RiderDetailsNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> getRiderDetails() async {
    debugPrint('👤 GET RIDER DETAILS - Starting');
    state = const AppState.loading();
    final result = await authRepo.riderDetails();
    result.fold(
      (failure) {
        debugPrint('🔴 GET RIDER DETAILS FAILED: ${failure.message}');
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) async {
        debugPrint('🟢 GET RIDER DETAILS SUCCESS');
        debugPrint('🟢 Data: ${data.data}');
        debugPrint('🟢 User: ${data.data?.user}');

        // Check if user data exists before saving
        if (data.data?.user != null) {
          try {
            final userJson = data.data!.user!.toJson();
            debugPrint('✅ User JSON: $userJson');
            await LocalStorageService().saveUser(user: userJson);
            debugPrint('✅ User saved to storage');
          } catch (e, stackTrace) {
            debugPrint('🔴 Error saving user: $e');
            debugPrint('🔴 Stack trace: $stackTrace');
          }
        } else {
          debugPrint('⚠️ User data is null, not saving to storage');
        }

        state = AppState.success(data);
      },
    );
  }
}
