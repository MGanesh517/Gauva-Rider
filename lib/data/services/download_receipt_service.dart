import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gauva_userapp/domain/interfaces/download_receipt_service_interface.dart';
import 'api/dio_client.dart';

class DownloadReceiptService implements IDownloadReceiptService {
  final DioClient dioClient;

  DownloadReceiptService({required this.dioClient});
  @override
  Future<Response> getDownloadLink({int? id}) async {
    // Spring Boot: /api/payments/history/ride/{rideId}
    return await dioClient.dio.get('/api/payments/history/ride/$id');
  }

  @override
  Future<File> download(String? url)async{
    final dir = await getApplicationDocumentsDirectory();
    final String path = DateTime.now().millisecondsSinceEpoch.toString();
    final filePath = '${dir.path}/invoice_$path.pdf';
    await dioClient.dio.download(url!, filePath);
    return File(filePath);
  }

}
