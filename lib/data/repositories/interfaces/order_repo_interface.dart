import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/create_order_response/create_order_response.dart';
import 'package:gauva_userapp/data/models/order_response/order_detail/order_detail_model.dart';
import 'package:gauva_userapp/data/models/order_response/tip_model/trip_model.dart';
import 'package:gauva_userapp/data/models/intercity_ride_history_model/intercity_ride_history_model.dart';

import '../../../core/errors/failure.dart';

abstract class IOrderRepo {
  Future<Either<Failure, CreateOrderResponse>> createOrder({required Map<String, dynamic> data});
  Future<Either<Failure, OrderDetailModel>> orderDetails({required int orderId});
  Future<Either<Failure, TripModel>> checkActiveTrip();
  Future<Either<Failure, List<IntercityRideHistoryModel>>> getIntercityRideHistory();
}
