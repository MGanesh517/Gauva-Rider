# 🐛 Debug Prints Guide - Rider App

## Overview
Comprehensive debug logging has been added throughout the entire application to help track API calls, responses, and model parsing errors.

---

## 📍 Debug Print Locations

### 🔵 **1. DIO INTERCEPTOR** (`lib/data/services/api/dio_interceptors.dart`)

#### **onRequest** - Before every API call
```
🔵 ═══════════════════════════════════════════════════════
🔵 API REQUEST
🔵 Method: [GET/POST/PUT/DELETE]
🔵 URL: [Full URL]
🔵 Headers: [All headers]
🔵 Request Body: [Body data if present]
🔵 Query Params: [Query parameters if present]
🔵 ═══════════════════════════════════════════════════════
🔐 Token added to headers / ⚠️ No token found
```

#### **onResponse** - After successful API call
```
🟢 ═══════════════════════════════════════════════════════
🟢 API RESPONSE SUCCESS
🟢 URL: [Full URL]
🟢 Status Code: [200/201/etc]
🟢 Response Data: [Full response]
🟢 ═══════════════════════════════════════════════════════
```

#### **onError** - When API call fails
```
🔴 ═══════════════════════════════════════════════════════
🔴 API ERROR
🔴 URL: [Full URL]
🔴 Method: [GET/POST/PUT/DELETE]
🔴 Error Type: [DioExceptionType]
🔴 Status Code: [400/401/500/etc]
🔴 Error Message: [Error message]
🔴 Response Data: [Error response if available]
🔴 ═══════════════════════════════════════════════════════
```

---

### 🔷 **2. BASE REPOSITORY** (`lib/data/repositories/base_repository.dart`)

#### **safeApiCall** - Wraps every API call
```
🔷 ═══════════════════════════════════════════════════════
🔷 SAFE API CALL START
🔷 ═══════════════════════════════════════════════════════
✅ Internet connection available
🔷 Executing API call...
🟢 API call successful
🟢 Result Type: [Type name]
🔷 ═══════════════════════════════════════════════════════
```

#### **Error Handling**
```
🔴 ═══════════════════════════════════════════════════════
🔴 DIO EXCEPTION CAUGHT / TIMEOUT EXCEPTION / UNEXPECTED ERROR
🔴 Error Type: [Exception type]
🔴 Error: [Error message]
🔴 Stack Trace: [Full stack trace]
🔴 ═══════════════════════════════════════════════════════
```

---

### 🔐 **3. AUTHENTICATION** (`lib/data/repositories/auth_repo_impl.dart`)

#### **Login**
```
📱 LOGIN - Phone: [phone], Country: [code]
📥 LOGIN Response Data: [response]
✅ LOGIN - Parsed successfully
🔴 LOGIN - Parsing error: [error] (if fails)
```

#### **Login with Password**
```
🔐 LOGIN WITH PASSWORD - Mobile: [mobile]
📥 LOGIN WITH PASSWORD Response: [response]
✅ LOGIN WITH PASSWORD - Parsed successfully
🔴 LOGIN WITH PASSWORD - Parsing error: [error] (if fails)
```

#### **Verify OTP**
```
✉️ VERIFY OTP - Mobile: [mobile], OTP: [otp]
📥 VERIFY OTP Response: [response]
✅ VERIFY OTP - Parsed successfully
🔴 VERIFY OTP - Parsing error: [error] (if fails)
```

#### **Signup**
```
📝 SIGNUP - Email: [email], Phone: [phone], Name: [name]
📥 SIGNUP Response: [response]
✅ SIGNUP - Parsed successfully
🔴 SIGNUP - Parsing error: [error] (if fails)
```

#### **Resend OTP**
```
🔄 RESEND OTP - Mobile: [mobile]
📥 RESEND OTP Response: [response]
✅ RESEND OTP - Parsed successfully
🔴 RESEND OTP - Parsing error: [error] (if fails)
```

---

