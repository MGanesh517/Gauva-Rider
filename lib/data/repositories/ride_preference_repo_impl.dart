import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/ride_preference_model/ride_preference_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/ride_preference_repo_interface.dart';
import 'package:gauva_userapp/domain/interfaces/ride_preference_service_interface.dart';
import '../../core/errors/failure.dart';
import 'base_repository.dart';

class RidePreferenceRepoImpl extends BaseRepository implements IRidePreferenceRepo {
  final IRidePreferenceService service;

  RidePreferenceRepoImpl({required this.service});
  @override
  Future<Either<Failure, RidePreferenceModel>> getPreference() async => await safeApiCall(() async {
      final response = await service.getPreference();
      return RidePreferenceModel.fromJson(response.data);
    });

}
