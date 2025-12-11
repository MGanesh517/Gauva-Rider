import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/repositories/base_repository.dart';
import 'package:gauva_userapp/data/repositories/interfaces/cancel_ride_repo_interface.dart';
import '../../domain/interfaces/cancel_ride_service_interface.dart';

class CancelRideRepoImpl extends BaseRepository implements ICancelRideRepo {
  final ICancelRideService rideService;

  CancelRideRepoImpl({required this.rideService});

  @override
  Future<Either<Failure, CommonResponse>> cancelRide({required int? orderId}) async => await safeApiCall(()async{
      debugPrint('❌ CANCEL RIDE - Order ID: $orderId');
      final response = await rideService.cancelRide(orderId: orderId,);
      debugPrint('📥 CANCEL RIDE Response: ${response.data}');
      try {
        final result = CommonResponse.fromMap(response.data);
        debugPrint('✅ CANCEL RIDE - Parsed successfully');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 CANCEL RIDE - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        rethrow;
      }
    });

}
