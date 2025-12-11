import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/error_view.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/custom_dropdown.dart';
import 'package:gauva_userapp/data/models/report_response/report_type_response.dart';

import '../../../generated/l10n.dart';
import '../provider/report_provider.dart';

Widget reportTypeDropdown(BuildContext context, {Function(String v)? onChange, required bool isDark}) => Consumer(
  builder: (context, ref, _) {
    final selectedState = ref.watch(selectReportTypeProvider);
    final selectedStateNotifier = ref.watch(selectReportTypeProvider.notifier);
    final state = ref.watch(reportTypesNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).reportType,
          textAlign: TextAlign.start,
          style: context.bodyMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF24262D),
          ),
        ),
        Gap(12.h),
        state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const LoadingView(),
          success: (list) => customDropdown(
            context,
            value: selectedState,
            hint: AppLocalizations.of(context).selectReportType,
            items: list
                .map(
                  (e) => DropdownMenuItem<ReportTypes>(
                    value: e,
                    child: Text(
                      e.reportType ?? '',
                      style: context.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF687387),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                selectedStateNotifier.setReportType(v);
              }
            },
          ),
          error: (e) => ErrorView(message: e.message),
        ),
      ],
    );
  },
);
