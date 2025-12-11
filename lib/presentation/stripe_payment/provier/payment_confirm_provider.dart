import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/payent_confirm_model/payment_confirm_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/payment_confirm_repo_interface.dart';
import 'package:gauva_userapp/data/repositories/payment_confirm_repo_impl.dart';
import 'package:gauva_userapp/data/services/payment_confirm_service.dart';
import 'package:gauva_userapp/domain/interfaces/payment_confirm_service_interface.dart';
import 'package:gauva_userapp/presentation/stripe_payment/view_model/hit_success_url_notifier.dart';
import 'package:gauva_userapp/presentation/stripe_payment/view_model/payment_confirm_notify.dart';
import '../../../core/state/app_state.dart';
import '../../auth/provider/auth_providers.dart';

// RideService Provider (depends on Dio)
final paymentConfirmServiceProvider = Provider<IPaymentConfirmService>(
  (ref) => PaymentConfirmService(dioClient: ref.read(dioClientProvider)),
);

// RideRepo Provider (depends on RideService)
final paymentConfirmRepoProvider = Provider<IPaymentConfirmRepo>(
  (ref) => PaymentConfirmRepoImpl(paymentConfirmService: ref.read(paymentConfirmServiceProvider)),
);

final paymentConfirmNotifierProvider = StateNotifierProvider<PaymentConfirmNotifier, AppState<PaymentConfirmModel?>>(
  (ref) => PaymentConfirmNotifier(ref, ref.read(paymentConfirmRepoProvider)),
);

final hitSuccessUrlProvider = StateNotifierProvider<HitSuccessUrlNotifier, AppState<CommonResponse?>>(
  (ref) => HitSuccessUrlNotifier(ref, ref.read(paymentConfirmRepoProvider)),
);
