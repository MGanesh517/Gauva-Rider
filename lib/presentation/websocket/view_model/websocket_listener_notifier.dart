import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/services/rider_websocket_service.dart';
import '../../booking/provider/order_providers.dart';
import '../../track_order/view_model/handle_order_status_update.dart';
import '../../track_order/provider/track_order_provider.dart';
import '../../waypoint/provider/way_point_map_providers.dart';
import '../provider/websocket_provider.dart';

class WebSocketListenerNotifier extends StateNotifier<void> {
  final Ref ref;
  StreamSubscription<Map<String, dynamic>>? _rideStatusSubscription;
  StreamSubscription<Map<String, dynamic>>? _driverLocationSubscription;
  StreamSubscription<Map<String, dynamic>>? _chatMessageSubscription;
  StreamSubscription<Map<String, dynamic>>? _walletUpdateSubscription;

  WebSocketListenerNotifier(this.ref) : super(null);

  /// Start listening to WebSocket streams
  void startListening() {
    final service = ref.read(websocketServiceProvider);
    if (service != null) {
      _listenToRideStatus(service);
      _listenToDriverLocation(service);
      _listenToChatMessages(service);
      _listenToWalletUpdates(service);
    }
  }

  /// Listen to ride status updates
  void _listenToRideStatus(RiderWebSocketService service) {
    _rideStatusSubscription?.cancel();
    _rideStatusSubscription = service.rideStatusStream.listen((data) {
      debugPrint('📱 WebSocket - Ride Status Update: $data');
      
      try {
        String? status;
        int? orderId;

        if (data.containsKey('status')) {
          status = data['status']?.toString().toLowerCase();
        } else if (data.containsKey('ride')) {
          final ride = data['ride'] as Map<String, dynamic>?;
          status = ride?['status']?.toString().toLowerCase();
          orderId = ride?['id'];
        }

        if (data.containsKey('rideId')) {
          orderId = data['rideId'];
        } else if (data.containsKey('id')) {
          orderId = data['id'];
        }

        if (status != null && orderId != null) {
          handleOrderStatusUpdate(
            status: status,
            orderId: orderId,
            ref: ref,
            fromPusher: false, // From WebSocket, not Pusher
          );
        }
      } catch (e) {
        debugPrint('❌ Error handling ride status update: $e');
      }
    });
  }

  /// Listen to driver location updates
  void _listenToDriverLocation(RiderWebSocketService service) {
    _driverLocationSubscription?.cancel();
    _driverLocationSubscription = service.driverLocationStream.listen((data) {
      debugPrint('📍 WebSocket - Driver Location Update: $data');
      
      try {
        double? lat;
        double? lng;

        // Handle different data formats
        if (data.containsKey('lat') && data.containsKey('lng')) {
          lat = data['lat'] is num ? (data['lat'] as num).toDouble() : double.tryParse(data['lat']?.toString() ?? '');
          lng = data['lng'] is num ? (data['lng'] as num).toDouble() : double.tryParse(data['lng']?.toString() ?? '');
        } else if (data.containsKey('data')) {
          final innerData = data['data'] as Map<String, dynamic>?;
          if (innerData != null) {
            lat = innerData['lat'] is num ? (innerData['lat'] as num).toDouble() : double.tryParse(innerData['lat']?.toString() ?? '');
            lng = innerData['lng'] is num ? (innerData['lng'] as num).toDouble() : double.tryParse(innerData['lng']?.toString() ?? '');
          }
        }

        if (lat != null && lng != null) {
          debugPrint('✅ Updating driver location: Lat: $lat, Lng: $lng');
          ref.read(wayPointMapNotifierProvider.notifier).updateForGoToPickup(LatLng(lat, lng));
        } else {
          debugPrint('⚠️ Invalid location data: lat=$lat, lng=$lng');
        }
      } catch (e) {
        debugPrint('❌ Error handling driver location update: $e');
      }
    });
  }

  /// Listen to chat messages
  void _listenToChatMessages(RiderWebSocketService service) {
    _chatMessageSubscription?.cancel();
    _chatMessageSubscription = service.chatMessageStream.listen((data) {
      debugPrint('💬 WebSocket - Chat Message: $data');
      // Chat messages are handled by chat provider
      // This can be extended if needed
    });
  }

  /// Listen to wallet updates
  void _listenToWalletUpdates(RiderWebSocketService service) {
    _walletUpdateSubscription?.cancel();
    _walletUpdateSubscription = service.walletUpdateStream.listen((data) {
      debugPrint('💰 WebSocket - Wallet Update: $data');
      // Wallet updates can be handled here if needed
    });
  }

  /// Stop listening to all streams
  void stopListening() {
    _rideStatusSubscription?.cancel();
    _driverLocationSubscription?.cancel();
    _chatMessageSubscription?.cancel();
    _walletUpdateSubscription?.cancel();
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }
}

// Provider
final websocketListenerNotifierProvider = StateNotifierProvider<WebSocketListenerNotifier, void>(
  (ref) => WebSocketListenerNotifier(ref),
);

