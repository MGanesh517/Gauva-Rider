import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_back_button.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/ride_history/widgets/ride_activity_card.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/change_status_bar.dart';
import '../../../core/utils/is_arabic.dart';
import '../../../generated/l10n.dart';
import '../../track_order/views/confirm_pay.dart';
import '../../track_order/widgets/read_able_location_view.dart';
import '../provider/download_receipt_provider.dart';

class RideDetailsPage extends ConsumerStatefulWidget {
  const RideDetailsPage({super.key, required this.order});
  final Order order;

  @override
  ConsumerState<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends ConsumerState<RideDetailsPage> {
  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  @override
  void dispose() {
    setStatusBar(isDark: isDark);
    super.dispose();
  }

  void _copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showNotification(message: AppLocalizations.of(context).textCopied, isSuccess: true);
  }

  @override
  Widget build(BuildContext context) {
    final bool isComplete = widget.order.status != null && widget.order.status!.toLowerCase().contains('completed');
    final bool isDark = isDarkMode();
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      //   decoration:  BoxDecoration(
      //     color: isDarkMode() ? AppColors.surface : Colors.white,
      //   ),
      //   child: Row(
      //     children: [
      //       Expanded(
      //           child: issueButton(
      //               context,
      //               onTap: (){
      //                 NavigationService.pushNamed(AppRoutes.reportIssue, arguments: widget.order.id);
      //               },
      //               title: AppLocalizations.of(context).reportIssue,
      //               icon: Ionicons.book_outline,
      //               backgroundColor: const Color(0xFFFFF1EE),
      //               textColor: const Color(0xFFFF5630))),
      //       Gap(!isComplete ? 0 : 16.w),
      //       !isComplete
      //           ? const SizedBox.shrink()
      //           : Consumer(
      //         builder: (context, ref, _) {
      //
      //
      //           final bool isLoading = ref.watch(downloadReceiptProvider).whenOrNull(loading: ()=> true) ?? false;
      //
      //           return Expanded(
      //             child: issueButton(
      //               context,
      //               title: AppLocalizations.of(context).downloadReceipt,
      //               isLoading: isLoading,
      //               onTap: () async {
      //                 ref.read(downloadReceiptProvider.notifier).getDownloadLink(id: widget.order.id);
      //               },
      //               icon: Ionicons.download,
      //               backgroundColor: const Color(0xFFF1F7FE),
      //               textColor: const Color(0xFF1469B5),
      //             ),
      //           );
      //         },
      //       )
      //
      //
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        leading: AppBackButton(color: isDark ? Colors.white : null),
        title: Text(
          AppLocalizations.of(context).rideDetails,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : const Color(0xFF24262D),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              _copyText(context, '${widget.order.id}');
            },
            child: IntrinsicWidth(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      (widget.order.id ?? 0).toString(),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.primary50,
                      ),
                    ),
                  ),
                  Gap(8.w),
                  const Icon(Icons.copy, color: ColorPalette.primary50, size: 20),
                ],
              ),
            ),
          ),
          Gap(16.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 8.r),
                padding: EdgeInsets.all(16.r),
                color: isDarkMode() ? AppColors.surface : Colors.white,
                child: Column(
                  children: [
                    rideActivityCard(context, order: widget.order, showCancelItem: !isComplete, isDark: isDark),
                    Gap(8.h),
                    readAbleLocationView(
                      context,
                      widget.order.addresses,
                      backGroundColor: isDark ? AppColors.surface : Colors.white,
                      isDark: isDark,
                    ),
                    Gap(isComplete ? 16.h : 0),
                    !isComplete
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                            child: rowTextDetail(
                              context,
                              title: AppLocalizations.of(context).status,
                              value: Expanded(
                                child: Text(
                                  widget.order.status?.capitalize() ?? 'N/A',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: context.bodyMedium?.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isComplete ? const Color(0xFF36B37E) : const Color(0xFFFF5630),
                                  ),
                                ),
                              ),
                              isDark: isDark,
                            ),
                          )
                        : serviceOverView(
                            context,
                            widget.order,
                            widgets: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                                child: rowTextDetail(
                                  context,
                                  title: AppLocalizations.of(context).status,
                                  value: Expanded(
                                    child: Text(
                                      widget.order.status?.capitalize() ?? 'N/A',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: context.bodyMedium?.copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: isComplete ? const Color(0xFF36B37E) : const Color(0xFFFF5630),
                                      ),
                                    ),
                                  ),
                                  isDark: isDark,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                                child: rowTextDetail(
                                  context,
                                  title: AppLocalizations.of(context).paymentMethod,
                                  value: Expanded(
                                    child: Text(
                                      widget.order.payMethod?.capitalize() ?? 'N/A',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                      style: context.bodyMedium?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                                      ),
                                    ),
                                  ),
                                  isDark: isDark,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: const Divider(),
                              ),
                            ],
                            isDark: isDark,
                          ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(color: isDarkMode() ? AppColors.surface : Colors.white),
            child: Row(
              children: [
                Expanded(
                  child: issueButton(
                    context,
                    onTap: () {
                      NavigationService.pushNamed(AppRoutes.reportIssue, arguments: widget.order.id);
                    },
                    title: AppLocalizations.of(context).reportIssue,
                    icon: Ionicons.book_outline,
                    backgroundColor: const Color(0xFFFFF1EE),
                    textColor: const Color(0xFFFF5630),
                  ),
                ),
                Gap(!isComplete ? 0 : 16.w),
                !isComplete
                    ? const SizedBox.shrink()
                    : Consumer(
                        builder: (context, ref, _) {
                          final bool isLoading =
                              ref.watch(downloadReceiptProvider).whenOrNull(loading: () => true) ?? false;

                          return Expanded(
                            child: issueButton(
                              context,
                              title: AppLocalizations.of(context).downloadReceipt,
                              isLoading: isLoading,
                              onTap: () async {
                                ref.read(downloadReceiptProvider.notifier).getDownloadLink(id: widget.order.id);
                              },
                              icon: Ionicons.download,
                              backgroundColor: const Color(0xFFF1F7FE),
                              textColor: const Color(0xFF1469B5),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
          Gap(isIos() ? 0 : 16.h),
        ],
      ),
    );
  }
}

Widget rowTextDetail(BuildContext context, {required String title, Widget? value, required bool isDark}) => Row(
  children: [
    Expanded(
      child: Text(
        title,
        textAlign: isArabic() ? TextAlign.right : TextAlign.left,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
        ),
      ),
    ),
    if (value != null) value,
  ],
);

Widget issueButton(
  BuildContext context, {
  String title = '',
  IconData? icon,
  Color? backgroundColor,
  Color? textColor,
  Function()? onTap,
  bool isLoading = false,
}) => InkWell(
  onTap: isLoading ? null : onTap,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4.r)),
    child: isLoading
        ? SizedBox(
            height: 25.h,
            width: 25.w,
            child: const Center(child: CircularProgressIndicator()),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 18.h),
              Gap(6.w),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: textColor),
                ),
              ),
            ],
          ),
  ),
);
