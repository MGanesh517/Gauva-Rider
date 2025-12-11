import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../core/config/environment.dart';

/// Base WebSocket service for both STOMP and Socket.IO
class WebSocketService {
  // Configuration
  static String get baseUrl => Environment.baseUrl;
  static String get socketIOUrl => Environment.baseUrl;

  // STOMP client
  StompClient? stompClient;

  // Socket.IO client
  IO.Socket? socketIO;

  // Connection status
  bool isStompConnected = false;
  bool isSocketIOConnected = false;

  // Stream controllers for events
  final StreamController<Map<String, dynamic>> _rideStatusController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _driverLocationController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _walletUpdateController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _chatMessageController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _driverStatusController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _newRideRequestController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _fleetStatsController =
      StreamController<Map<String, dynamic>>.broadcast();

  // Getters for streams
  Stream<Map<String, dynamic>> get rideStatusStream => _rideStatusController.stream;
  Stream<Map<String, dynamic>> get driverLocationStream => _driverLocationController.stream;
  Stream<Map<String, dynamic>> get walletUpdateStream => _walletUpdateController.stream;
  Stream<Map<String, dynamic>> get chatMessageStream => _chatMessageController.stream;
  Stream<Map<String, dynamic>> get driverStatusStream => _driverStatusController.stream;
  Stream<Map<String, dynamic>> get newRideRequestStream => _newRideRequestController.stream;
  Stream<Map<String, dynamic>> get fleetStatsStream => _fleetStatsController.stream;

  // Protected methods for subclasses to add data to streams
  void addRideStatus(Map<String, dynamic> data) => _rideStatusController.add(data);
  void addDriverLocation(Map<String, dynamic> data) => _driverLocationController.add(data);
  void addWalletUpdate(Map<String, dynamic> data) => _walletUpdateController.add(data);
  void addChatMessage(Map<String, dynamic> data) => _chatMessageController.add(data);
  void addDriverStatus(Map<String, dynamic> data) => _driverStatusController.add(data);
  void addNewRideRequest(Map<String, dynamic> data) => _newRideRequestController.add(data);
  void addFleetStats(Map<String, dynamic> data) => _fleetStatsController.add(data);

  /// Connect to STOMP WebSocket
  Future<void> connectStomp(String jwtToken) async {
    try {
      // Use wss:// for HTTPS connections (production)
      final wsUrl = baseUrl.startsWith('https')
          ? baseUrl.replaceFirst('https', 'wss')
          : baseUrl.replaceFirst('http', 'ws');

      debugPrint('🔌 Connecting to STOMP: $wsUrl/ws');

      final stompConfig = StompConfig(
        url: '$wsUrl/ws',
        onConnect: (frame) {
          debugPrint('✅ STOMP Connected');
          isStompConnected = true;
        },
        onStompError: (frame) {
          debugPrint('❌ STOMP Error: ${frame.body}');
          isStompConnected = false;
        },
        onWebSocketError: (error) {
          debugPrint('❌ WebSocket Error: $error');
          isStompConnected = false;
        },
        onDisconnect: (frame) {
          debugPrint('❌ STOMP Disconnected');
          isStompConnected = false;
        },
        stompConnectHeaders: {
          'Authorization': 'Bearer $jwtToken',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $jwtToken',
        },
        beforeConnect: () async {
          await Future.delayed(const Duration(milliseconds: 300));
        },
        heartbeatIncoming: const Duration(milliseconds: 4000),
        heartbeatOutgoing: const Duration(milliseconds: 4000),
      );

      stompClient = StompClient(config: stompConfig);
      stompClient!.activate();
    } catch (e) {
      debugPrint('Error connecting to STOMP: $e');
      rethrow;
    }
  }

  /// Connect to Socket.IO
  /// NOTE: Socket.IO may not be available on Azure App Service
  /// Use STOMP WebSocket instead for production
  Future<void> connectSocketIO(String? jwtToken) async {
    try {
      // IMPORTANT: Socket.IO endpoint is /socket.io/ NOT /ws
      // IMPORTANT: Socket.IO may not be available on Azure - use STOMP instead
      // IMPORTANT: Use EIO=3 for Socket.IO v1.x (not EIO=4)

      // Convert https to wss for WebSocket
      final wsUrl = socketIOUrl.startsWith('https')
          ? socketIOUrl.replaceFirst('https://', 'wss://')
          : socketIOUrl.replaceFirst('http://', 'ws://');

      // Remove port if it's the default (Socket.IO may run on same port as main server)
      final cleanUrl = wsUrl.replaceAll(':9090', '').replaceAll(':0', '');

      debugPrint('🔌 Connecting Socket.IO to: $cleanUrl');

      socketIO = IO.io(
        cleanUrl, // Use clean URL without port
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling'])
            .setQuery({'EIO': '3'}) // ✅ FIXED: Use EIO=3, not EIO=4
            .enableAutoConnect()
            .enableReconnection()
            .setReconnectionDelay(1000)
            .setReconnectionDelayMax(5000)
            .setReconnectionAttempts(5)
            .setTimeout(20000)
            .build(),
      );

      // Connection events
      socketIO!.onConnect((_) {
        debugPrint('✅ Socket.IO Connected');
        isSocketIOConnected = true;

        // Join rooms immediately to prevent disconnection
        if (jwtToken != null) {
          // Will be set by rider/driver specific service
        }
      });

      socketIO!.onDisconnect((_) {
        debugPrint('❌ Socket.IO Disconnected');
        isSocketIOConnected = false;
      });

      socketIO!.onConnectError((error) {
        debugPrint('❌ Socket.IO Connection Error: $error');
        isSocketIOConnected = false;
      });

      // Server confirmation
      socketIO!.on('connected', (data) {
        debugPrint('Server confirmation: $data');
      });

      // Error handling
      socketIO!.on('error', (data) {
        debugPrint('Socket.IO Error: $data');
      });

      // Join error
      socketIO!.on('join_error', (data) {
        debugPrint('Join Error: $data');
      });

      // Real-time event listeners
      _setupSocketIOListeners();
    } catch (e) {
      debugPrint('Error connecting to Socket.IO: $e');
      rethrow;
    }
  }

