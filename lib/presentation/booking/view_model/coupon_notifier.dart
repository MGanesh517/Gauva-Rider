import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/app_state.dart';
import '../../../../data/models/coupon_model/coupon_model.dart';
import '../../../../data/repositories/interfaces/coupon_repo_interface.dart';

class CouponNotifier extends StateNotifier<AppState<List<CouponModel>>> {
  final ICouponRepo couponRepo;

  CouponNotifier({required this.couponRepo}) : super(const AppState.initial());

  Future<void> getAvailableCoupons() async {
    state = const AppState.loading();
    final result = await couponRepo.getAvailableCoupons();
    result.fold((failure) => state = AppState.error(failure), (coupons) => state = AppState.success(coupons));
  }
}

class CouponValidationNotifier extends StateNotifier<AppState<Map<String, dynamic>>> {
  final ICouponRepo couponRepo;

  CouponValidationNotifier({required this.couponRepo}) : super(const AppState.initial());

  Future<void> validateCoupon({required String code, required double baseFare}) async {
    state = const AppState.loading();
    final result = await couponRepo.validateCoupon(code: code, baseFare: baseFare);
    result.fold((failure) => state = AppState.error(failure), (data) => state = AppState.success(data));
  }

  void reset() {
    state = const AppState.initial();
  }
}
