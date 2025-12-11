import 'package:dio/dio.dart';
import '../../domain/interfaces/terms_privacy.dart';
import 'api/dio_client.dart';

class TermsAndPrivacyService implements ITermsAndPrivacy {
  final DioClient dioClient;

  TermsAndPrivacyService({required this.dioClient});
  @override
  Future<Response> termsAndCondition() async {
    // Spring Boot: Terms and conditions - endpoint not yet implemented
    // Return empty response to avoid error until proper endpoint is available
    // TODO: Replace with actual terms and conditions endpoint when available
    return Response(
      requestOptions: RequestOptions(path: '/api/customer/config/terms-and-conditions'),
      statusCode: 200,
      data: {'content': 'Terms and conditions will be available soon.'},
    );
  }

  @override
  Future<Response> privacyPolicy() async {
    // Spring Boot: Privacy policy - endpoint not yet implemented
    // Return empty response to avoid error until proper endpoint is available
    // TODO: Replace with actual privacy policy endpoint when available
    return Response(
      requestOptions: RequestOptions(path: '/api/customer/config/privacy-policy'),
      statusCode: 200,
      data: {'content': 'Privacy policy will be available soon.'},
    );
  }
}
