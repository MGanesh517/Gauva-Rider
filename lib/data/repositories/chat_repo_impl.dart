import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/chat_message_response/chat_message_response.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';

import '../../domain/interfaces/chat_service_interface.dart';
import 'interfaces/chat_repo_interface.dart';

class ChatRepoImpl extends BaseRepository implements IChatRepo {
  final IChatService chatService;

  ChatRepoImpl({required this.chatService});
  @override
  Future<Either<Failure, ChatResponse>> getMessage(
      {required int userId}) async => await safeApiCall(() async {
      debugPrint('💬 GET MESSAGES - User ID: $userId');
      final response = await chatService.getMessage(userId);
      debugPrint('📥 GET MESSAGES Response: ${response.data}');
      try {
        final result = ChatResponse.fromJson(response.data);
        debugPrint('✅ GET MESSAGES - Parsed successfully');
        debugPrint('✅ Messages count: ${result.data.length}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 GET MESSAGES - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        rethrow;
      }
    });

  @override
  Future<Either<Failure, CommonResponse>> sendMessage(
      {required int receiverId, required String message}) async => await safeApiCall(() async {
      debugPrint('✉️ SEND MESSAGE - To: $receiverId, Message: $message');
      final response = await chatService.sendMessage(message: message, receiverId: receiverId);
      debugPrint('📥 SEND MESSAGE Response: ${response.data}');
      try {
        final result = CommonResponse.fromMap(response.data);
        debugPrint('✅ SEND MESSAGE - Parsed successfully');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 SEND MESSAGE - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        rethrow;
      }
    });
}
