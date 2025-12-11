import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/my_card_model/my_card_model.dart';
import 'package:gauva_userapp/presentation/wallet/view_model/add_card_notifier.dart';
import 'package:gauva_userapp/presentation/wallet/view_model/delete_card_notifier.dart';
import 'package:gauva_userapp/presentation/wallet/view_model/my_cards_notifier.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/wallet_model/wallet_model.dart';
import '../../../data/repositories/interfaces/wallet_repo_interface.dart';
import '../../../data/repositories/wallets_repo_impl.dart';
import '../../../data/services/wallet_service.dart';
import '../../../domain/interfaces/wallet_service_interface.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/wallets_notifier.dart';

// Service Provider
final walletsServiceProvider = Provider<IWalletService>((ref) => WalletService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final walletsRepoProvider = Provider<IWalletsRepo>(
  (ref) => WalletsRepoImpl(walletService: ref.read(walletsServiceProvider)),
);

final walletsNotifierProvider = StateNotifierProvider<WalletsNotifier, AppState<WalletModel>>(
  (ref) => WalletsNotifier(walletsRepo: ref.watch(walletsRepoProvider), ref: ref),
);

final myCardsProvider = StateNotifierProvider<MyCardsNotifier, AppState<List<Cards>>>(
  (ref) => MyCardsNotifier(walletsRepo: ref.watch(walletsRepoProvider), ref: ref),
);

final addCardProvider = StateNotifierProvider<AddCardNotifier, AppState<CommonResponse>>(
  (ref) => AddCardNotifier(walletsRepo: ref.watch(walletsRepoProvider), ref: ref),
);

final deleteCardProvider = StateNotifierProvider<DeleteCardNotifier, AppState<CommonResponse>>(
  (ref) => DeleteCardNotifier(walletsRepo: ref.watch(walletsRepoProvider), ref: ref),
);
