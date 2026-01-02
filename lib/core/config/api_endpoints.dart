class ApiEndpoints {
  // Auth endpoints - Spring Boot
  static const String loginUrl = '/api/v1/auth/login';
  static const String loginOtpUrl = '/api/v1/auth/login/otp';
  static const String resendSignIn = '/api/v1/auth/login/otp'; // Resend OTP uses same endpoint
  static const String signupUrl = '/api/v1/auth/register/user'; // User registration/signup
  static const String googleLoginUrl = '/api/v1/auth/login/google'; // Google Sign In
  static const String updatePassword = '/api/v1/user/profile'; // Update password via profile update
  static const String changePassword = '/api/v1/user/profile'; // Change password via profile update
  static const String updateProfile = '/api/v1/user/profile';
  static const String updateProfilePhoto = '/api/v1/user/profile'; // Profile photo via profile update
  static const String riderDetails = '/api/v1/user/profile';
  static const String resendOTP = '/api/v1/auth/login/otp';
  static const String forgotPassword = '/api/v1/auth/forgot-password'; // Send OTP to email
  static const String verifyPasswordResetOtp = '/api/v1/auth/verify-password-reset-otp'; // Verify OTP
  static const String resetPassword = '/api/v1/auth/reset-password'; // Reset password with OTP
  static const String logout = '/api/v1/auth/logout/user';
  static const String requestOTP = '/api/v1/auth/login/otp';
  static const String forgetVerifyOtp = '/api/v1/auth/login/otp'; // Legacy endpoint

  // Notification endpoints - Spring Boot
  static const String submitFcmToken = '/api/notifications/token'; // Submit FCM token

  // User Wallet Endpoints
  static const String userWalletBalance = '/api/v1/user/wallet/balance';
  static const String userWalletTransactions = '/api/v1/user/wallet/transactions';

  // Driver Wallet Endpoints
  static const String driverWalletBalance = '/api/v1/driver/wallet/balance';
  static const String driverWalletTransactions = '/api/v1/driver/wallet/transactions';

  // Ride endpoints - Spring Boot
  // static const String rideServices = '/api/v1/services/fare-estimates'; // Fare estimation
  static const String rideServices = '/api/v1/services/available-for-route'; // Fare estimation
  static const String availableServicesForRoute = '/api/v1/services/available-for-route'; // Available services for route
  static const String servicesHome = '/api/v1/services'; // Services list
  static const String getDrivers = '/api/customer/drivers-near-me';
  static const String getAvailableCoupons = '/api/v1/coupons/available';
  static const String checkCoupon = '/api/v1/coupons/check'; // append /{code}
  static const String validateCoupon = '/api/v1/coupons/validate';
  static const String applyCoupon = '/api/v1/coupons/apply';
  static const String myRedemptions = '/api/v1/coupons/my-redemptions';
  static const String createOrder = '/api/v1/ride/request';
  static const String orderDetails = '/api/v1/ride'; // Use /api/v1/ride/{rideId}
  static const String checkActiveTrip = '/api/v1/user'; // Use /api/v1/user/{userId}/rides/current
  static const String rideHistory = '/api/v1/ride/user/history';
  static const String cancelledRideHistory = '/api/v1/user/rides/cancelled';
  static const String cancelRide = '/api/v1/ride'; // Use /api/v1/ride/{rideId}/cancel
  static String cancelRideEndpoint(int rideId) => '/api/v1/ride/$rideId/cancel';

  // Chat endpoints - Spring Boot
  static const String sendMessage = '/api/chat/ride'; // Use /api/chat/ride/{rideId}/messages
  static const String getMessage = '/api/chat/ride'; // Use /api/chat/ride/{rideId}/messages

  // Payment endpoints - Spring Boot
  static const String paymentConfirm = '/api/payments'; // Use /api/payments/{rideId}
  static const String paymentMethods = '/api/payments'; // Payment methods info

  // Rating endpoint - Spring Boot
  static const String rating = '/api/reviews';

  // Report endpoints - Spring Boot (may need to check if these exist)
  static const String getReportTypes = '/api/admin/reviews'; // Report types - check if exists
  static const String submitReport = '/api/reviews'; // Submit report as review

  // Account management - Spring Boot
  static const String deleteAccount = '/api/v1/user'; // Use /api/v1/user/{userId} DELETE

  // Location/Place endpoints - Zone-specific (Public APIs)
  static const String searchPlace = '/api/customer/config/place-api-autocomplete'; // Place autocomplete
  static const String getPlaceDetails = '/api/customer/config/place-api-details'; // Get place details
  static const String getAddressFromLatLng = '/api/customer/config/geocode-api'; // Reverse geocoding
  static const String getZoneId = '/api/customer/config/get-zone-id'; // Get zone for location
  static const String fetchWayPoints = '/api/location/directions'; // Get directions/route (if needed)
  static const String fetchDistances = '/api/location/distance-matrix'; // Get distances (if needed)

  // Config endpoints - Spring Boot
  static const String getCountryList = '/api/customer/config/place-api-details'; // Country codes

  // Legal/Info endpoints - Spring Boot (may need custom endpoints)
  static const String termsAndConditions = '/api/customer/config/place-api-details'; // Check if exists
  static const String privacyPolicy = '/api/customer/config/place-api-details'; // Check if exists
  static const String downloadInvoice = '/api/payments/history/ride'; // Use /api/payments/history/ride/{rideId}

  // Promotional endpoints - Spring Boot
  static const String promotionalSlider = '/api/promotions/coupons'; // Promotional content

  // Preference endpoint - Spring Boot (may need custom endpoint)
  static const String ridePreference = '/api/v1/user/profile'; // User preferences via profile

  // Intercity endpoints - Spring Boot
  static const String intercityServiceTypes = '/api/customer/intercity/service-types'; // Intercity service types list
  static const String intercitySearch = '/api/customer/intercity/search'; // Intercity search
  static const String intercityDrivers = '/api/customer/intercity/drivers'; // Fetch drivers for vehicle type
  static const String intercityBooking = '/api/customer/intercity/bookings'; // Intercity booking
  static const String intercityRideHistory = '/api/driver/intercity/trips/history';
}
