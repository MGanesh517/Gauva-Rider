import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/profile_photo_upload_notifier.dart';

final profilePhotoUploadNotifierProvider =
    StateNotifierProvider.autoDispose<ProfilePhotoUploadNotifier, AppState<CommonResponse>>(
        (ref) => ProfilePhotoUploadNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));
