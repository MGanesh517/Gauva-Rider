import 'package:dio/dio.dart';
import 'package:gauva_userapp/domain/interfaces/country_list_service_interface.dart';
import 'api/dio_client.dart';

class CountryListService implements ICountryListService {
  final DioClient dioClient;

  CountryListService({required this.dioClient});
  @override
  Future<Response> getCountryList() async {
    // Spring Boot: Country codes - endpoint not yet implemented
    // Return empty response to avoid error until proper endpoint is available
    // TODO: Replace with actual country list endpoint when available
    return Response(
      requestOptions: RequestOptions(path: '/api/customer/config/country-list'),
      statusCode: 200,
      data: [],
    );
  }
}
