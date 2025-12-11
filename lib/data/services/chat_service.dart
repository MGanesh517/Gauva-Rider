import 'package:dio/dio.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';

import '../../domain/interfaces/chat_service_interface.dart';
import 'local_storage_service.dart';

class ChatService implements IChatService {
  final DioClient dioClient;

  ChatService({required this.dioClient});
   @override
   Future<Response> sendMessage({required String message, required int receiverId}) async {
     // Spring Boot: /api/chat/ride/{rideId}/messages expects ChatMessageRequest
     // Note: receiverId should be rideId in Spring Boot
     final rideId = receiverId; // Assuming receiverId is actually rideId
     return dioClient.dio.post(
       '/api/chat/ride/$rideId/messages',
       data: {
         'senderUserId': await LocalStorageService().getUserId(),
         'receiverUserId': receiverId,
         'content': message
       }
     );
   }
  @override
  Future<Response> getMessage(int userId) async {
    // Spring Boot: /api/chat/ride/{rideId}/messages (GET)
    // Note: userId should be rideId in Spring Boot
    final rideId = userId;
    return dioClient.dio.get('/api/chat/ride/$rideId/messages');
  }
}
