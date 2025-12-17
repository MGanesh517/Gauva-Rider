# Driver App Issues - Analysis & Solutions

## Issues Identified from Logs

### 1. ❌ Driver Location Update API Endpoint Error

**Error:**
```
POST /api/v1/driver/locations/update
Status: 500 Internal Server Error
Message: "No static resource api/v1/driver/locations/update."
```

**Problem:**
- The driver app is trying to update location via REST API endpoint `/api/v1/driver/locations/update`
- This endpoint doesn't exist on the server
- The endpoint is not defined in the rider app's `api_endpoints.dart` (which is expected since this is a rider app)

**Solution Options:**

#### Option A: Use WebSocket for Location Updates (Recommended)
Based on the WebSocket integration documentation, location updates should be sent via WebSocket:

```dart
// For ride-specific location updates (when driver is in a ride)
websocketService.sendMessage({
  'event': 'location_update',
  'data': {
    'rideId': rideId,
    'lat': location.latitude,
    'lng': location.longitude,
    'heading': heading,
    'timestamp': DateTime.now().toIso8601String(),
  }
});
```

#### Option B: Create Correct REST API Endpoint
If REST API is preferred for general location updates (not ride-specific), the backend should implement:

**Endpoint:** `POST /api/v1/driver/location` or `PUT /api/v1/driver/location`

**Request Body:**
```json
{
  "latitude": 17.5306116,
  "longitude": 78.3899578,
  "heading": 0.0,
  "timestamp": "2025-12-16T04:28:32Z"
}
```

**Note:** The current endpoint path `/api/v1/driver/locations/update` uses plural "locations" which might be causing routing issues. The backend should use singular "location" to match Spring Boot conventions.

---

### 2. ❌ Missing `new_ride_request` WebSocket Event

**Problem:**
- Rider successfully created order (ID: 30) and joined WebSocket room `ride:30`
- Driver successfully joined rooms:
  - `driver:7` (driver-specific room)
  - `drivers:available` (room for receiving ride requests)
- **But:** Driver did NOT receive `new_ride_request` event for ride 30

**Expected Flow:**
1. Rider creates order → Order ID 30 created
2. Backend should broadcast `new_ride_request` event to `drivers:available` room
3. All available drivers in that room should receive the event
4. Driver can then accept/decline the ride

**Root Cause:**
This is a **backend issue**. The Spring Boot server needs to:
1. Listen for new ride creation events
2. Broadcast `new_ride_request` to the `drivers:available` room when a ride is created

**Backend Implementation Required:**

```java
// In your RideController or RideService
@EventListener
public void onRideCreated(RideCreatedEvent event) {
    Ride ride = event.getRide();
    
    // Broadcast to all available drivers
    Map<String, Object> rideRequest = new HashMap<>();
    rideRequest.put("rideId", ride.getId());
    rideRequest.put("pickupLocation", ride.getPickupLocation());
    rideRequest.put("destinationLocation", ride.getDestinationLocation());
    rideRequest.put("fare", ride.getFare());
    rideRequest.put("vehicleType", ride.getVehicleType());
    rideRequest.put("riderId", ride.getRiderId());
    rideRequest.put("riderName", ride.getRiderName());
    rideRequest.put("timestamp", System.currentTimeMillis());
    
    // Send to drivers:available room
    messagingTemplate.convertAndSend("/topic/drivers/available", Map.of(
        "event", "new_ride_request",
        "data", rideRequest
    ));
}
```

**WebSocket Event Format Expected by Driver App:**
```json
{
  "event": "new_ride_request",
  "data": {
    "rideId": 30,
    "pickupLocation": {
      "lat": 17.5306116,
      "lng": 78.3899578,
      "address": "Pickup Address"
    },
    "destinationLocation": {
      "lat": 17.4506116,
      "lng": 78.3899578,
      "address": "Destination Address"
    },
    "fare": 150.00,
    "vehicleType": "SEDAN",
    "riderId": "97100310-9841-46e9-9bc7-f642ef00737c",
    "riderName": "Rider Name",
    "timestamp": 1765859307491
  }
}
```

---

## Verification Steps

### For Driver Location Update:
1. ✅ Check if driver app is using WebSocket for location updates
2. ✅ Verify WebSocket connection is established
3. ✅ Check if location updates are being sent via WebSocket events
4. ❌ If using REST API, verify the endpoint exists on backend: `/api/v1/driver/location` (singular)

### For Ride Request Notification:
1. ✅ Verify rider successfully creates order (✅ Confirmed - Order ID 30)
2. ✅ Verify driver joins `drivers:available` room (✅ Confirmed)
3. ❌ Verify backend broadcasts `new_ride_request` event (❌ Missing)
4. ❌ Verify driver receives the event (❌ Not received)

---

## Recommended Actions

### Immediate Actions:
1. **Backend Team:** Implement `new_ride_request` broadcast when ride is created
2. **Driver App Team:** 
   - Fix location update endpoint to use WebSocket OR
   - Update endpoint path to `/api/v1/driver/location` (singular) if REST API is required
3. **Testing:** Verify end-to-end flow:
   - Rider creates order → Driver receives notification → Driver accepts → Ride starts

### Long-term Improvements:
1. Use WebSocket for all real-time updates (location, status, etc.)
2. Implement proper error handling and retry logic for failed location updates
3. Add logging/monitoring for WebSocket events to track delivery

---

## Related Files (Rider App - For Reference)

- `lib/data/services/websocket_service.dart` - WebSocket service implementation
- `lib/core/config/api_endpoints.dart` - API endpoints (rider app only)
- `WEBSOCKET_INTEGRATION.md` - WebSocket integration documentation

---

## Notes

- This is a **rider app codebase**. Driver app issues need to be fixed in the driver app codebase.
- The WebSocket service in the rider app handles `new_ride_request` events (line 196-199 in `websocket_service.dart`), so the driver app should have similar handling.
- Both apps use the same WebSocket server, so event formats should be consistent.