### 🚗 **4. ORDERS** (`lib/data/repositories/order_repo_impl.dart`)

#### **Create Order**
```
🚗 CREATE ORDER - Data: [order data]
📥 CREATE ORDER Response: [response]
✅ CREATE ORDER - Parsed successfully
✅ Order ID: [id]
🔴 CREATE ORDER - Parsing error: [error] (if fails)
🔴 Raw response data: [raw data]
```

#### **Order Details**
```
📋 ORDER DETAILS - Order ID: [id]
📥 ORDER DETAILS Response: [response]
✅ ORDER DETAILS - Parsed successfully
🔴 ORDER DETAILS - Parsing error: [error] (if fails)
```

#### **Check Active Trip**
```
🔍 CHECK ACTIVE TRIP
📥 CHECK ACTIVE TRIP Response: [response]
✅ CHECK ACTIVE TRIP - Parsed successfully
✅ Active order: [order_id] / None
🔴 CHECK ACTIVE TRIP - Parsing error: [error] (if fails)
```

---

### 🚕 **5. RIDE SERVICES** (`lib/data/repositories/ride_service_repo_impl.dart`)

#### **Get Ride Services**
```
🚕 GET RIDE SERVICES - Filter: [filter data]
📥 GET RIDE SERVICES Response: [response]
✅ GET RIDE SERVICES - Parsed successfully
✅ Services count: [count]
🔴 GET RIDE SERVICES - Parsing error: [error] (if fails)
```

#### **Get Services Home**
```
🏠 GET SERVICES HOME
📥 GET SERVICES HOME Response: [response]
✅ GET SERVICES HOME - Parsed successfully
🔴 GET SERVICES HOME - Parsing error: [error] (if fails)
```

---

### 💰 **6. WALLET** (`lib/data/repositories/wallets_repo_impl.dart`)

```
💰 GET WALLETS
📥 GET WALLETS Response: [response]
✅ GET WALLETS - Parsed successfully
✅ Balance: [balance]
🔴 GET WALLETS - Parsing error: [error] (if fails)
```

---

### 💬 **7. CHAT** (`lib/data/repositories/chat_repo_impl.dart`)

#### **Get Messages**
```
💬 GET MESSAGES - User ID: [user_id]
📥 GET MESSAGES Response: [response]
✅ GET MESSAGES - Parsed successfully
✅ Messages count: [count]
🔴 GET MESSAGES - Parsing error: [error] (if fails)
```

#### **Send Message**
```
✉️ SEND MESSAGE - To: [receiver_id], Message: [message]
📥 SEND MESSAGE Response: [response]
✅ SEND MESSAGE - Parsed successfully
🔴 SEND MESSAGE - Parsing error: [error] (if fails)
```

---

### 📜 **8. RIDE HISTORY** (`lib/data/repositories/ride_history_repo_impl.dart`)

```
📜 GET RIDE HISTORY - Status: [status], Date: [date]
📥 GET RIDE HISTORY Response: [response]
✅ GET RIDE HISTORY - Parsed successfully
✅ Orders count: [count]
🔴 GET RIDE HISTORY - Parsing error: [error] (if fails)
```

---

### ⭐ **9. RATING** (`lib/data/repositories/rating_repo_impl.dart`)

```
⭐ SUBMIT RATING - Order: [order_id], Rating: [rating], Comment: [comment]
📥 SUBMIT RATING Response: [response]
✅ SUBMIT RATING - Parsed successfully
🔴 SUBMIT RATING - Parsing error: [error] (if fails)
```

---

### ❌ **10. CANCEL RIDE** (`lib/data/repositories/cancel_ride_repo_impl.dart`)

```
❌ CANCEL RIDE - Order ID: [order_id]
📥 CANCEL RIDE Response: [response]
✅ CANCEL RIDE - Parsed successfully
🔴 CANCEL RIDE - Parsing error: [error] (if fails)
```

---

### 💳 **11. PAYMENT** (`lib/data/repositories/payment_confirm_repo_impl.dart`)

