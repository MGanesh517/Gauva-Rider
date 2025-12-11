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
    final state = ref.watch(carTypeNotifierProvider);
    final notifier = ref.read(carTypeNotifierProvider.notifier);
    final serviceState = state.serviceListState;
    bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();

    final bool showNothing = serviceState.whenOrNull(error: (e) => true, success: (data) => data.isEmpty) ?? false;
    if (showNothing) {
      return const SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: isDark() ? Colors.black : Colors.white),
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
            loading: () => const SizedBox(height: 100, child: Center(child: LoadingView())),
            success: (data) => carGridView(list: data, notifier: notifier, state: state),
            error: (e) => Text(
              e.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
