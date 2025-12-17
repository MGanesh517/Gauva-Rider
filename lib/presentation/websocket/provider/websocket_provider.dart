import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/services/rider_websocket_service.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/presentation/profile/provider/rider_details_provider.dart';

class WebSocketNotifier extends StateNotifier<void> {
  final Ref ref;
  final RiderWebSocketService _riderWebSocketService = RiderWebSocketService();

  WebSocketNotifier(this.ref) : super(null);

  /// Setup WebSocket and subscribe to necessary topics
  Future<void> setupWebSocketListeners() async {
    try {
      print('🔌 WebSocket Notifier: Setting up WebSocket listeners...');

      // Get JWT token first
      final token = await LocalStorageService().getToken();
      if (token == null || token.isEmpty) {
        print('❌ WebSocket Notifier: No token found');
        return;
      }

      // Get user ID with retry mechanism (in case user data is still being saved)
      int userId = await _getUserIdWithRetry();

      // Fallback: If user ID is 0 (invalid), try to fetch profile from API
      if (userId == 0) {
        print('⚠️ WebSocket Notifier: User ID missing after retries. Attempting to fetch profile...');

        // Trigger profile fetch
        await ref.read(riderDetailsNotifierProvider.notifier).getRiderDetails();

        // Try getting ID one more time after fetch
        userId = await LocalStorageService().getUserId();
      }

      if (userId == 0) {
        print('❌ WebSocket Notifier: No user ID found after fallback. Cannot connect.');
        return;
      }

      print('🔌 WebSocket Notifier: User ID: $userId');
      print(
        '🔑 WebSocket Notifier: Token found (length: ${token.length}, first 20 chars: ${token.substring(0, token.length > 20 ? 20 : token.length)}...)',
      );

      // Initialize rider WebSocket service
      await _riderWebSocketService.initializeRider(jwtToken: token, userId: userId);

      print('✅ WebSocket Notifier: Rider WebSocket service initialized');
    } catch (e, stackTrace) {
      print('❌ WebSocket Notifier: Error setting up listeners: $e');
      print('❌ WebSocket Notifier: Stack trace: $stackTrace');
    }
  }

  /// Get user ID with retry mechanism
  Future<int> _getUserIdWithRetry({int maxRetries = 3, Duration delay = const Duration(milliseconds: 500)}) async {
    for (int i = 0; i < maxRetries; i++) {
      final userId = await LocalStorageService().getUserId();
      if (userId != 0) {
        return userId;
      }

      if (i < maxRetries - 1) {
        print('⏳ WebSocket Notifier: Retrying to get user ID (attempt ${i + 1}/$maxRetries)...');
        await Future.delayed(delay);
      }
    }
    return 0;
  }

  /// Initialize from stored credentials (for backward compatibility)
  Future<void> initializeFromStorage() async {
    await setupWebSocketListeners();
  }

  /// Join ride room
  Future<void> joinRideRoom(int rideId) async {
    _riderWebSocketService.joinRideRoom(rideId);
  }

  /// Leave ride room
  Future<void> leaveRideRoom() async {
    _riderWebSocketService.leaveRideRoom();
  }

  /// Send chat message
  void sendChatMessage({
    required int rideId,
    required String senderId,
    required String senderName,
    required String receiverId,
    required String message,
  }) {
    _riderWebSocketService.sendMessageToDriver(
      rideId: rideId,
      message: message,
      senderName: senderName,
      driverId: receiverId,
    );
  }

  /// Disconnect
  Future<void> disconnect() async {
    _riderWebSocketService.disconnect();
  }

  /// Get streams
  Stream<Map<String, dynamic>> get rideStatusStream => _riderWebSocketService.rideStatusStream;
  Stream<Map<String, dynamic>> get driverLocationStream => _riderWebSocketService.driverLocationStream;
  Stream<Map<String, dynamic>> get walletUpdateStream => _riderWebSocketService.walletUpdateStream;
  Stream<Map<String, dynamic>> get chatMessageStream => _riderWebSocketService.chatMessageStream;
  Stream<Map<String, dynamic>> get driverStatusStream => _riderWebSocketService.driverStatusStream;
  Stream<Map<String, dynamic>> get newRideRequestStream => _riderWebSocketService.newRideRequestStream;
  Stream<Map<String, dynamic>> get fleetStatsStream => _riderWebSocketService.fleetStatsStream;

  bool get isConnected => _riderWebSocketService.isConnected;
}

// Provider
final websocketProvider = StateNotifierProvider<WebSocketNotifier, void>((ref) {
  return WebSocketNotifier(ref);
});
