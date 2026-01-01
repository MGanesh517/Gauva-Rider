import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/coupon_model/coupon_model.dart';
import '../../../../data/repositories/coupon_repo_impl.dart';
import '../../../../data/repositories/interfaces/coupon_repo_interface.dart';
import '../../../../data/services/coupon_service.dart';
import '../../auth/provider/auth_providers.dart';
import '../../../../core/state/app_state.dart';
import '../view_model/coupon_notifier.dart';

// Service Provider
final couponServiceProvider = Provider<CouponService>((ref) {
  return CouponService(dioClient: ref.read(dioClientProvider));
});

// Repository Provider
final couponRepoProvider = Provider<ICouponRepo>((ref) {
  return CouponRepoImpl(couponService: ref.read(couponServiceProvider));
});

// Notifier Providers
final couponNotifierProvider = StateNotifierProvider<CouponNotifier, AppState<List<CouponModel>>>(
  (ref) => CouponNotifier(couponRepo: ref.read(couponRepoProvider)),
);

final couponValidationNotifierProvider = StateNotifierProvider<CouponValidationNotifier, AppState<Map<String, dynamic>>>(
  (ref) => CouponValidationNotifier(couponRepo: ref.read(couponRepoProvider)),
);
