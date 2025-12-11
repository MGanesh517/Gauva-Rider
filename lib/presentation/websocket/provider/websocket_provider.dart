import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/services/rider_websocket_service.dart';
import '../../../data/services/local_storage_service.dart';

class WebSocketNotifier extends StateNotifier<WebSocketState> {
  RiderWebSocketService? _riderService;

  WebSocketNotifier() : super(const WebSocketState.initial());

  bool get isConnected => _riderService?.isStompConnected ?? false;

  // Initialize for rider
  Future<void> initializeRider({required String jwtToken, required String userId}) async {
    try {
      state = const WebSocketState.connecting();

      _riderService = RiderWebSocketService();
      await _riderService!.initializeRider(jwtToken: jwtToken, userId: userId);

      // Wait a bit for connection to establish
      await Future.delayed(const Duration(seconds: 2));

      if (_riderService!.isStompConnected) {
        state = WebSocketState.connected(_riderService!);
        debugPrint('✅ WebSocket connected successfully');
      } else {
        state = const WebSocketState.error('Failed to establish connection');
        debugPrint('❌ WebSocket connection failed');
      }
    } catch (e) {
      state = WebSocketState.error(e.toString());
      debugPrint('❌ WebSocket initialization error: $e');
    }
  }

  // Initialize from stored credentials
  Future<void> initializeFromStorage() async {
    try {
      final token = await LocalStorageService().getToken();
      final user = await LocalStorageService().getSavedUser();

      if (token == null || token.isEmpty) {
        debugPrint('⚠️ No token found, skipping WebSocket initialization');
        return;
      }

      if (user == null) {
        debugPrint('⚠️ No user found, skipping WebSocket initialization');
        return;
      }

      final userId = user.id.toString();
      await initializeRider(jwtToken: token, userId: userId);
    } catch (e) {
      debugPrint('❌ Error initializing WebSocket from storage: $e');
    }
  }

  // Join ride room
  void joinRideRoom(int rideId) {
    _riderService?.joinRideRoom(rideId);
  }

  // Leave ride room
  void leaveRideRoom() {
    _riderService?.leaveRideRoom();
  }

  // Send message to driver
  void sendMessageToDriver({
    required int rideId,
    required String message,
    required String senderName,
    required String driverId,
  }) {
    _riderService?.sendMessageToDriver(
      rideId: rideId,
      message: message,
      senderName: senderName,
      driverId: driverId,
    );
  }

  // Disconnect
  void disconnect() {
    _riderService?.disconnect();
    _riderService = null;
    state = const WebSocketState.initial();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}

// WebSocket State
sealed class WebSocketState {
  const WebSocketState();

  const factory WebSocketState.initial() = _Initial;
  const factory WebSocketState.connecting() = _Connecting;
  const factory WebSocketState.connected(RiderWebSocketService service) = _Connected;
  const factory WebSocketState.error(String message) = _Error;
}

class _Initial extends WebSocketState {
  const _Initial();
}

class _Connecting extends WebSocketState {
  const _Connecting();
}

class _Connected extends WebSocketState {
  final RiderWebSocketService service;
  const _Connected(this.service);
}

class _Error extends WebSocketState {
  final String message;
  const _Error(this.message);
}

// Provider
final websocketProvider = StateNotifierProvider<WebSocketNotifier, WebSocketState>((ref) {
  return WebSocketNotifier();
});

// Helper provider to get the service when connected
final websocketServiceProvider = Provider<RiderWebSocketService?>((ref) {
  final state = ref.watch(websocketProvider);
  return state is _Connected ? state.service : null;
});

