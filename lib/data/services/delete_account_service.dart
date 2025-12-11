import 'package:dio/dio.dart';
import '../../domain/interfaces/delete_account_service.dart';
import 'api/dio_client.dart';
import 'local_storage_service.dart';

class DeleteAccountService implements IDeleteAccountService {
  final DioClient dioClient;

  DeleteAccountService({required this.dioClient});
  @override
  Future<Response> deleteAccount() async {
    // Spring Boot: /api/v1/user/{userId} DELETE
    final userId = await LocalStorageService().getUserId();
    return await dioClient.dio.delete('/api/v1/user/$userId');
  }

}
