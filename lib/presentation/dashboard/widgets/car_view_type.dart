import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/car_grid_view.dart';
import '../../../generated/l10n.dart';
import '../../account_page/provider/theme_provider.dart';
import '../viewmodel/car_type_notifier.dart';

class CarSelectionView extends ConsumerWidget {
  const CarSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // PERFORMANCE OPTIMIZATION: Watch only serviceListState instead of entire state
    final serviceState = ref.watch(
      carTypeNotifierProvider.select((state) => state.serviceListState),
    );
    final notifier = ref.read(carTypeNotifierProvider.notifier);
    // PERFORMANCE OPTIMIZATION: Cache theme check
    final isDarkMode = ref.read(themeModeProvider.notifier).isDarkMode();

    final bool showNothing = serviceState.whenOrNull(error: (e) => true, success: (data) => data.isEmpty) ?? false;
    if (showNothing) {
      return const SizedBox.shrink();
    }
    return RepaintBoundary(
      // PERFORMANCE OPTIMIZATION: RepaintBoundary prevents unnecessary repaints
      child: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 0, bottom: 12.h),
        decoration: BoxDecoration(color: isDarkMode ? Colors.black : Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppLocalizations().services,
            textAlign: TextAlign.start,
            style: context.bodyMedium?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          const Gap(12),
          serviceState.when(
            initial: () => Text(
              AppLocalizations().please_wait,
              style: context.bodyMedium?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            loading: () => const SizedBox(height: 80, child: Center(child: LoadingView())),
              success: (data) {
                // Read state only when needed (for carGridView)
                final state = ref.read(carTypeNotifierProvider);
                return carGridView(list: data, notifier: notifier, state: state);
              },
            error: (e) => Text(
              e.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
