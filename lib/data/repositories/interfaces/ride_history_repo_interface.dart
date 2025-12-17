import 'package:dartz/dartz.dart';
import '../../../core/errors/failure.dart';
import '../../models/ride_history_response/ride_history_item.dart';

abstract class IRideHistoryRepo {
  Future<Either<Failure, List<RideHistoryItem>>> getRideHistory(String? status, String? date);
}