```
💳 PAYMENT CONFIRM - Order: [order_id], Method: [payment_method]
📥 PAYMENT CONFIRM Response: [response]
✅ PAYMENT CONFIRM - Parsed successfully
🔴 PAYMENT CONFIRM - Parsing error: [error] (if fails)
```

---

### 🚗 **12. DRIVERS** (`lib/data/repositories/driver_repo_impl.dart`)

```
🚗 GET DRIVERS - Location: [lat], [lng]
📥 GET DRIVERS Response: [response]
✅ GET DRIVERS - Parsed successfully
✅ Drivers count: [count]
🔴 GET DRIVERS - Parsing error: [error] (if fails)
```

---

### 🗺️ **13. GOOGLE MAPS** (`lib/data/repositories/google_api_repo_impl.dart`)

#### **Get Address from LatLng**
```
📍 GET ADDRESS FROM LATLNG - Lat: [lat], Lng: [lng]
📥 Google Geocoding API Response Status: [OK/ERROR]
✅ Address found: [address]
⚠️ Address not found, returning Unknown Location
```

#### **Fetch Waypoints**
```
🗺️ FETCH WAYPOINTS - Count: [count]
   Waypoint 0: [name] - [address]
   Waypoint 1: [name] - [address]
📥 Google Directions API Response Status: [OK/ERROR]
✅ FETCH WAYPOINTS - Decoded [count] points
⚠️ FETCH WAYPOINTS - No routes found
```

#### **Search Place**
```
🔍 SEARCH PLACE - Query: [query], Origin: [lat], [lng]
📥 Google Places Autocomplete Response Status: [OK/ERROR]
📍 Found [count] predictions
📏 Fetching distances for [count] places
✅ SEARCH PLACE - Returning [count] places
⚠️ SEARCH PLACE - No results found
```

---

### 🔵 **14. AUTH NOTIFIERS** (`lib/presentation/auth/view_model/auth_notifier.dart`)

#### **Login Notifier**
```
🔵 ═══════════════════════════════════════════════════════
🔵 LOGIN NOTIFIER - Starting login
🔵 Phone: [phone]
🔵 Country Code: [code]
🔵 ═══════════════════════════════════════════════════════
🔐 Device Token: [token]
🔴 LOGIN FAILED: [message] / 🟢 LOGIN SUCCESS
🟢 Is New User: [true/false]
🟢 Mobile: [mobile]
```

#### **Login with Password Notifier**
```
🔵 ═══════════════════════════════════════════════════════
🔵 LOGIN WITH PASSWORD - Starting
🔵 Mobile: [mobile]
🔵 ═══════════════════════════════════════════════════════
🔴 LOGIN WITH PASSWORD FAILED: [message] / 🟢 LOGIN WITH PASSWORD SUCCESS
```

#### **Verify OTP Notifier**
```
🔵 ═══════════════════════════════════════════════════════
🔵 VERIFY OTP - Starting
🔵 Mobile: [mobile]
🔵 OTP: [otp]
🔵 ═══════════════════════════════════════════════════════
🔴 VERIFY OTP FAILED: [message] / 🟢 VERIFY OTP SUCCESS
🟢 Has Token: [true/false]
```

#### **Signup Notifier**
```
🔵 ═══════════════════════════════════════════════════════
🔵 SIGNUP NOTIFIER - Starting signup
🔵 Email: [email]
🔵 Full Name: [name]
🔵 Phone: [phone]
🔵 Country Code: [code]
🔵 ═══════════════════════════════════════════════════════
🔴 SIGNUP FAILED: [message] / 🟢 SIGNUP SUCCESS
🟢 Has Token: [true/false]
```

---

### 🚗 **15. CREATE ORDER NOTIFIER** (`lib/presentation/booking/view_model/create_order_notifier.dart`)

