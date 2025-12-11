import 'package:dio/dio.dart';

import '../../core/state/rider_service_state.dart';

abstract class IRideServicesService {
  Future<Response> getRideServices({required RiderServiceState riderServiceState});
  Future<Response> getServicesHome();
  Future<Response> applyCoupon({required String? coupon});
}
