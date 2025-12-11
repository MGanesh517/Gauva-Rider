# Razorpay Integration Guide

## Current Status
The wallet top-up API (`/v1/payments/wallet/topup`) returns Razorpay payment details, but the Razorpay Flutter SDK is not yet installed.

## API Response Format
```json
{
  "razorpayOrderId": "order_xxx",
  "razorpayKey": "rzp_test_xxx",
  "amount": 100.00,
  "currency": "INR"
}
```

## Integration Steps

### 1. Add Razorpay Package
Add to `pubspec.yaml`:
```yaml
dependencies:
  razorpay_flutter: ^1.3.7
```

### 2. Install Package
```bash
flutter pub get
```

### 3. Update Wallets Notifier
Replace the TODO section in `lib/presentation/wallet/view_model/wallets_notifier.dart`:

```dart
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletsNotifier extends StateNotifier<AppState<WalletModel>> {
  Razorpay? _razorpay;
  
  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }
  
  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('✅ Razorpay Payment Success: ${response.paymentId}');
    showNotification(message: 'Payment successful!');
    NavigationService.pop();
    getWallets(); // Refresh balance
  }
  
  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('🔴 Razorpay Payment Error: ${response.message}');
    showNotification(message: 'Payment failed: ${response.message}');
  }
  
  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('💳 External Wallet: ${response.walletName}');
  }
  
  Future<void> addBalance(String amount) async {
    debugPrint('💰 ADD BALANCE - Initiating top-up for amount: $amount');
    state = const AppState.loading();
    final result = await walletsRepo.addBalance(amount: amount);
    result.fold(
      (failure) {
        debugPrint('🔴 ADD BALANCE - Failed: ${failure.message}');
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        debugPrint('✅ ADD BALANCE - Success');
        
        // Check if Razorpay payment is needed
        if (data.data?.razorpayOrderId != null && data.data?.razorpayKey != null) {
          debugPrint('💳 Razorpay Order Created');
          debugPrint('💳 Order ID: ${data.data?.razorpayOrderId}');
          debugPrint('💳 Key: ${data.data?.razorpayKey}');
          debugPrint('💳 Amount: ${data.data?.amount}');
          
          // Initialize Razorpay if not already done
          _razorpay ??= Razorpay();
          _initRazorpay();
          
          // Open Razorpay checkout
          var options = {
            'key': data.data!.razorpayKey!,
            'amount': (data.data!.amount! * 100).toInt(), // Amount in paise
            'currency': data.data?.currency ?? 'INR',
            'name': 'Gauva',
            'description': 'Wallet Top-up',
            'order_id': data.data!.razorpayOrderId!,
            'prefill': {
              'contact': '', // Add user phone if available
              'email': '',   // Add user email if available
            },
            'theme': {
              'color': '#397098'
            }
          };
          
          try {
            _razorpay!.open(options);
          } catch (e) {
            debugPrint('🔴 Error opening Razorpay: $e');
            showNotification(message: 'Failed to open payment gateway');
          }
          
          state = AppState.success(data);
        } else {
          // Direct balance added (admin or other method)
          state = AppState.success(data);
          NavigationService.pop();
          getWallets();
        }
      },
    );
  }
}
```

### 4. Android Configuration
Add to `android/app/build.gradle`:
```gradle
android {
    defaultConfig {
        // ... existing config
        manifestPlaceholders = [
            'razorpayKey': 'rzp_test_xxx'
        ]
    }
}
```

### 5. Android Proguard (if using minify)
Add to `android/app/proguard-rules.pro`:
```
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keepattributes JavascriptInterface
-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}
-optimizations !method/inlining/
-keepclasseswithmembers class * {
  public void onPayment*(...);
}
```

## Current Implementation (Without Razorpay SDK)

The current code will:
1. ✅ Call `/v1/payments/wallet/topup` API
2. ✅ Get Razorpay order details from response
3. ✅ Parse `razorpayOrderId`, `razorpayKey`, `amount`, `currency`
4. ✅ Show notification with order ID
5. ⚠️ Cannot open Razorpay checkout (SDK not installed)

## To Complete Integration

1. Add `razorpay_flutter` package to `pubspec.yaml`
2. Run `flutter pub get`
3. Update `wallets_notifier.dart` with the code above
4. Test wallet top-up flow

## API Endpoint

**POST** `/v1/payments/wallet/topup`

**Request:**
```json
{
  "amount": 100,
  "ownerType": "USER",
  "ownerId": "50c59a1c-56f5-454d-9a15-517bbd06d0a2"
}
```

**Response:**
```json
{
  "razorpayOrderId": "order_xxx",
  "razorpayKey": "rzp_test_xxx",
  "amount": 100.00,
  "currency": "INR"
}
```

## Payment Flow

1. User enters amount → Clicks "Add Wallet"
2. App calls `/v1/payments/wallet/topup`
3. Backend creates Razorpay order
4. App receives Razorpay credentials
5. App opens Razorpay checkout (when SDK installed)
6. User completes payment
7. Razorpay webhook notifies backend
8. Backend credits wallet
9. App refreshes balance

---

**Note:** The code is ready for Razorpay integration. Just add the package and uncomment the Razorpay checkout code!

