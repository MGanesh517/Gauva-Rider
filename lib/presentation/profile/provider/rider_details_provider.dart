import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/rider_details_response/rider_details_response.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/rider_details_notifier.dart';

final riderDetailsNotifierProvider = StateNotifierProvider<RiderDetailsNotifier, AppState<RiderDetailsResponse>>(
    (ref) => RiderDetailsNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));
