import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/report_response/report_type_response.dart';
import 'package:gauva_userapp/data/repositories/interfaces/report_repo_interface.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';

import '../../account_page/provider/theme_provider.dart';
import '../widget/success_dialogue_report.dart';

class SelectedReportTypeNotifier extends StateNotifier<ReportTypes?> {
  SelectedReportTypeNotifier() : super(null);

  void setReportType(ReportTypes type) {
    state = type;
  }

  void reset() {
    state = null;
  }
}

class ReportTypeNotifier extends StateNotifier<AppState<List<ReportTypes>>> {
  final IReportRepo reportRepo;
  final Ref ref;
  ReportTypeNotifier({required this.reportRepo, required this.ref}) : super(const AppState.initial());

  Future<void> getReportTypes() async {
    state = const AppState.loading();
    final result = await reportRepo.getReportType();

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        showNotification(message: data.message ?? '', isSuccess: true);
        state = AppState.success(data.data?.reportTypes ?? []);
      },
    );
  }
}

class ReportSubmitNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IReportRepo reportRepo;
  final Ref ref;
  ReportSubmitNotifier({required this.reportRepo, required this.ref}) : super(const AppState.initial());

  Future<void> submitReport({required int? orderId, String? reportName, required String? details}) async {
    state = const AppState.loading();
    final result = await reportRepo.submitReport(orderId: orderId, details: details, reportName: reportName);

    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        state = AppState.success(data);
        showAutoDismissDialog(ref.read(themeModeProvider.notifier).isDarkMode());
        Future.delayed(const Duration(milliseconds: 2010)).then((_) {
          NavigationService.pop();
        });
      },
    );
  }
}
