import 'dart:async';
import 'package:gauva_userapp/data/services/websocket_service.dart';

class RiderWebSocketService extends WebSocketService {
  String? userId;
  int? currentRideId;

  bool _isInitializing = false;
  StreamSubscription<void>? _reconnectSubscription;

  /// Initialize and connect for rider
  Future<void> initializeRider({required String jwtToken, required int userId}) async {
    // Prevent multiple initialization attempts
    if (_isInitializing) {
      print('⚠️ Rider WebSocket: Already initializing, skipping...');
      return;
    }

    if (isConnected && this.userId == userId.toString()) {
      print('⚠️ Rider WebSocket: Already connected for rider $userId, skipping...');
      return;
    }

    _isInitializing = true;
    this.userId = userId.toString();

    // Listen for reconnection events to re-join rooms
    _reconnectSubscription?.cancel();
    _reconnectSubscription = onReconnected.listen((_) {
      _rejoinRoomsAfterReconnect();
    });

    try {
      // Connect to Raw WebSocket
      await connect(jwtToken);

      // Wait for connection
      await Future.delayed(const Duration(seconds: 3));

      if (!isConnected) {
        await Future.delayed(const Duration(seconds: 3));
        if (!isConnected) {
          _isInitializing = false;
          throw Exception('Failed to connect to WebSocket');
        }
      }

      sendMessage({'event': 'join', 'type': 'user', 'id': userId});

      _isInitializing = false;
      print('✅ Rider WebSocket initialized (Connected: $isConnected)');
    } catch (e) {
      _isInitializing = false;
      print('❌ Rider WebSocket: Error during initialization: $e');
      rethrow;
    }
  }

  /// Re-join rooms after reconnection
  void _rejoinRoomsAfterReconnect() {
    print('🔄 Rider WebSocket: Re-joining rooms after reconnection...');
    
    // Re-join user room
    if (userId != null) {
      sendMessage({'event': 'join', 'type': 'user', 'id': userId});
      print('✅ Rider WebSocket: Re-joined user room: $userId');
    }

    // Re-join ride room if there's an active ride
    if (currentRideId != null) {
      sendMessage({'event': 'join', 'type': 'ride', 'id': currentRideId.toString()});
      print('✅ Rider WebSocket: Re-joined ride room: $currentRideId');
    }
  }

  /// Join ride room (when ride is active)
  void joinRideRoom(int rideId) {
    currentRideId = rideId;

    // Join ride room
    sendMessage({'event': 'join', 'type': 'ride', 'id': rideId.toString()});
  }

  /// Leave ride room (when ride ends)
  void leaveRideRoom() {
    if (currentRideId != null) {
      sendMessage({'event': 'leave', 'type': 'ride', 'id': currentRideId.toString()});
      currentRideId = null;
    }
  }

  /// Send chat message to driver
  void sendMessageToDriver({
    required int rideId,
    required String message,
    required String senderName,
    required String driverId,
  }) {
    // Send via WebSocket
    sendMessage({
      'event': 'chat',
      'rideId': rideId,
      'senderId': userId,
      'senderName': senderName,
      'receiverId': driverId,
      'message': message,
      // 'timestamp': DateTime.now().toIso8601String(), // Server might add this
    });
  }

  @override
  void disconnect() {
    _reconnectSubscription?.cancel();
    _reconnectSubscription = null;
    super.disconnect();
  }
}
