import 'package:dio/dio.dart';
import 'package:gauva_userapp/core/config/api_endpoints.dart';
import 'package:gauva_userapp/data/services/api/dio_client.dart';

class CouponService {
  final DioClient dioClient;

  CouponService({required this.dioClient});

  Future<Response> getAvailableCoupons() async {
    return await dioClient.dio.get(ApiEndpoints.getAvailableCoupons);
  }

  Future<Response> checkCoupon(String code) async {
    return await dioClient.dio.get('${ApiEndpoints.checkCoupon}/$code');
  }

  Future<Response> validateCoupon({required String code, required double baseFare}) async {
    return await dioClient.dio.post(ApiEndpoints.validateCoupon, data: {'code': code, 'baseFare': baseFare});
  }

  Future<Response> applyCoupon({required String code, required double baseFare, String? rideId}) async {
    final Map<String, dynamic> data = {'code': code, 'baseFare': baseFare};
    if (rideId != null) {
      data['rideId'] = rideId;
    }
    return await dioClient.dio.post(ApiEndpoints.applyCoupon, data: data);
  }

  Future<Response> getMyRedemptions() async {
    return await dioClient.dio.get(ApiEndpoints.myRedemptions);
  }
}
