import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';
import 'package:gauva_userapp/presentation/track_order/provider/order_in_progress_provider.dart';
import 'package:gauva_userapp/presentation/track_order/views/confirm_pay.dart';
import 'package:gauva_userapp/presentation/track_order/views/feed_back.dart';
import 'package:gauva_userapp/presentation/track_order/views/heading_to_destination.dart';
import 'package:gauva_userapp/presentation/track_order/views/heading_to_pick_up.dart';
import 'package:gauva_userapp/presentation/track_order/views/in_pick_up_point.dart';
import 'package:gauva_userapp/presentation/track_order/views/inside_car_ready_to_move.dart';
import 'package:gauva_userapp/presentation/track_order/views/order_accept_sheet.dart';

import '../../../core/utils/color_palette.dart';
import '../../../data/services/local_storage_service.dart';
import '../../waypoint/widgets/app_card_sheet.dart';

class OrderInProgressSheet extends ConsumerStatefulWidget {
  const OrderInProgressSheet({super.key});

  @override
  ConsumerState<OrderInProgressSheet> createState() => _OrderInProgressSheetState();
}

class _OrderInProgressSheetState extends ConsumerState<OrderInProgressSheet> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _isVisible = true;

  final double hiddenOffset = 0.85; // how much hidden when minimized

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      LocalStorageService().saveChatState(isOpen: false);
    });
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, hiddenOffset),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleSheet() {
    if (_isVisible) {
      _controller.forward(); // hide
    } else {
      _controller.reverse(); // show
    }
    setState(() => _isVisible = !_isVisible);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isVisible && details.delta.dy < -6) {
      _toggleSheet(); // drag up to show
    } else if (_isVisible && details.delta.dy > 6) {
      _toggleSheet(); // drag down to hide
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: !isIos(),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: _animation,
        child: GestureDetector(
          onTap: _toggleSheet,
          onVerticalDragUpdate: _onDragUpdate,
          child: Container(
            width: double.infinity,
            decoration: context.responsive(
              const BoxDecoration(
                color: ColorPalette.primary20,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              xl: const BoxDecoration(),
            ),
            child: _isVisible
                ? Consumer(
                    builder: (context, ref, _) {
                      final createOrderState = ref.watch(createOrderNotifierProvider);
                      return createOrderState.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const LoadingView(),
                        success: (data) {
                          final state = ref.watch(orderInProgressNotifier);
                          return AppCardSheet(
                            child: state.when(
                              orderAccept: () => orderAcceptSheet(context, data, isDark: isDark()),
                              headingToPickup: () => headingToPickUp(context, data, isDark: isDark()),
                              inPickupPoint: () => inPickupPoint(context, data, isDark: isDark()),
                              inSideCarReadyToMove: () => insideCarReadyToMove(context, data, isDark: isDark()),
                              headingToDestination: () => headingToDestination(context, isDark: isDark()),
                              confirmPay: () => confirmPay(context, data, isDark: isDark()),
                              feedback: () => feedback(context, data, isDark: isDark()),
                            ),
                          );
                        },
                        error: (e) => Center(child: Text(e.message)),
                      );
                    },
                  )
                : AppCardSheet(
                    child: SizedBox(height: 300.h, width: double.infinity),
                  ),
          ),
        ),
      ),
    ),
  );
}
