import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/repositories/interfaces/auth_repo_interface.dart';
import '../provider/rider_details_provider.dart';
import '../provider/selected_profile_avatar_provider.dart';

class ProfilePhotoUploadNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  ProfilePhotoUploadNotifier({required this.ref, required this.authRepo}) : super(const AppState.initial());

  Future<void> updateProfilePhoto({required String imagePath}) async {
    state = const AppState.loading();
    final result = await authRepo.updateProfilePhoto(imagePath: imagePath);
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        showNotification(message: data.message, isSuccess: true);
        state = AppState.success(data);
        ref.read(riderDetailsNotifierProvider.notifier).getRiderDetails();
        NavigationService.pop();
      },
    );
  }

  Future<String> getImagePathFromLocalAsset({required String imagePath}) async {
    final ByteData byteData = await rootBundle.load(imagePath);
    final List<int> bytes = byteData.buffer.asUint8List();

    final temDir = await getTemporaryDirectory();
    final file = await File('${temDir.path}/avatar.jpg').create(recursive: true);
    await file.writeAsBytes(bytes);
    return file.path;
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
      ref.invalidate(selectedProfileAvatarNotifierProvider);
    });
  }
}