#### **Create Order**
```
🔵 ═══════════════════════════════════════════════════════
🔵 CREATE ORDER - Starting
🔵 Order Data: [data]
🔵 ═══════════════════════════════════════════════════════
🔴 CREATE ORDER FAILED: [message] / 🟢 CREATE ORDER SUCCESS
🟢 Order ID: [id]
🟢 Status: [status]
```

#### **Check Trip Activity**
```
🔍 ═══════════════════════════════════════════════════════
🔍 CHECK TRIP ACTIVITY - Starting
🔍 ═══════════════════════════════════════════════════════
🔴 CHECK TRIP ACTIVITY FAILED: [message] / 🟢 ACTIVE TRIP FOUND
🟢 Order ID: [id]
🟢 Status: [status]
✅ NO ACTIVE TRIP
⚠️ No token found - user not logged in
```

---

### 📡 **16. PUSHER EVENTS** (`lib/presentation/booking/view_model/pushar_notifier.dart`)

#### **Event Received**
```
📡 ═══════════════════════════════════════════════════════
📡 PUSHER EVENT RECEIVED
📡 Channel: [channel_name]
📡 Event: [event_name]
📡 Raw Data: [raw_data]
📡 ═══════════════════════════════════════════════════════
⚠️ PUSHER - Empty data after parsing
📡 Parsed Data: [parsed_data]
```

#### **Order Channel Events**
```
📦 ORDER CHANNEL EVENT: [event_name]
❌ Order Cancelled Notification
📝 Message: [message]
🔄 Status Update Notification
📝 Inner Data: [data]
🚫 Driver Declined - Looking for another
⚠️ Unknown order event: [event_name]
```

#### **Location Updates**
```
📍 LOCATION UPDATE
⚠️ Location data is null
📍 Location data: [data]
📍 Parsed - Lat: [lat], Lng: [lng]
✅ Updating driver location on map
⚠️ Invalid lat/lng values
```

---

### 🎯 **17. ORDER STATUS UPDATES** (`lib/presentation/track_order/view_model/handle_order_status_update.dart`)

```
🎯 ═══════════════════════════════════════════════════════
🎯 HANDLE ORDER STATUS UPDATE
🎯 Status: [status]
🎯 Order ID: [order_id]
🎯 From Pusher: [true/false]
🎯 Payment Status: [status]
🎯 ═══════════════════════════════════════════════════════

Status-specific logs:
⏳ Status: PENDING - Waiting for driver
✅ Status: ACCEPTED - Driver accepted ride
🚗 Status: GO_TO_PICKUP - Driver heading to pickup
📍 Status: CONFIRM_ARRIVAL - Driver at pickup point
🚙 Status: PICKED_UP - Rider in car
🏁 Status: START_RIDE - Heading to destination
🎉 Status: DROPPED_OFF - Ride completed
✅ Status: COMPLETED - Ride finished
⚠️ Unknown status: [status]

🔗 Setting up Pusher listeners for real-time updates
🎯 ═══════════════════════════════════════════════════════
```

---

## 🎨 Debug Print Legend

| Icon | Meaning |
|------|---------|
| 🔵 | **Request/Action Start** |
| 🟢 | **Success** |
| 🔴 | **Error/Failure** |
| ⚠️ | **Warning** |
| 📡 | **Pusher Event** |
| 📱 | **Phone/Mobile** |
| 🔐 | **Authentication/Token** |
| 💰 | **Wallet/Money** |
| 🚗 | **Driver/Vehicle** |
| 📍 | **Location** |
| 💬 | **Chat** |
| 📜 | **History** |
| ⭐ | **Rating** |
| 💳 | **Payment** |
| 🗺️ | **Maps** |
| 🎯 | **Status Update** |
| ✅ | **Completed** |
| ❌ | **Cancelled** |

---

## 📊 What Gets Logged

### **Every API Call Shows:**
1. ✅ Request method (GET/POST/PUT/DELETE)
2. ✅ Full URL
3. ✅ Headers (including Authorization token)
4. ✅ Request body/payload
5. ✅ Query parameters
6. ✅ Response status code
7. ✅ Full response data
8. ✅ Error details if failed
9. ✅ Stack trace on errors

