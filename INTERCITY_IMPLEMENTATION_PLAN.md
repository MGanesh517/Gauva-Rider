# Intercity & Share Pooling Implementation Plan

## 📱 Screen Flow Architecture

### 1. Home Screen (Updated)
**Location:** `lib/presentation/dashboard/widgets/services_and_promotional.dart`

**Changes:**
- Update "Ride as you like it" section to show:
  - **Book Intercity** card
  - **Share Pooling** card
  - (Keep existing cards or replace based on requirements)

**Card Actions:**
- Tap "Book Intercity" → Navigate to `IntercitySearchPage`
- Tap "Share Pooling" → Navigate to `SharePoolingSearchPage` (or same page with filter)

---

### 2. Intercity Search Page
**File:** `lib/presentation/intercity/views/intercity_search_page.dart`

**UI Components:**
- **Header:** "Book Intercity" with back button
- **Search Form:**
  - Origin location picker (with map/search)
  - Destination location picker (with map/search)
  - Date picker (default: today, min: today)
  - Seats selector (1-10)
  - Vehicle type filter (dropdown/chips)
- **Search Button:** "Search Trips"
- **Popular Routes Section:** (Optional) Quick access to common routes

**Navigation:**
- On search → Navigate to `IntercityTripResultsPage`

**State Management:**
- `IntercitySearchNotifier` (Riverpod StateNotifier)
- Manages search form state

---

### 3. Intercity Trip Results Page
**File:** `lib/presentation/intercity/views/intercity_trip_results_page.dart`

**UI Components:**
- **Header:** "Available Trips" with back button
- **Filter Bar:**
  - Vehicle type filter
  - Sort by (Price, Time, Duration)
  - Date filter
- **Trip List:**
  - Each trip card shows:
    - Route (Origin → Destination)
    - Departure time
    - Vehicle type & capacity
    - Available seats
    - Price per seat / Total price
    - Duration
    - "View Details" button
- **Empty State:** "No trips available"
- **Loading State:** Shimmer/skeleton

**Navigation:**
- Tap trip card → Navigate to `IntercityTripDetailsPage`

**State Management:**
- `IntercityTripResultsNotifier`
- Manages trip list, filters, sorting

---

### 4. Intercity Trip Details Page
**File:** `lib/presentation/intercity/views/intercity_trip_details_page.dart`

**UI Components:**
- **Trip Header:**
  - Route name
  - Trip code
  - Departure date & time
  - Duration
- **Vehicle Details:**
  - Vehicle type & image
  - Capacity
  - Features/amenities
- **Pricing Section:**
  - Price breakdown
  - Seats selector
  - Total price calculation
  - Booking type toggle (Private / Share Pool)
- **Route Map:** (Optional) Show route on map
- **Alternative Vehicles:** (If available) Show other vehicle options
- **Book Now Button:** Navigate to booking page

**Navigation:**
- Tap "Book Now" → Navigate to `IntercityBookingPage`
- Tap alternative vehicle → Show details

**State Management:**
- `IntercityTripDetailsNotifier`
- Manages trip details, pricing calculation

---

### 5. Intercity Booking Page
**File:** `lib/presentation/intercity/views/intercity_booking_page.dart`

**UI Components:**
- **Booking Summary:**
  - Trip details
  - Vehicle type
  - Seats booked
  - Total price
- **Passenger Details Form:**
  - Passenger name (required)
  - Contact phone (required, pre-filled from profile)
  - Additional notes (optional)
- **Booking Type:**
  - Private booking (entire vehicle)
  - Share Pool booking (shared with others)
- **Payment Section:**
  - Payment method selection
  - Price breakdown
- **Terms & Conditions:** Checkbox
- **Confirm Booking Button**

**Navigation:**
- On booking success → Navigate to `IntercityBookingConfirmationPage`
- On payment required → Navigate to payment gateway

**State Management:**
- `IntercityBookingNotifier`
- Manages booking creation, payment processing

