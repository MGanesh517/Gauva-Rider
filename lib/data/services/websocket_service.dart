import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import '../../core/config/environment.dart';
import 'local_storage_service.dart';

/// Base WebSocket service for Plain WebSocket (Raw JSON)
class WebSocketService {
  // WebSocket channel
  IOWebSocketChannel? _channel;

  // Connection status
  bool isConnected = false;

  // Stream controllers for events
  final _rideStatusController = StreamController<Map<String, dynamic>>.broadcast();
  final _driverLocationController = StreamController<Map<String, dynamic>>.broadcast();
  final _walletUpdateController = StreamController<Map<String, dynamic>>.broadcast();
  final _chatMessageController = StreamController<Map<String, dynamic>>.broadcast();
  final _driverStatusController = StreamController<Map<String, dynamic>>.broadcast();
  final _newRideRequestController = StreamController<Map<String, dynamic>>.broadcast();
  final _fleetStatsController = StreamController<Map<String, dynamic>>.broadcast();

  // Protected methods to add to streams (for subclasses)
  void addToRideStatusStream(Map<String, dynamic> data) => _rideStatusController.add(data);
  void addToDriverLocationStream(Map<String, dynamic> data) => _driverLocationController.add(data);
  void addToWalletUpdateStream(Map<String, dynamic> data) => _walletUpdateController.add(data);
  void addToChatMessageStream(Map<String, dynamic> data) => _chatMessageController.add(data);
  void addToDriverStatusStream(Map<String, dynamic> data) => _driverStatusController.add(data);
  void addToNewRideRequestStream(Map<String, dynamic> data) => _newRideRequestController.add(data);
  void addToFleetStatsStream(Map<String, dynamic> data) => _fleetStatsController.add(data);

  // Auto-reconnect support
  bool _shouldReconnect = true;
  String? _jwtToken;
  Timer? _reconnectTimer;
  final _onReconnectedController = StreamController<void>.broadcast();

  // Getters for streams
  Stream<Map<String, dynamic>> get rideStatusStream => _rideStatusController.stream;
  Stream<Map<String, dynamic>> get driverLocationStream => _driverLocationController.stream;
  Stream<Map<String, dynamic>> get walletUpdateStream => _walletUpdateController.stream;
  Stream<Map<String, dynamic>> get chatMessageStream => _chatMessageController.stream;
  Stream<Map<String, dynamic>> get driverStatusStream => _driverStatusController.stream;
  Stream<Map<String, dynamic>> get newRideRequestStream => _newRideRequestController.stream;
  Stream<Map<String, dynamic>> get fleetStatsStream => _fleetStatsController.stream;
  Stream<void> get onReconnected => _onReconnectedController.stream;

  /// Connect to Raw All-in-One WebSocket
  Future<void> connect(String jwtToken) async {
    // Store token for auto-reconnect
    _jwtToken = jwtToken;
    _shouldReconnect = true;

    // Prevent multiple connection attempts
    if (isConnected && _channel != null) {
      print('⚠️ WebSocket Service: Already connected, skipping...');
      return;
    }

    // Don't call disconnect() here as it sets _shouldReconnect to false
    // Just close existing channel if any
    if (_channel != null) {
      try {
        _channel!.sink.close();
      } catch (e) {
        /* ignore */
      }
      _channel = null;
    }

    try {
      final wsUrl = Environment.webSocketUrl;

      print('🔌 WebSocket Service: Connecting to Raw WebSocket at $wsUrl');
      print('🔑 WebSocket Service: Using token (length: ${jwtToken.length})');

      _channel = IOWebSocketChannel.connect(
        Uri.parse(wsUrl),
        headers: {'Authorization': 'Bearer $jwtToken'},
        pingInterval: const Duration(seconds: 10),
      );

      isConnected = true;
      print('✅ WebSocket Connection initiated');

      // Listen to incoming messages
      _channel!.stream.listen(
        (message) {
          _handleIncomingMessage(message);
        },
        onDone: () {
          print('❌ WebSocket Closed');
          isConnected = false;
          _attemptReconnect();
        },
        onError: (error) {
          print('❌ WebSocket Error: $error');
          isConnected = false;
          _attemptReconnect();
        },
      );
    } catch (e) {
      print('❌ Error connecting to WebSocket: $e');
      isConnected = false;
      // If initial connection fails, we might want to retry too?
      // For now, let's rethrow to let caller handle initial failure,
      // but if caller ignores, we won't auto-retry unless we call _attemptReconnect here.
      // Given user request "if it disconnect also it should try connecting", let's rethrow
      // but maybe caller handles it.
      rethrow;
    }
  }

