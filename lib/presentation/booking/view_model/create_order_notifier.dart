import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/core/state/app_state.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/data/models/waypoint.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/repositories/interfaces/order_repo_interface.dart';
import '../../splash/provider/app_flow_provider.dart';
import '../../track_order/provider/track_order_provider.dart';
import '../../websocket/provider/websocket_provider.dart';
import '../provider/booking_providers.dart';

class CreateOrderNotifier extends StateNotifier<AppState<Order>> {
  final IOrderRepo orderRepo;
  final Ref ref;

  CreateOrderNotifier(this.orderRepo, this.ref) : super(const AppState.initial());

  Future<void> createOrder({required Map<String, dynamic> orderData}) async {
    debugPrint('');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');
    debugPrint('🔵 CREATE ORDER - Starting');
    debugPrint('🔵 Order Data: $orderData');
    debugPrint('🔵 ═══════════════════════════════════════════════════════');

    state = const AppState.loading();
    final result = await orderRepo.createOrder(data: orderData);
    result.fold(
      (failure) {
        debugPrint('🔴 CREATE ORDER FAILED: ${failure.message}');
        _handleFailure(failure);
      },
      (data) {
        debugPrint('🟢 CREATE ORDER SUCCESS');
        debugPrint('🟢 Order ID: ${data.data?.order?.id}');
        debugPrint('🟢 Status: ${data.data?.order?.status}');

        // Handle null order gracefully
        if (data.data?.order != null) {
          // Extract user UUID from response if available
          final userUuid = data.data?.userUuid;
          handleOrderCreationSuccess(data.data!.order!, userUuid: userUuid);
        } else {
          debugPrint('⚠️ CREATE ORDER - Order is null in response');
          _handleFailure(Failure(message: 'Order creation failed: Order data is missing'));
        }
      },
    );
  }

  Future<void> fetchOrderDetails({required int orderId}) async {
    state = const AppState.loading();
    final result = await orderRepo.orderDetails(orderId: orderId);

    result.fold((failure) => state = AppState.error(failure), (data) async {
      state = AppState.success(data.data!);
    });
  }

  // Deprecated: Use fetchOrderDetails instead
  Future<void> orderDetailsForCancelRide({required int orderId}) async {
    await fetchOrderDetails(orderId: orderId);
  }

  Future<void> setOrderData(Order order) async {
    await LocalStorageService().saveOrderId(order.id);
    state = AppState.success(order);
  }

  void reset() {
    state = const AppState.initial();
  }

  Future<void> handleOrderCreationSuccess(Order data, {String? userUuid}) async {
    state = AppState.success(data);
    await LocalStorageService().saveOrderId(data.id);

    // Join WebSocket ride room for real-time updates
    if (data.id != null) {
      debugPrint('🔌 WebSocket - Preparing to join ride room for ride ${data.id}');
      try {
        final wsNotifier = ref.read(websocketProvider.notifier);

        // Ensure connected
        if (!wsNotifier.isConnected) {
          debugPrint('🔌 WebSocket - Not connected, attempting to connect...');
          await wsNotifier.setupWebSocketListeners();
          // Give it a moment to stabilize if needed, though initializeRider awaits connection
        }

        if (wsNotifier.isConnected) {
          await wsNotifier.joinRideRoom(data.id!);
          debugPrint('✅ WebSocket - Joined ride room ${data.id}');
        } else {
          debugPrint('❌ WebSocket - Failed to connect, cannot join ride room.');
        }
      } catch (e) {
        debugPrint('⚠️ WebSocket - Error while joining ride room: $e');
        // Continue - app can work without WebSocket
      }
    }

    ref.read(trackOrderNotifierProvider.notifier).reset();
    ref.read(bookingNotifierProvider.notifier)
      ..resetState()
      ..inProgress();
  }

  List<Waypoint> constructWaypoints(Order data) {
    final waypoints = <Waypoint>[
      Waypoint(
        name: 'Pick-up point',
        address: data.addresses?.pickupAddress ?? '',
        location: LatLng(
          data.points?.pickupLocation?.first.toDouble() ?? 0,
          data.points?.pickupLocation?.last.toDouble() ?? 0,
        ),
      ),
      Waypoint(
        name: 'Drop-off Point',
        address: data.addresses?.dropAddress ?? '',
        location: LatLng(
          data.points?.dropLocation?.first.toDouble() ?? 0,
          data.points?.dropLocation?.last.toDouble() ?? 0,
        ),
      ),
    ];

    return waypoints;
  }

  void navigateToHome({String? status, bool? isSuccess = true}) {
    // Leave WebSocket ride room
    ref.read(websocketProvider.notifier).leaveRideRoom();
    LocalStorageService().clearOrderId();
    showNotification(message: 'Your Ride was $status', isSuccess: isSuccess ?? false);
    NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
  }

  void _handleFailure(failure) {
    state = AppState.error(failure);
    showNotification(message: failure.message);
  }
}

class CheckTripActivityNotifier extends StateNotifier<AppState<Order?>> {
  final IOrderRepo orderRepo;
  final Ref ref;

  CheckTripActivityNotifier(this.orderRepo, this.ref) : super(const AppState.initial());
  Future<void> checkTripActivity() async {
    debugPrint('');
    debugPrint('🔍 ═══════════════════════════════════════════════════════');
    debugPrint('🔍 CHECK TRIP ACTIVITY - Starting');
    debugPrint('🔍 ═══════════════════════════════════════════════════════');

    if (await LocalStorageService().getToken() != null) {
      state = const AppState.loading();
      final result = await orderRepo.checkActiveTrip();
      result.fold(
        (failure) {
          debugPrint('🔴 CHECK TRIP ACTIVITY FAILED: ${failure.message}');
          _handleFailure(failure);
        },
        (data) {
          if (data.data?.order != null) {
            debugPrint('🟢 ACTIVE TRIP FOUND');
            debugPrint('🟢 Order ID: ${data.data!.order!.id}');
            debugPrint('🟢 Status: ${data.data!.order!.status}');
            state = AppState.success(data.data!.order);
            ref.read(createOrderNotifierProvider.notifier).setOrderData(data.data!.order!);
          } else {
            debugPrint('✅ NO ACTIVE TRIP');
            state = const AppState.success(null);
          }
        },
      );
    } else {
      debugPrint('⚠️ No token found - user not logged in');
      state = const AppState.success(null);
    }
    ref.read(appFlowNotifierProvider.notifier).setAppFlowState();
  }

  void _handleFailure(failure) {
    state = AppState.error(failure);
    showNotification(message: failure.message);
  }
}