---

### 6. Intercity Booking Confirmation Page
**File:** `lib/presentation/intercity/views/intercity_booking_confirmation_page.dart`

**UI Components:**
- **Success Icon/Animation**
- **Booking Code:** Display prominently
- **Booking Details:**
  - Trip information
  - Passenger details
  - Booking status
  - OTP (if confirmed)
- **Actions:**
  - "View Booking" button
  - "My Bookings" button
  - "Book Another" button

**Navigation:**
- Tap "View Booking" → Navigate to `IntercityBookingDetailsPage`
- Tap "My Bookings" → Navigate to `IntercityBookingsListPage`

---

### 7. Share Pooling Search Page
**File:** `lib/presentation/intercity/views/share_pooling_search_page.dart` (or reuse IntercitySearchPage with filter)

**UI Components:**
- Similar to Intercity Search Page
- **Default Filter:** `bookingType: SHARE_POOL`
- **Show Available Pool Trips:** Only trips with available seats for pooling
- **Pooling Benefits Section:** Show savings info

**Navigation:**
- Same flow as Intercity (but filtered for pooling)

---

### 8. My Intercity Bookings Page
**File:** `lib/presentation/intercity/views/intercity_bookings_list_page.dart`

**UI Components:**
- **Tabs:**
  - Active Bookings
  - Booking History
- **Booking Cards:**
  - Booking code
  - Route
  - Date & time
  - Status badge
  - Price
  - "View Details" button
- **Empty State:** "No bookings yet"

**Navigation:**
- Tap booking card → Navigate to `IntercityBookingDetailsPage`

**State Management:**
- `IntercityBookingsNotifier`
- Manages active bookings and history

---

### 9. Intercity Booking Details Page
**File:** `lib/presentation/intercity/views/intercity_booking_details_page.dart`

**UI Components:**
- **Booking Header:**
  - Booking code
  - Status badge
- **Trip Information:**
  - Route
  - Date & time
  - Vehicle details
- **Passenger Information:**
  - Name
  - Phone
  - Seats booked
- **Pricing:**
  - Price breakdown
  - Payment status
- **Actions:**
  - Cancel Booking (if allowed)
  - Contact Support
  - Share Booking

**Navigation:**
- Tap "Cancel" → Show cancel dialog → Navigate back

**State Management:**
- `IntercityBookingDetailsNotifier`
- Manages booking details, cancellation

---

## 📋 Required APIs from Documentation

### Phase 1: Search & Discovery

#### 1. Search for Available Trips
- **Endpoint:** `POST /api/customer/intercity/search`
- **Request Body:**
  ```json
  {
    "originLatitude": 17.5306543,
    "originLongitude": 78.3898111,
    "destinationLatitude": 17.489222,
    "destinationLongitude": 78.3927245,
    "travelDate": "2025-12-10",
    "seatsNeeded": 2,
    "vehicleType": "CAR_NORMAL"
  }
  ```
- **Response:** `IntercityTripSearchResponse` (list of available trips)
- **Used In:** `IntercityTripResultsPage`

#### 2. Search Vehicle Options with Pricing
- **Endpoint:** `POST /api/customer/intercity/vehicles`
- **Request Body:** `IntercityVehicleSearchRequest`
- **Response:** `List<IntercityVehicleOptionDTO>`
- **Used In:** `IntercitySearchPage` (vehicle filter dropdown)

#### 3. Get All Vehicle Options
- **Endpoint:** `GET /api/customer/intercity/vehicles/all`
- **Response:** `List<IntercityVehicleOptionDTO>`
- **Used In:** `IntercitySearchPage` (vehicle options list)

#### 4. Get Available Trips for Pooling
- **Endpoint:** `GET /api/customer/intercity/trips/available`
- **Query Parameters:**
  - `vehicleType` (required)
  - `seatsNeeded` (default: 1)
- **Response:** `List<IntercityTripDTO>`
- **Used In:** `SharePoolingSearchPage`

