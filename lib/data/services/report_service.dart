import 'package:dio/dio.dart';

import '../../core/config/api_endpoints.dart';
import '../../domain/interfaces/report_service_interface.dart';
import 'api/dio_client.dart';
import 'local_storage_service.dart';

class ReportService implements IReportService {
  final DioClient dioClient;

  ReportService({required this.dioClient});
  @override
  Future<Response> getReportType() async {
    // Spring Boot: Report types - may need custom endpoint or use reviews
    // For now, return empty or use a placeholder
    return await dioClient.dio.get('/api/admin/reviews'); // Placeholder
  }
  @override
  Future<Response> submitReport({required int? orderId, String? reportName, required String? details}) async {
    // Spring Boot: Submit report as review with negative rating
    final userId = await LocalStorageService().getUserId();
    return await dioClient.dio.post(
      ApiEndpoints.submitReport, 
      data: {
        'rideId': orderId,
        'reviewerUserId': userId,
        'rating': 1, // Low rating for report
        'comment': '$reportName: $details',
      }
    );
  }

}
