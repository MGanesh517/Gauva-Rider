import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/wallet/widgets/wallet_balance.dart';
import '../../../common/error_view.dart';
import '../../../common/loading_view.dart';
import '../../account_page/provider/theme_provider.dart';
import '../provider/provider.dart';
import '../../payment_method/provider/provider.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({super.key});

  @override
  ConsumerState<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  final TextEditingController customAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(walletsNotifierProvider.notifier).getWallets();
      ref.read(paymentMethodsNotifierProvider.notifier).getPaymentMethods();
    });
  }

  @override
  void dispose() {
    super.dispose();
    customAmountController.dispose();
  }

  bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();
  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletsNotifierProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent so gradient shows through
        statusBarIconBrightness: Brightness.light, // White icons for visibility on gradient
        statusBarBrightness: Brightness.dark, // For iOS
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: isDark() ? AppColors.surface : Colors.white,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          title: Text(
            AppLocalizations.of(context).wallet,
            style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF397098), Color(0xFF942FAF)],
              ),
            ),
          ),
        ),

        resizeToAvoidBottomInset: true,
        body: RefreshIndicator(
          onRefresh: () => ref.read(walletsNotifierProvider.notifier).getWallets(),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(8.h),
                    walletState.when(
                      initial: () => const SizedBox(),
                      loading: () => const LoadingView(),
                      error: (e) => ErrorView(message: e.message),
                      success: (walletModel) {
                        final data = walletModel.data;
                        if (data == null) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context).no_wallet_data_available,
                              style: context.bodyMedium?.copyWith(color: Colors.red),
                            ),
                          );
                        }

                        return Container(
                          color: isDark() ? AppColors.surface : Colors.white,
                          padding: EdgeInsets.all(16.r),
                          child: walletBalance(
                            context,
                            amount: walletModel.data?.balance,
                            customAmountController: customAmountController,
                          ),
                        );
                      },
                    ),
                    // Gap(8.h),
                    // Container(
                    //   color: isDark() ? AppColors.surface : Colors.white,
                    //   padding: EdgeInsets.all(16.r),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         child: Text(
                    //           AppLocalizations.of(context).payment_gateway,
                    //           style: context.bodyMedium?.copyWith(
                    //             fontSize: 18.sp,
                    //             fontWeight: FontWeight.w600,
                    //             color: isDark() ? Colors.white : const Color(0xFF24262D),
                    //           ),
                    //         ),
                    //       ),
                    //       Gap(16.w),
                    //       InkWell(
                    //         onTap: () {
                    //           NavigationService.pushNamed(AppRoutes.addPaymentGateway);
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(8.r),
                    //             border: Border.all(color: ColorPalette.primary50),
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               Text(
                    //                 AppLocalizations.of(context).add_new,
                    //                 style: context.bodyMedium?.copyWith(
                    //                   fontSize: 14.sp,
                    //                   fontWeight: FontWeight.w500,
                    //                   color: ColorPalette.primary50,
                    //                 ),
                    //               ),
                    //               Gap(4.w),
                    //               Icon(Icons.add, color: ColorPalette.primary50, size: 15.h),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Gap(8.h),
                    Container(
                      width: double.infinity.w,
                      color: isDark() ? AppColors.surface : Colors.white,
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        'Transaction History',
                        style: context.bodyMedium?.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark() ? Colors.white : const Color(0xFF24262D),
                        ),
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, _) {
                        final state = ref.watch(paymentMethodsNotifierProvider);

                        return state.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const LoadingView(),
                          success: (transactions) {
                            if (transactions.isEmpty) {
                              return Container(
                                color: isDark() ? AppColors.surface : Colors.white,
                                padding: EdgeInsets.all(16.r),
                                child: Center(
                                  child: Text(
                                    'No transactions yet',
                                    style: context.bodyLarge?.copyWith(color: Colors.grey),
                                  ),
                                ),
                              );
                            }

                            return Container(
                              color: isDark() ? AppColors.surface : Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: transactions.length,
                                itemBuilder: (context, index) {
                                  final transaction = transactions[index];
                                  final bool isLast = index == transactions.length - 1;

                                  // Parse transaction data from API response
                                  final isCredit = transaction.type?.toUpperCase() == 'CREDIT';
                                  final amount = transaction.amount ?? 0.0;
                                  final description = transaction.notes ?? transaction.referenceType ?? 'No description';

                                  return Container(
                                    margin: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: isDark() ? Colors.black12 : const Color(0xFFF6F7F9),
                                      border: isDark() ? Border.all(color: Colors.white24) : null,
                                    ),
                                    padding: EdgeInsets.all(16.r),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(12.r),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isCredit
                                                ? Colors.green.withOpacity(0.1)
                                                : Colors.red.withOpacity(0.1),
                                          ),
                                          child: Icon(
                                            isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                                            color: isCredit ? Colors.green : Colors.red,
                                            size: 20.h,
                                          ),
                                        ),
                                        Gap(12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                transaction.type ?? 'Transaction',
                                                style: context.bodyMedium?.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: isDark() ? Colors.white : const Color(0xFF24262D),
                                                ),
                                              ),
                                              Gap(4.h),
                                              Text(
                                                description,
                                                style: context.bodyMedium?.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xFF687387),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Gap(8.w),
                                        Text(
                                          '${isCredit ? '+' : '-'}₹${amount.toStringAsFixed(2)}',
                                          style: context.bodyMedium?.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: isCredit ? Colors.green : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          error: (e) => Container(
                            color: isDark() ? AppColors.surface : Colors.white,
                            padding: EdgeInsets.all(16.r),
                            child: ErrorView(message: e.message),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