#### 5. Get Trip Details
- **Endpoint:** `GET /api/customer/intercity/trips/{tripId}`
- **Path Parameters:** `tripId` (Long)
- **Response:** `IntercityTripDTO`
- **Used In:** `IntercityTripDetailsPage`

#### 6. Get Alternative Vehicle Options
- **Endpoint:** `GET /api/customer/intercity/trips/{tripId}/alternatives`
- **Path Parameters:** `tripId` (Long)
- **Response:** `List<IntercityAlternativeDTO>`
- **Used In:** `IntercityTripDetailsPage` (alternative vehicles section)

---

### Phase 2: Booking Management

#### 7. Create Booking
- **Endpoint:** `POST /api/customer/intercity/bookings`
- **Authentication:** Required (JWT Token)
- **Request Body:**
  ```json
  {
    "tripId": 1,
    "vehicleType": "CAR_NORMAL",
    "seatsBooked": 2,
    "bookingType": "PRIVATE", // or "SHARE_POOL"
    "contactPhone": "+919542295621",
    "passengerName": "John Doe"
  }
  ```
- **Response:** `IntercityBookingResponse` (201 Created)
- **Used In:** `IntercityBookingPage`

#### 8. Confirm Booking (After Payment)
- **Endpoint:** `POST /api/customer/intercity/bookings/{bookingId}/confirm`
- **Authentication:** Required (JWT Token)
- **Path Parameters:** `bookingId` (Long)
- **Request Body:**
  ```json
  {
    "razorpayPaymentId": "pay_xxxxx"
  }
  ```
- **Response:** `IntercityBookingResponse`
- **Used In:** `IntercityBookingPage` (after payment)

#### 9. Cancel Booking
- **Endpoint:** `POST /api/customer/intercity/bookings/{bookingId}/cancel`
- **Authentication:** Required (JWT Token)
- **Path Parameters:** `bookingId` (Long)
- **Request Body (Optional):**
  ```json
  {
    "reason": "Change of plans"
  }
  ```
- **Response:** `IntercityBookingResponse`
- **Used In:** `IntercityBookingDetailsPage`

#### 10. Get Booking Details
- **Endpoint:** `GET /api/customer/intercity/bookings/{bookingId}`
- **Authentication:** Required (JWT Token)
- **Path Parameters:** `bookingId` (Long)
- **Response:** `IntercityBookingResponse`
- **Used In:** `IntercityBookingDetailsPage`

#### 11. Get Booking by Code
- **Endpoint:** `GET /api/customer/intercity/bookings/code/{bookingCode}`
- **Authentication:** Required (JWT Token)
- **Path Parameters:** `bookingCode` (String)
- **Response:** `IntercityBookingResponse`
- **Used In:** `IntercityBookingConfirmationPage` (to fetch booking after creation)

#### 12. Get Booking History
- **Endpoint:** `GET /api/customer/intercity/bookings/history`
- **Authentication:** Required (JWT Token)
- **Response:** `List<IntercityBookingResponse>`
- **Used In:** `IntercityBookingsListPage` (History tab)

#### 13. Get Active Bookings
- **Endpoint:** `GET /api/customer/intercity/bookings/active`
- **Authentication:** Required (JWT Token)
- **Response:** `List<IntercityBookingResponse>`
- **Used In:** `IntercityBookingsListPage` (Active tab)

#### 14. Switch to Alternative Vehicle
- **Endpoint:** `POST /api/customer/intercity/bookings/{bookingId}/switch`
- **Authentication:** Required (JWT Token)
- **Path Parameters:** `bookingId` (Long)
- **Request Body:**
  ```json
  {
    "vehicleType": "CAR_PREMIUM_EXPRESS"
  }
  ```
- **Response:** `IntercityBookingResponse`
- **Used In:** `IntercityBookingDetailsPage` (if user wants to upgrade/downgrade)

---

## 📁 File Structure

