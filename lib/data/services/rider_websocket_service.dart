import 'dart:async';
import 'package:flutter/foundation.dart';
import 'websocket_service.dart';

class RiderWebSocketService extends WebSocketService {
  String? userId;
  int? currentRideId;

  /// Initialize and connect for rider
  Future<void> initializeRider({
    required String jwtToken,
    required String userId,
  }) async {
    this.userId = userId;

    debugPrint('🔌 ═══════════════════════════════════════════════════════');
    debugPrint('🔌 INITIALIZING WEBSOCKET FOR RIDER');
    debugPrint('🔌 User ID: $userId');
    debugPrint('🔌 ═══════════════════════════════════════════════════════');

    // PRIMARY: Connect to STOMP (works on Azure)
    debugPrint('🔌 [PRIMARY] Connecting to STOMP...');
    await connectStomp(jwtToken);

    // OPTIONAL: Try Socket.IO (may not work on Azure - that's OK)
    // Don't wait for it - continue even if it fails
    debugPrint('🔌 [OPTIONAL] Attempting Socket.IO connection...');
    connectSocketIO(jwtToken).catchError((error) {
      debugPrint('⚠️ Socket.IO connection failed (expected on Azure): $error');
      debugPrint('✅ Continuing with STOMP only');
    });

    // Wait for STOMP connection
    int attempts = 0;
    while (!isStompConnected && attempts < 10) {
      await Future.delayed(const Duration(milliseconds: 500));
      attempts++;
    }

    if (!isStompConnected) {
      throw Exception('Failed to connect to STOMP WebSocket after ${attempts * 500}ms');
    }

    // Join user room via Socket.IO (if available)
    if (isSocketIOConnected) {
      debugPrint('✅ [OPTIONAL] Socket.IO connected - joining user room');
      joinRoom('user', userId);
    } else {
      debugPrint('ℹ️ [OPTIONAL] Socket.IO not available - using STOMP only');
    }

    debugPrint('✅ Rider WebSocket initialized successfully');
    debugPrint('✅ STOMP: ${isStompConnected ? "Connected" : "Disconnected"}');
    debugPrint('✅ Socket.IO: ${isSocketIOConnected ? "Connected" : "Not Available"}');
  }


  /// Join ride room (when ride is active)
  void joinRideRoom(int rideId) {
    currentRideId = rideId;

    debugPrint('📡 ═══════════════════════════════════════════════════════');
    debugPrint('📡 JOINING RIDE ROOM');
    debugPrint('📡 Ride ID: $rideId');
    debugPrint('📡 ═══════════════════════════════════════════════════════');

    // Join via Socket.IO (for ride_status, driver_location, chat_message)
    if (isSocketIOConnected) {
      debugPrint('📡 [Socket.IO] Joining ride and user rooms');
      joinRoom('ride', rideId);
      if (userId != null) {
        joinRoom('user', userId);
      }
    }

    // Subscribe to STOMP topics for this ride
    // Wait a bit for connection to be fully established
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!isStompConnected || stompClient == null) {
        debugPrint('⚠️ STOMP not connected, cannot subscribe to ride topics');
        return;
      }

      debugPrint('📡 [STOMP] Subscribing to ride-specific topics...');

      // STOMP is used for location tracking and chat
      subscribeToStompTopic(
        '/topic/ride/$rideId/location', // Actual backend topic
        (data) {
          debugPrint('📍 STOMP Driver Location: $data');
          addDriverLocation(data);
        },
      );

      subscribeToStompTopic(
        '/topic/chat/ride/$rideId', // Actual backend topic
        (data) {
          debugPrint('💬 STOMP Chat Message: $data');
          addChatMessage(data);
        },
      );

      debugPrint('✅ Subscribed to ride-specific STOMP topics');
    });
  }

  /// Leave ride room (when ride ends)
  void leaveRideRoom() {
    if (currentRideId != null) {
      debugPrint('🚴 ═══════════════════════════════════════════════════════');
      debugPrint('🚴 LEAVING RIDE ROOM');
      debugPrint('🚴 Ride ID: $currentRideId');
      debugPrint('🚴 ═══════════════════════════════════════════════════════');

      if (isSocketIOConnected) {
        leaveRoom('ride', currentRideId);
      }
      currentRideId = null;
      debugPrint('✅ Left ride room');
    }
  }

  /// Send chat message to driver
  void sendMessageToDriver({
    required int rideId,
    required String message,
    required String senderName,
    required String driverId,
  }) {
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();

    // Send via Socket.IO
    if (isSocketIOConnected) {
      sendChatMessage(
        rideId: rideId,
        senderId: userId!,
        senderName: senderName,
        receiverId: driverId,
        message: message,
        messageId: messageId,
      );
    }

    // Also send via STOMP (REST API endpoint, not WebSocket)
    // Chat is sent via REST API: POST /api/chat/ride/{rideId}/messages
    // The server then broadcasts via Socket.IO and STOMP
  }
}

