import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/ride_preference_model/ride_preference_model.dart';
import '../../../core/errors/failure.dart';

abstract class IRidePreferenceRepo {
  Future<Either<Failure, RidePreferenceModel>> getPreference();
}