  /// Attempt to reconnect after a delay
  void _attemptReconnect() {
    if (!_shouldReconnect) {
      return;
    }

    if (_reconnectTimer != null && _reconnectTimer!.isActive) {
      return; // Already scheduled
    }

    print('⏳ WebSocket: Scheduling reconnect in 5s...');
    _reconnectTimer = Timer(const Duration(seconds: 5), () async {
      if (!_shouldReconnect || isConnected) return;

      print('🔄 WebSocket: Attempting to reconnect...');
      try {
        // Fetch fresh token from storage during reconnection
        final freshToken = await LocalStorageService().getToken();
        if (freshToken == null || freshToken.isEmpty) {
          print('❌ WebSocket: No token found in storage during reconnection. Cannot reconnect.');
          // Retry after delay in case token is being saved
          _attemptReconnect();
          return;
        }

        // Update stored token with fresh one (for consistency)
        _jwtToken = freshToken;
        print('🔑 WebSocket: Using fresh token from storage (length: ${freshToken.length})');

        await connect(freshToken);
        // connect() rethrows on error, so we catch it here to loop again
        if (isConnected) {
          print('✅ WebSocket: Auto-reconnected successfully');
          _onReconnectedController.add(null);
        }
      } catch (e) {
        print('❌ WebSocket: Auto-reconnect failed ($e). Retrying in 5s...');
        // Check if it's a 401 error - token might be expired
        if (e.toString().contains('401') || e.toString().contains('Unauthorized')) {
          print('⚠️ WebSocket: 401 Unauthorized - Token may be expired. Will retry with fresh token...');
        }
        _attemptReconnect();
      }
    });
  }

  /// Handle incoming raw JSON message
  void _handleIncomingMessage(dynamic message) {
    try {
      // print('📩 WebSocket Received: $message'); // Verbose logging
      final decoded = jsonDecode(message);

      if (decoded is Map<String, dynamic>) {
        final event = decoded['event'];
        final data = decoded['data'];

        // Handle "connected" event/confirmation
        if (event == 'connected') {
          print('✅ WebSocket Server Confirmation: ${data['message']}');
          return;
        }

        // Handle "joined" event/confirmation
        if (event == 'joined') {
          print('✅ WebSocket Joined Room: ${data['room']}');
          return;
        }

        // Dispatch based on 'event' name
        if (event != null && data != null) {
          // Normalize data to Map<String, dynamic>
          final Map<String, dynamic> mapData = data is Map<String, dynamic> ? data : {'payload': data};

          switch (event) {
            case 'ride_status':
            case 'rideStatus':
              print('📱 Ride Status Update: $mapData');
              _rideStatusController.add(mapData);
              break;
            case 'driver_location':
            case 'driverLocation':
              print('📍 Driver Location: $mapData');
              _driverLocationController.add(mapData);
              break;
            case 'wallet_update':
            case 'walletUpdate':
              print('💰 Wallet Update: $mapData');
              _walletUpdateController.add(mapData);
              break;
            case 'chat_message':
            case 'chatMessage':
              print('💬 Chat Message: $mapData');
              _chatMessageController.add(mapData);
              break;
            case 'driver_status':
            case 'driverStatus':
              print('🚗 Driver Status: $mapData');
              _driverStatusController.add(mapData);
              break;
            case 'new_ride_request':
            case 'newRideRequest':
              print('🆕 New Ride Request: $mapData');
              _newRideRequestController.add(mapData);
              break;
            case 'fleet_stats':
              print('📊 Fleet Stats: $mapData');
              _fleetStatsController.add(mapData);
              break;
            default:
              print('⚠️ Unhandled WebSocket Event: $event');
          }
        }
      }
    } catch (e) {
      print('❌ Error parsing WebSocket message: $e\nMessage: $message');
    }
  }

  /// Send message via WebSocket
  /// Accepts a full payload map. 'event' key is required if using this directly.
  void sendMessage(Map<String, dynamic> payload) {
    if (!isConnected || _channel == null) {
      print('⚠️ WebSocket not connected. Cannot send ${payload['event']}.');
      return;
    }

    try {
      _channel!.sink.add(jsonEncode(payload));
    } catch (e) {
      print('❌ Error sending WebSocket message: $e');
    }
  }

  /// Disconnect
  void disconnect() {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();

    if (_channel != null) {
      try {
        _channel!.sink.close();
      } catch (e) {
        print('Error closing sink: $e');
      }
      _channel = null;
    }
    isConnected = false;
  }
}
