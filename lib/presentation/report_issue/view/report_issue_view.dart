import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/presentation/report_issue/provider/report_provider.dart';
import 'package:gauva_userapp/presentation/report_issue/widget/cancel_submit_button.dart';
import 'package:gauva_userapp/presentation/report_issue/widget/details_field.dart';
import 'package:gauva_userapp/presentation/report_issue/widget/report_type_dropdown.dart';
import 'package:gauva_userapp/presentation/report_issue/widget/top_content.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/widgets/buttons/app_back_button.dart';
import '../../../generated/l10n.dart';

class ReportIssueView extends ConsumerStatefulWidget {
  const ReportIssueView(this.orderId, {super.key});
  final int? orderId;

  @override
  ConsumerState<ReportIssueView> createState() => _ReportIssueViewState();
}

class _ReportIssueViewState extends ConsumerState<ReportIssueView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(selectReportTypeProvider.notifier).reset();
      ref.read(reportTypesNotifierProvider.notifier).getReportTypes();
    });
  }

  TextEditingController detailsController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    detailsController.dispose();
  }

  bool isDark() => isDarkMode();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: AppBackButton(color: isDark() ? Colors.white : null),
      title: Text(
        AppLocalizations.of(context).reportIssue,
        style: context.bodyMedium?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: isDark() ? Colors.white : const Color(0xFF24262D),
        ),
      ),
    ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    // floatingActionButton: cancelSubmitButton(
    //   context,
    //   orderId: widget.orderId,
    //   details: detailsController,
    //   reportType: ref.watch(selectReportTypeProvider)?.reportType, isDark: isDark(),
    // ),
    body: Column(
      children: [
        Expanded(
          child: Container(
            color: isDark() ? AppColors.surface : Colors.white,
            padding: EdgeInsets.all(16.r),
            margin: EdgeInsets.only(top: 8.h, bottom: 100.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.images.reportIssue.image(height: 60.h, width: 60.w, fit: BoxFit.fill),
                  Gap(8.h),
                  topContent(context, isDark: isDark()),
                  Gap(16.h),
                  reportTypeDropdown(context, isDark: isDark()),
                  Gap(12.h),
                  detailsField(context, detailsController, isDark: isDark()),
                ],
              ),
            ),
          ),
        ),
        cancelSubmitButton(
          context,
          orderId: widget.orderId,
          details: detailsController,
          reportType: ref.watch(selectReportTypeProvider)?.reportType,
          isDark: isDark(),
        ),
      ],
    ),
  );
}