  /// Setup Socket.IO event listeners
  void _setupSocketIOListeners() {
    // Ride status updates
    socketIO!.on('ride_status', (data) {
      debugPrint('📱 Ride Status Update: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _rideStatusController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing ride_status: $e');
      }
    });

    // Driver location updates
    socketIO!.on('driver_location', (data) {
      debugPrint('📍 Driver Location: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _driverLocationController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing driver_location: $e');
      }
    });

    // Wallet updates
    socketIO!.on('wallet_update', (data) {
      debugPrint('💰 Wallet Update: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _walletUpdateController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing wallet_update: $e');
      }
    });

    // Chat messages
    socketIO!.on('chat_message', (data) {
      debugPrint('💬 Chat Message: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _chatMessageController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing chat_message: $e');
      }
    });

    // Driver status updates
    socketIO!.on('driver_status', (data) {
      debugPrint('🚗 Driver Status: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _driverStatusController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing driver_status: $e');
      }
    });

    // New ride request (for drivers)
    socketIO!.on('new_ride_request', (data) {
      debugPrint('🆕 New Ride Request: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _newRideRequestController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing new_ride_request: $e');
      }
    });

    // Fleet stats (for admin)
    socketIO!.on('fleet_stats', (data) {
      debugPrint('📊 Fleet Stats: $data');
      try {
        final eventData = data is Map ? Map<String, dynamic>.from(data) : {'data': data};
        _fleetStatsController.add(eventData);
      } catch (e) {
        debugPrint('Error parsing fleet_stats: $e');
      }
    });
  }

  /// Join a room (Socket.IO)
  void joinRoom(String type, dynamic id) {
    if (!isSocketIOConnected || socketIO == null) {
      debugPrint('⚠️ Socket.IO not connected. Cannot join room.');
      return;
    }

    socketIO!.emit('join', {
      'type': type,
      'id': id,
    });

    socketIO!.on('joined', (data) {
      debugPrint('✅ Joined room: $data');
    });
  }

  /// Leave a room (Socket.IO)
  void leaveRoom(String type, dynamic id) {
    if (!isSocketIOConnected || socketIO == null) {
      return;
    }

    socketIO!.emit('leave', {
      'type': type,
      'id': id,
    });
  }

  /// Send location update (Socket.IO)
  void sendLocationUpdate({
    required int rideId,
    required int? driverId,
    required double lat,
    required double lng,
    double? heading,
  }) {
    if (!isSocketIOConnected || socketIO == null) {
      debugPrint('⚠️ Socket.IO not connected. Cannot send location.');
      return;
    }

    socketIO!.emit('location', {
      'rideId': rideId,
      'driverId': driverId,
      'lat': lat,
      'lng': lng,
      if (heading != null) 'heading': heading,
    });
  }

  /// Send chat message (Socket.IO)
  void sendChatMessage({
    required int rideId,
    required String senderId,
    required String senderName,
    required String receiverId,
    required String message,
    required String messageId,
  }) {
    if (!isSocketIOConnected || socketIO == null) {
      debugPrint('⚠️ Socket.IO not connected. Cannot send chat.');
      return;
    }

    socketIO!.emit('chat', {
      'rideId': rideId,
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'message': message,
      'messageId': messageId,
    });
  }

  /// Subscribe to STOMP topic
  void subscribeToStompTopic(String topic, Function(Map<String, dynamic>) callback) {
    if (!isStompConnected || stompClient == null) {
      debugPrint('⚠️ STOMP not connected. Cannot subscribe.');
      return;
    }

    stompClient!.subscribe(
      destination: topic,
      callback: (frame) {
        try {
          final data = jsonDecode(frame.body!) as Map<String, dynamic>;
          callback(data);
        } catch (e) {
          debugPrint('Error parsing STOMP message: $e');
        }
      },
    );
  }

  /// Send message via STOMP
  void sendStompMessage(String destination, Map<String, dynamic> message) {
    if (!isStompConnected || stompClient == null) {
      debugPrint('⚠️ STOMP not connected. Cannot send message.');
      return;
    }

    stompClient!.send(
      destination: destination,
      body: jsonEncode(message),
    );
  }

  /// Disconnect all
  void disconnect() {
    if (stompClient != null) {
      stompClient!.deactivate();
      stompClient = null;
      isStompConnected = false;
    }

    if (socketIO != null) {
      socketIO!.disconnect();
      socketIO!.dispose();
      socketIO = null;
      isSocketIOConnected = false;
    }

    // Close stream controllers
    _rideStatusController.close();
    _driverLocationController.close();
    _walletUpdateController.close();
    _chatMessageController.close();
    _driverStatusController.close();
    _newRideRequestController.close();
    _fleetStatsController.close();
  }
}

