import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/data/models/waypoint.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/booking/provider/booking_providers.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';
import 'package:gauva_userapp/presentation/track_order/provider/track_order_provider.dart';
import '../../booking/provider/route_providers.dart';
import '../../payment_method/provider/provider.dart';
import '../../waypoint/provider/way_point_list_providers.dart';
import '../../waypoint/provider/way_point_map_providers.dart';
import '../../websocket/provider/websocket_provider.dart';
import '../provider/order_in_progress_provider.dart';

void handleOrderStatusUpdate({
  required String status,
  required int? orderId,
  required Ref ref,
  bool fromPusher = false,
  bool? paymentStatus,
}) {
  debugPrint('');
  debugPrint('🎯 ═══════════════════════════════════════════════════════');
  debugPrint('🎯 HANDLE ORDER STATUS UPDATE');
  debugPrint('🎯 Status: $status');
  debugPrint('🎯 Order ID: $orderId');
  debugPrint('🎯 From Pusher: $fromPusher');
  debugPrint('🎯 Payment Status: $paymentStatus');
  debugPrint('🎯 ═══════════════════════════════════════════════════════');

  final orderNotifier = ref.read(orderInProgressNotifier.notifier);
  final mapStateNotifier = ref.read(wayPointMapNotifierProvider.notifier);

  void handlePostPusherActions() {
    ref.read(bookingNotifierProvider.notifier).inProgress();
    // ref.read(chatNotifierProvider.notifier);
    if (status == 'pending') {
      ref.read(trackOrderNotifierProvider.notifier).goToLookingForDriver();
    } else {
      ref.read(trackOrderNotifierProvider.notifier).goToInProgress();
    }
    NavigationService.pushNamedAndRemoveUntil(AppRoutes.bookingPage);
  }

  void resetPaymentAndGoToConfirm() {
    ref.read(selectedPayMethodProvider.notifier).reset();
    orderNotifier.goToConfirmPay();
  }

  Future<void> setMarkerPolylines() async {
    final notifier = ref.read(createOrderNotifierProvider.notifier);
    ref
        .read(createOrderNotifierProvider)
        .whenOrNull(
          success: (data) async {
            final List<Waypoint> waypoints = notifier.constructWaypoints(data);
            ref.read(wayPointListNotifierProvider.notifier).setWayPointList(waypoints);
            ref.read(routeNotifierProvider.notifier).fetchRoutes();
          },
        );
  }

  switch (status) {
    case 'pending':
      debugPrint('⏳ Status: PENDING - Waiting for driver');
      break;

    case 'accepted':
      debugPrint('✅ Status: ACCEPTED - Driver accepted ride');

      if (fromPusher) {
        ref.read(createOrderNotifierProvider.notifier).orderDetailsForCancelRide(orderId: orderId ?? 0);
        ref.read(trackOrderNotifierProvider.notifier).goToInProgress();
      } else {
        setMarkerPolylines();
        mapStateNotifier.updateForAccepted();
      }
      orderNotifier.goToOrderAccept();
      break;

    case 'go_to_pickup':
      debugPrint('🚗 Status: GO_TO_PICKUP - Driver heading to pickup');
      orderNotifier.goToHeadingPickup();

      setMarkerPolylines();
      mapStateNotifier.updateForAccepted();
      break;

    case 'confirm_arrival':
      debugPrint('📍 Status: CONFIRM_ARRIVAL - Driver at pickup point');
      orderNotifier.goToPickupPoint();
      setMarkerPolylines();
      mapStateNotifier.updateForAccepted();

      break;

    case 'picked_up':
      debugPrint('🚙 Status: PICKED_UP - Rider in car');
      orderNotifier.goToInsideCarReadyToMove();
      mapStateNotifier.updateForPickedUp();
      break;

    case 'start_ride':
      debugPrint('🏁 Status: START_RIDE - Heading to destination');
      orderNotifier.goToHeadingToDestination();
      setMarkerPolylines();
      mapStateNotifier.updateForPickedUp();
      break;

    case 'dropped_off':
      debugPrint('🎉 Status: DROPPED_OFF - Ride completed');
      ref.read(wayPointMapNotifierProvider.notifier).stopTracking();

      // Leave WebSocket ride room
      if (orderId != null) {
        debugPrint('🚴 Leaving WebSocket ride room: $orderId');
        ref.read(websocketProvider.notifier).leaveRideRoom();
      }

      if (fromPusher) {
        orderId != null
            ? ref.read(createOrderNotifierProvider.notifier).orderDetailsForCancelRide(orderId: orderId)
            : null;
        resetPaymentAndGoToConfirm();
      } else {
        if (paymentStatus != null && paymentStatus) {
          orderNotifier.gotToFeedback();
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.bookingPage);
        } else {
          resetPaymentAndGoToConfirm();
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.bookingPage);
        }
      }
      break;

    case 'completed':
      debugPrint('✅ Status: COMPLETED - Ride finished');

      // Leave WebSocket ride room
      if (orderId != null) {
        debugPrint('🚴 Leaving WebSocket ride room: $orderId');
        ref.read(websocketProvider.notifier).leaveRideRoom();
      }

      if (!fromPusher) {
        debugPrint('🏠 Navigating to dashboard');
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
      }
      break;

    default:
      debugPrint('⚠️ Unknown status: $status');
  }

  if (!fromPusher && status != 'completed') {
    debugPrint('🔗 Setting up Pusher listeners for real-time updates');
    handlePostPusherActions();
  }

  debugPrint('🎯 ═══════════════════════════════════════════════════════');
  debugPrint('');
}
