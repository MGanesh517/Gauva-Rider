import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/ride_history_response/ride_history_model.dart';

abstract class IRideHistoryRepo {
  Future<Either<Failure, RideHistoryModel>> getRideHistory(String? status, String? date);
}
