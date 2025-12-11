import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/chat_message_response/chat_message_response.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import '../../../core/errors/failure.dart';

abstract class IChatRepo {
  Future<Either<Failure, ChatResponse>> getMessage(
      {required int userId});
  Future<Either<Failure, CommonResponse>> sendMessage(
      {required int receiverId, required String message});
}
