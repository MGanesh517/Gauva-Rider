import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/download_receipt_model/download_receipt_model.dart';
import 'package:gauva_userapp/data/repositories/download_receipt_repo_impl.dart';
import 'package:gauva_userapp/data/repositories/interfaces/download_receipt_repo_interface.dart';
import 'package:gauva_userapp/data/services/download_receipt_service.dart';
import 'package:gauva_userapp/domain/interfaces/download_receipt_service_interface.dart';
import 'package:gauva_userapp/presentation/ride_history/view_model/download_receipt_notifier.dart';

import '../../../core/state/app_state.dart';
import '../../auth/provider/auth_providers.dart';

// RideService Provider (depends on Dio)
final downloadReceiptServiceProvider = Provider<IDownloadReceiptService>(
  (ref) => DownloadReceiptService(dioClient: ref.read(dioClientProvider)),
);

// RideRepo Provider (depends on RideService)
final downloadReceiptRepoProvider = Provider<IDownloadReceiptRepo>(
  (ref) => DownloadReceiptRepoImpl(ref.read(downloadReceiptServiceProvider)),
);

final downloadReceiptProvider = StateNotifierProvider<DownloadReceiptNotifier, AppState<DownloadReceiptModel>>(
  (ref) => DownloadReceiptNotifier(ref, ref.read(downloadReceiptRepoProvider)),
);