```
lib/
├── presentation/
│   ├── intercity/
│   │   ├── views/
│   │   │   ├── intercity_search_page.dart
│   │   │   ├── intercity_trip_results_page.dart
│   │   │   ├── intercity_trip_details_page.dart
│   │   │   ├── intercity_booking_page.dart
│   │   │   ├── intercity_booking_confirmation_page.dart
│   │   │   ├── intercity_bookings_list_page.dart
│   │   │   ├── intercity_booking_details_page.dart
│   │   │   └── share_pooling_search_page.dart
│   │   ├── widgets/
│   │   │   ├── intercity_trip_card.dart
│   │   │   ├── intercity_vehicle_option_card.dart
│   │   │   ├── intercity_booking_card.dart
│   │   │   └── intercity_route_map_widget.dart
│   │   ├── view_model/
│   │   │   ├── intercity_search_notifier.dart
│   │   │   ├── intercity_trip_results_notifier.dart
│   │   │   ├── intercity_trip_details_notifier.dart
│   │   │   ├── intercity_booking_notifier.dart
│   │   │   └── intercity_bookings_notifier.dart
│   │   └── provider/
│   │       └── intercity_providers.dart
│   └── dashboard/
│       └── widgets/
│           └── services_and_promotional.dart (UPDATE)
├── data/
│   ├── models/
│   │   └── intercity/
│   │       ├── intercity_trip_search_request.dart
│   │       ├── intercity_trip_search_response.dart
│   │       ├── intercity_trip_dto.dart
│   │       ├── intercity_vehicle_option_dto.dart
│   │       ├── intercity_booking_request.dart
│   │       ├── intercity_booking_response.dart
│   │       └── intercity_alternative_dto.dart
│   ├── services/
│   │   └── intercity_service.dart
│   └── repositories/
│       ├── interfaces/
│       │   └── intercity_repo_interface.dart
│       └── intercity_repo_impl.dart
└── core/
    ├── config/
    │   └── api_endpoints.dart (UPDATE)
    └── routes/
        └── app_routes.dart (UPDATE)
```

---

## 🔄 State Management (Riverpod)

### Providers Needed:
1. `intercitySearchNotifierProvider` - Search form state
2. `intercityTripResultsNotifierProvider` - Trip results list
3. `intercityTripDetailsNotifierProvider` - Trip details
4. `intercityBookingNotifierProvider` - Booking creation
5. `intercityBookingsNotifierProvider` - Bookings list (active/history)
6. `intercityVehicleOptionsProvider` - Vehicle options cache

---

## 🎨 UI/UX Considerations

1. **Loading States:** Shimmer loaders for all lists
2. **Empty States:** Friendly messages with illustrations
3. **Error Handling:** Toast notifications + retry buttons
4. **Form Validation:** Real-time validation with error messages
5. **Date Picker:** Min date = today, show calendar
6. **Map Integration:** Show route on map in trip details
7. **Price Display:** Clear breakdown (base + taxes + total)
8. **Booking Type Toggle:** Visual toggle for Private vs Share Pool
9. **Seats Selector:** Increment/decrement buttons with min/max validation
10. **Status Badges:** Color-coded status indicators

---

## 📝 Next Steps

1. **Update Home Screen:** Modify `services_and_promotional.dart` to add Intercity & Share Pooling cards
2. **Create Data Models:** Based on API response structure (you'll provide)
3. **Create Service Layer:** API calls for all endpoints
4. **Create Repository Layer:** Business logic + error handling
5. **Create View Models:** State management with Riverpod
6. **Create UI Screens:** All 9 screens listed above
7. **Add Routes:** Update `app_routes.dart` with new routes
8. **Integration:** Connect everything together

---

## 🔑 Key Points

- **Share Pooling** can reuse most of Intercity screens with a filter
- **Booking Type** determines if it's private or shared
- **OTP System** is handled on driver side (not in customer app)
- **Payment Integration** required for booking confirmation
- **Real-time Updates** may need WebSocket for booking status changes

