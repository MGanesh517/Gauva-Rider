import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/order_response/order_model/order/order.dart';
import 'package:gauva_userapp/data/repositories/interfaces/order_repo_interface.dart';
import 'package:gauva_userapp/data/repositories/order_repo_impl.dart';
import 'package:gauva_userapp/data/services/order_service.dart';
import 'package:gauva_userapp/domain/interfaces/order_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';

import '../../../core/state/app_state.dart';
import '../view_model/create_order_notifier.dart';

final orderServiceProvider = Provider<IOrderService>((ref) => OrderService(dioClient: ref.read(dioClientProvider)));

final orderRepoProvider = Provider<IOrderRepo>((ref) => OrderRepoImpl(ref.read(orderServiceProvider)));

final createOrderNotifierProvider =
    StateNotifierProvider<CreateOrderNotifier, AppState<Order>>((ref) => CreateOrderNotifier(ref.read(orderRepoProvider,), ref));

final tripActivityNotifierProvider =
StateNotifierProvider<CheckTripActivityNotifier, AppState<Order?>>((ref) => CheckTripActivityNotifier(ref.read(orderRepoProvider,), ref));