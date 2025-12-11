import 'package:dio/dio.dart';
import 'package:gauva_userapp/core/config/api_endpoints.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';

import '../../domain/interfaces/auth_service_interface.dart';
import 'local_storage_service.dart';

class AuthService implements IAuthService {
  final DioClient dioClient;
  AuthService({required this.dioClient});
  @override
  Future<Response> login({required String phone, required String countryCode, String? deviceToken}) async {
    // Spring Boot: Send OTP request with phoneNumber
    // Combine country code with phone number for full international format
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), '');
    String fullPhoneNumber = '+$cleanCountryCode$phone';

    return dioClient.dio.post(
      ApiEndpoints.loginOtpUrl,
      data: {
        'phoneNumber': fullPhoneNumber, // Spring Boot expects phoneNumber for sending OTP
      },
    );
  }

  @override
  Future<Response> resendSignIn({required num? userId, required String? deviceToken}) async {
    // Spring Boot: Resend OTP requires phoneNumber
    // Get phone number from saved user data
    try {
      final user = await LocalStorageService().getSavedUser();
      final phoneCode = await LocalStorageService().getPhoneCode();
      String cleanCountryCode = phoneCode.replaceAll(RegExp(r'^\+|^0'), '');
      String fullPhoneNumber = '+$cleanCountryCode${user?.mobile ?? ''}';

      return await dioClient.dio.post(
        ApiEndpoints.resendSignIn,
        data: {
          'phoneNumber': fullPhoneNumber, // Spring Boot expects phoneNumber for resend OTP
        },
      );
    } catch (e) {
      // Fallback: return error response
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 400,
        data: {'message': 'Unable to get phone number for resend'},
      );
    }
  }

  @override
  Future<Response> loginWithPassword({
    required String mobile,
    required String password,
    String? deviceToken,
    String? wantLogin,
  }) async {
    // Spring Boot: Login with password expects only phone number (without country code) as identifier
    // Get country code to remove it from mobile number if present
    final countryCode = await LocalStorageService().getPhoneCode();
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), ''); // Remove + and leading 0

    // Clean mobile number: remove country code prefix if present, then remove all non-digits
    String cleanMobile = mobile;
    // Remove country code from start if present (with or without +)
    if (cleanMobile.startsWith('+$cleanCountryCode')) {
      cleanMobile = cleanMobile.substring(cleanCountryCode.length + 1); // Remove + and country code
    } else if (cleanMobile.startsWith(cleanCountryCode)) {
      cleanMobile = cleanMobile.substring(cleanCountryCode.length); // Remove country code
    }
    // Remove any remaining non-digit characters
    cleanMobile = cleanMobile.replaceAll(RegExp(r'[^\d]'), '');

    return await dioClient.dio.post(
      ApiEndpoints.loginUrl,
      data: {
        'identifier': cleanMobile, // Only phone number without country code
        'password': password,
        'role': 'NORMAL_USER', // Spring Boot requires role
      },
    );
  }

  @override
  Future<Response> verifyOtp({
    required String mobile,
    required String otp,
    String? deviceToken,
    String? wantLogin,
  }) async {
    // Spring Boot: Verify OTP with idToken (Firebase ID token) and role
    // Note: For OTP verification, idToken should be the Firebase ID token, not the OTP code
    // If using Firebase Auth, get the ID token from Firebase
    // For now, using OTP as idToken (may need Firebase integration)
    return await dioClient.dio.post(
      ApiEndpoints.loginOtpUrl,
      data: {
        'idToken': otp, // Firebase ID token (or OTP if Firebase not integrated)
        'role': 'NORMAL_USER',
      },
    );
  }

  @override
  Future<Response> updatePassword({required String password}) async {
    // Spring Boot: Update password via profile update
    final userId = await LocalStorageService().getUserId();
    return await dioClient.dio.put(
      '/api/v1/user/$userId', // Update user endpoint
      data: {'password': password},
    );
  }

  @override
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required newConfirmPassword,
  }) async {
    // Spring Boot: Change password via profile update
    return await dioClient.dio.post(
      '/api/v1/user/change-password',
      data: {'currentPassword': currentPassword, 'newPassword': newPassword, 'confirmPassword': newConfirmPassword},
    );
  }

  @override
  Future<Response> updateProfile({required Map<String, dynamic> data}) async {
    // Spring Boot: Update profile via /api/v1/user/profile
    return await dioClient.dio.put('/api/v1/user/profile', data: data);
  }

  @override
  Future<Response> resendOTP({required String mobile}) async {
    // Spring Boot: Resend OTP requires phoneNumber
    // Combine country code with mobile for full international phone number
    final countryCode = await LocalStorageService().getPhoneCode();
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), '');

    // Clean the mobile number - remove country code if already present
    String cleanMobile = mobile;

    // Remove + prefix if exists
    if (cleanMobile.startsWith('+')) {
      cleanMobile = cleanMobile.substring(1);
    }

    // Check if mobile already starts with country code and remove it
    if (cleanMobile.startsWith(cleanCountryCode)) {
      cleanMobile = cleanMobile.substring(cleanCountryCode.length);
    }

    // Remove any remaining non-digit characters
    cleanMobile = cleanMobile.replaceAll(RegExp(r'\D'), '');

    // Construct full phone number
    String fullPhoneNumber = '+$cleanCountryCode$cleanMobile';

    return await dioClient.dio.post(
      ApiEndpoints.resendOTP,
      data: {
        'phoneNumber': fullPhoneNumber, // Spring Boot expects phoneNumber for OTP request
      },
    );
  }

  @override
  Future<Response> forgotPassword({required String mobile}) async {
    // Combine country code with mobile for full phone number
    final countryCode = await LocalStorageService().getPhoneCode();
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), '');
    String fullPhoneNumber = '$cleanCountryCode$mobile';

    return await dioClient.dio.post(
      ApiEndpoints.forgotPassword,
      data: {
        'identifier': fullPhoneNumber, // Full phone number
        'role': 'NORMAL_USER',
      },
    );
  }

  @override
  Future<Response> updateProfilePhoto({required String imagePath}) async {
    // Spring Boot: Update profile photo via user profile update
    final userId = await LocalStorageService().getUserId();
    final FormData formData = FormData.fromMap({'profileImage': await MultipartFile.fromFile(imagePath)});
    return await dioClient.dio.put('/api/v1/user/$userId', data: formData);
  }

  @override
  Future<Response> riderDetails() async => await dioClient.dio.get(
    ApiEndpoints.riderDetails,
    options: Options(headers: {'Authorization': 'Bearer ${await LocalStorageService().getToken()}'}),
  );

  @override
  Future<Response> logout() async => await dioClient.dio.post(
    ApiEndpoints.logout,
    options: Options(headers: {'Authorization': 'Bearer ${await LocalStorageService().getToken()}'}),
  );

  @override
  Future<Response> forgetVerifyOtp({required String mobile, required String otp}) async {
    // Combine country code with mobile for full phone number
    final countryCode = await LocalStorageService().getPhoneCode();
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), '');
    String fullPhoneNumber = '$cleanCountryCode$mobile';

    return await dioClient.dio.post(
      ApiEndpoints.forgetVerifyOtp,
      data: {
        'idToken': otp, // OTP verification token
        'identifier': fullPhoneNumber, // Full phone number
        'role': 'NORMAL_USER',
      },
    );
  }

  @override
  Future<Response> requestOTP({required String mobile}) async {
    // Spring Boot: Request OTP requires phoneNumber
    // Combine country code with mobile for full international phone number
    final countryCode = await LocalStorageService().getPhoneCode();
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), '');

    // Clean the mobile number - remove country code if already present
    String cleanMobile = mobile;

    // Remove + prefix if exists
    if (cleanMobile.startsWith('+')) {
      cleanMobile = cleanMobile.substring(1);
    }

    // Check if mobile already starts with country code and remove it
    if (cleanMobile.startsWith(cleanCountryCode)) {
      cleanMobile = cleanMobile.substring(cleanCountryCode.length);
    }

    // Remove any remaining non-digit characters
    cleanMobile = cleanMobile.replaceAll(RegExp(r'\D'), '');

    // Construct full phone number
    String fullPhoneNumber = '+$cleanCountryCode$cleanMobile';

    return await dioClient.dio.post(
      ApiEndpoints.requestOTP,
      data: {
        'phoneNumber': fullPhoneNumber, // Spring Boot expects phoneNumber for OTP request
      },
    );
  }

  @override
  Future<Response> resetPassword({required Map<String, dynamic> data}) async {
    // Spring Boot: Reset password via user update
    final userId = await LocalStorageService().getUserId();
    return await dioClient.dio.put('/api/v1/user/$userId', data: {'password': data['password'] ?? data['new_password']});
  }

  @override
  Future<Response> signup({
    required String email,
    required String fullName,
    required String password,
    required String phone,
  }) async {
    // Spring Boot: User registration/signup
    // Combine country code with phone number for full international format
    final countryCode = await LocalStorageService().getPhoneCode();
    String cleanCountryCode = countryCode.replaceAll(RegExp(r'^\+|^0'), '');
    String fullPhoneNumber = '+$cleanCountryCode$phone';

    return await dioClient.dio.post(
      ApiEndpoints.signupUrl,
      data: {
        'email': email,
        'fullName': fullName,
        'password': password,
        'phone': fullPhoneNumber, // Full international phone number
      },
    );
  }

  @override
  Future<Response> signInWithGoogle({
    required String idToken,
    String? name,
    String? email,
    String? phone,
    String? deviceToken,
  }) async {
    // Spring Boot: Google sign-in endpoint
    final Map<String, dynamic> body = {
      'idToken': idToken,
    };
    
    // Add optional fields only if they are provided
    if (name != null && name.isNotEmpty) {
      body['name'] = name;
    }
    if (email != null && email.isNotEmpty) {
      body['email'] = email;
    }
    if (phone != null && phone.isNotEmpty) {
      body['phone'] = phone;
    }
    
    return await dioClient.dio.post('/api/v1/auth/login/google', data: body);
  }
}
