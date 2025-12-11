import 'package:dartz/dartz.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/my_card_model/my_card_model.dart';
import '../../../core/errors/failure.dart';
import '../../models/wallet_model/wallet_model.dart' as wallet;

abstract class IWalletsRepo {
  Future<Either<Failure, wallet.WalletModel>> getWallets();
  Future<Either<Failure, MyCardModel>> myCards();
  Future<Either<Failure, CommonResponse>> addCard({required Map<String, dynamic> body});
  Future<Either<Failure, wallet.WalletModel>> addBalance({required String amount});
  Future<Either<Failure, CommonResponse>> deleteCard({required String? id});
}
