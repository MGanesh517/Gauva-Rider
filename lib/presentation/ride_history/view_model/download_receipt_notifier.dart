import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/download_receipt_model/download_receipt_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/download_receipt_repo_interface.dart';

import '../../../core/state/app_state.dart';
import '../../../data/services/file_opener.dart';

class DownloadReceiptNotifier extends StateNotifier<AppState<DownloadReceiptModel>> {
  final Ref ref;
  final IDownloadReceiptRepo service;

  DownloadReceiptNotifier(this.ref, this.service) : super(const AppState.initial());

  Future<void> getDownloadLink({int? id}) async {
    state = const AppState.loading();

    final result = await service.getDownloadLink(id: id);

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) async {
        await download(data);
      },
    );
  }

  Future<void> download(DownloadReceiptModel data) async {
    state = const AppState.loading();
    final result = await service.download(url: data.data?.url);

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (file) async {
        state = AppState.success(data);
        await FileOpener.openFile(file);
      },
    );
  }
}
