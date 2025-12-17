# WebSocket Integration for Spring Boot

## Overview
This Flutter app is integrated with Spring Boot WebSocket using the STOMP protocol. The implementation supports real-time communication for ride tracking, chat, and notifications.

## Architecture

### Protocol
- **Primary**: STOMP over WebSocket (Spring Boot standard)
- **Optional**: Socket.IO (fallback, may not be available on all deployments)

### Connection Endpoint
- **STOMP**: `wss://{baseUrl}/ws` (for HTTPS) or `ws://{baseUrl}/ws` (for HTTP)
- The endpoint is automatically determined from the base URL in `Environment.baseUrl`

## Features

### 1. Connection Management
- Automatic connection on app startup (when user is logged in)
- JWT token-based authentication
- Automatic reconnection on disconnection (up to 5 attempts)
- Connection status monitoring

### 2. Topic Subscriptions (Spring Boot STOMP)

#### User-Specific Topics
- `/user/{userId}/ride/status` - User-specific ride status updates
- `/user/{userId}/wallet` - Wallet balance updates
- `/user/{userId}/notifications` - General user notifications

#### Ride-Specific Topics
- `/topic/ride/{rideId}/status` - Ride status updates (accepted, in-progress, completed, etc.)
- `/topic/ride/{rideId}/location` - Driver location updates
- `/topic/ride/{rideId}/chat` - Chat messages for the ride
- `/user/{userId}/ride/{rideId}` - User-specific ride updates

### 3. Message Sending (Client to Server)

#### Spring Boot STOMP Destinations
All client-to-server messages use `/app/...` prefix:

- **Location Updates**: `/app/ride/{rideId}/location`
  ```json
  {
    "rideId": 123,
    "lat": 40.7128,
    "lng": -74.0060,
    "heading": 90.0,
    "timestamp": "2024-01-01T12:00:00Z"
  }
  ```

- **Chat Messages**: `/app/chat/ride/{rideId}`
  ```json
  {
    "rideId": 123,
    "senderId": "user123",
    "senderName": "John Doe",
    "receiverId": "driver456",
    "message": "Hello driver!",
    "messageId": "msg123",
    "timestamp": "2024-01-01T12:00:00Z"
  }
  ```

## Implementation Details

### Files Modified

1. **`lib/data/services/websocket_service.dart`**
   - Base WebSocket service with STOMP and Socket.IO support
   - Connection management with reconnection logic
   - Stream controllers for real-time events
   - Message sending methods

2. **`lib/data/services/rider_websocket_service.dart`**
   - Rider-specific WebSocket service
   - User and ride room management
   - Topic subscriptions for Spring Boot

3. **`lib/presentation/websocket/provider/websocket_provider.dart`**
   - Riverpod provider for WebSocket state management
   - Initialization from stored credentials

4. **`lib/presentation/websocket/view_model/websocket_listener_notifier.dart`**
   - Listener for WebSocket streams
   - Handles ride status, location, chat, and wallet updates

### Initialization Flow

1. User logs in → JWT token stored
2. Dashboard loads → WebSocket initialized from stored credentials
3. Connection established → User-specific topics subscribed
4. Ride starts → Ride-specific topics subscribed
5. Real-time updates received → UI updated via Riverpod providers

### Reconnection Logic

- Automatic reconnection on disconnection
- Exponential backoff (2s, 4s, 6s, 8s, 10s)
- Maximum 5 reconnection attempts
- JWT token automatically used for reconnection

### Authentication

- JWT token passed in:
  - WebSocket handshake headers (`Authorization: Bearer {token}`)
  - STOMP CONNECT frame headers (`Authorization: Bearer {token}`)

## Usage Example

```dart
// Initialize WebSocket (done automatically on dashboard)
await ref.read(websocketProvider.notifier).initializeFromStorage();

// Join ride room when ride starts
ref.read(websocketProvider.notifier).joinRideRoom(rideId);

// Send chat message
ref.read(websocketProvider.notifier).sendMessageToDriver(
  rideId: rideId,
  message: "Hello driver!",
  senderName: "John Doe",
  driverId: driverId,
);

// Listen to updates (automatic via websocketListenerNotifierProvider)
ref.read(websocketListenerNotifierProvider.notifier).startListening();
```

## Spring Boot Backend Requirements

### WebSocket Configuration
The Spring Boot backend should have:

1. **WebSocket Configuration**
   ```java
   @Configuration
   @EnableWebSocketMessageBroker
   public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
       @Override
       public void configureMessageBroker(MessageBrokerRegistry config) {
           config.enableSimpleBroker("/topic", "/user");
           config.setApplicationDestinationPrefixes("/app");
       }
       
       @Override
       public void registerStompEndpoints(StompEndpointRegistry registry) {
           registry.addEndpoint("/ws")
                   .setAllowedOriginPatterns("*")
                   .withSockJS();
       }
   }
   ```

2. **Authentication Interceptor**
   - Extract JWT token from STOMP CONNECT headers
   - Validate token and set user context

3. **Message Controllers**
   ```java
   @MessageMapping("/ride/{rideId}/location")
   public void sendLocation(@DestinationVariable int rideId, LocationUpdate update) {
       // Broadcast to /topic/ride/{rideId}/location
   }
   
   @MessageMapping("/chat/ride/{rideId}")
   public void sendChat(@DestinationVariable int rideId, ChatMessage message) {
       // Broadcast to /topic/ride/{rideId}/chat
   }
   ```

## Testing

1. **Connection Test**
   - Check logs for "✅ STOMP Connected Successfully"
   - Verify connection status in WebSocket provider

2. **Subscription Test**
   - Verify topics are subscribed when ride starts
   - Check logs for subscription confirmations

3. **Message Test**
   - Send test message and verify it reaches backend
   - Verify broadcast messages are received

## Troubleshooting

### Connection Issues
- Check base URL configuration in `Environment.baseUrl`
- Verify JWT token is valid and not expired
- Check network connectivity
- Review backend WebSocket endpoint configuration

### Message Not Received
- Verify topic subscriptions match backend topics
- Check message format matches backend expectations
- Review backend message broadcasting logic

### Reconnection Issues
- Check reconnection attempts in logs
- Verify JWT token is still valid
- Review network stability

## Notes

- Socket.IO is optional and may not be available on all Spring Boot deployments
- STOMP is the primary protocol and should work on all Spring Boot WebSocket implementations
- All real-time features work through STOMP, Socket.IO is only a fallback
- The implementation automatically handles both protocols gracefully