### **Every Model Parsing Shows:**
1. ✅ Input data being parsed
2. ✅ Success confirmation
3. ✅ Parsed result summary (counts, IDs, etc.)
4. ✅ Parsing errors with stack trace
5. ✅ Raw response data on error

### **Every Pusher Event Shows:**
1. ✅ Channel name
2. ✅ Event name
3. ✅ Raw event data
4. ✅ Parsed data
5. ✅ Handling logic flow

---

## 🔍 How to Use These Logs

### **Finding Issues:**

1. **API Not Working?**
   - Look for `🔵 API REQUEST` → Check URL and payload
   - Look for `🟢 API RESPONSE` → Check response data
   - Look for `🔴 API ERROR` → Check error message

2. **Model Parsing Error?**
   - Look for `🔴 [FEATURE] - Parsing error`
   - Check the `Raw response data` line
   - Compare with your model structure

3. **Pusher Not Working?**
   - Look for `📡 PUSHER EVENT RECEIVED`
   - Check channel and event names
   - Verify parsed data structure

4. **Order Status Issues?**
   - Look for `🎯 HANDLE ORDER STATUS UPDATE`
   - Check which status is being processed
   - Follow the status-specific logs

### **Example Debug Session:**

```
// User tries to login
🔵 ═══════════════════════════════════════════════════════
🔵 LOGIN NOTIFIER - Starting login
🔵 Phone: 9542295621
🔵 Country Code: +91
🔵 ═══════════════════════════════════════════════════════
🔐 Device Token: abc123...

🔵 ═══════════════════════════════════════════════════════
🔵 API REQUEST
🔵 Method: POST
🔵 URL: https://gauva.../api/v1/auth/login/otp
🔵 Headers: {Content-Type: application/json, ...}
🔵 Request Body: {phoneNumber: +919542295621}
🔵 ═══════════════════════════════════════════════════════

🟢 ═══════════════════════════════════════════════════════
🟢 API RESPONSE SUCCESS
🟢 URL: https://gauva.../api/v1/auth/login/otp
🟢 Status Code: 200
🟢 Response Data: {success: true, message: OTP sent, ...}
🟢 ═══════════════════════════════════════════════════════

📱 LOGIN - Phone: 9542295621, Country: +91
📥 LOGIN Response Data: {success: true, ...}
✅ LOGIN - Parsed successfully
🟢 LOGIN SUCCESS
🟢 Is New User: false
🟢 Mobile: +919542295621
```

---

## 🎯 Benefits

1. ✅ **Track every API call** - See exactly what's sent and received
2. ✅ **Catch parsing errors** - Know exactly which model fails to parse
3. ✅ **Debug Pusher events** - See real-time event flow
4. ✅ **Monitor order flow** - Track status changes step by step
5. ✅ **Identify issues quickly** - Colored logs make problems obvious

---

## 🚀 All Logs Are Production-Safe

- Uses `debugPrint()` which is automatically removed in release builds
- No performance impact in production
- Helps during development and testing

---

**Now run your app and check the console - you'll see detailed logs for EVERYTHING! 🎉**

---

## 🐛 Issues Found & Fixed

### Issue #1: Check Active Trip Parsing Error

**Error Message:**
```
🔴 CHECK ACTIVE TRIP - Parsing error: type 'String' is not a subtype of type 'int' of 'index'
📥 CHECK ACTIVE TRIP Response: []
```

**Root Cause:**
- API returns empty array `[]` when no active trips
- `TripModel.fromJson()` expects object format `{message: ..., data: ...}`
- Trying to parse array as object caused type error

**Fix Applied:**
- Added array detection in `order_repo_impl.dart`
- Empty array `[]` → Returns `TripModel(message: 'No active trips', data: null)`
- Non-empty array → Wraps first item in expected format
- Object response → Parses normally

**Status:** ✅ **FIXED**

---

