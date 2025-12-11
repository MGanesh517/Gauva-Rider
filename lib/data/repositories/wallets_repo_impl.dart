import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/data/models/common_response.dart';
import 'package:gauva_userapp/data/models/my_card_model/my_card_model.dart';
import '../../core/errors/failure.dart';
import '../../domain/interfaces/wallet_service_interface.dart';
import '../models/wallet_model/wallet_model.dart' as wallet;
import 'base_repository.dart';
import 'interfaces/wallet_repo_interface.dart';

class WalletsRepoImpl extends BaseRepository implements IWalletsRepo {
  final IWalletService walletService;

  WalletsRepoImpl({required this.walletService});
  @override
  Future<Either<Failure, wallet.WalletModel>> getWallets() async => await safeApiCall(() async {
      debugPrint('💰 GET WALLET BALANCE');
      final response = await walletService.getWallets();
      debugPrint('📥 GET WALLET BALANCE Response: ${response.data}');
      debugPrint('📥 Response Type: ${response.data.runtimeType}');
      
      try {
        // Handle direct balance number (e.g., 500.0)
        if (response.data is num) {
          debugPrint('📦 GET WALLET BALANCE - Direct balance number detected');
          return wallet.WalletModel(
            message: 'Wallet balance fetched',
            data: wallet.Data(balance: response.data),
          );
        }
        
        // Handle direct wallet object with balance
        if (response.data is Map && response.data.containsKey('balance')) {
          debugPrint('📦 GET WALLET BALANCE - Wallet object with balance detected');
          final wrappedData = {
            'message': 'Wallet balance fetched',
            'data': response.data,
          };
          final result = wallet.WalletModel.fromJson(wrappedData);
          debugPrint('✅ GET WALLET BALANCE - Parsed successfully');
          debugPrint('✅ Balance: ${result.data?.balance}');
          return result;
        }
        
        // Handle wrapped response {message, data: {balance}}
        if (response.data is Map && response.data.containsKey('data')) {
          final result = wallet.WalletModel.fromJson(response.data);
          debugPrint('✅ GET WALLET BALANCE - Parsed wrapped response successfully');
          debugPrint('✅ Balance: ${result.data?.balance}');
          return result;
        }
        
        // Handle normal wrapped response
        final result = wallet.WalletModel.fromJson(response.data);
        debugPrint('✅ GET WALLET BALANCE - Parsed successfully');
        debugPrint('✅ Balance: ${result.data?.balance}');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 GET WALLET BALANCE - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response data: ${response.data}');
        // Return empty wallet on error
        return wallet.WalletModel(
          message: 'Error loading wallet balance',
          data: wallet.Data(balance: 0),
        );
      }
    });

  @override
  Future<Either<Failure, wallet.WalletModel>> addBalance({required String amount}) async => await safeApiCall(() async {
      debugPrint('💰 ADD BALANCE/TOPUP - Amount: $amount');
      final response = await walletService.addBalance(amount: amount);
      debugPrint('📥 TOPUP Response: ${response.data}');
      debugPrint('📥 Response Type: ${response.data.runtimeType}');
      
      try {
        // Handle payment link response (new format)
        if (response.data is Map && response.data.containsKey('paymentLinkUrl')) {
          debugPrint('📦 TOPUP - Payment link created');
          final wrappedData = {
            'message': 'Payment link created',
            'data': response.data,
          };
          final result = wallet.WalletModel.fromJson(wrappedData);
          debugPrint('✅ TOPUP - Payment Link URL: ${result.data?.paymentLinkUrl}');
          debugPrint('✅ TOPUP - Payment Link ID: ${result.data?.paymentLinkId}');
          debugPrint('✅ TOPUP - Transaction ID: ${result.data?.transactionId}');
          debugPrint('✅ TOPUP - Status: ${result.data?.status}');
          debugPrint('✅ TOPUP - Amount: ${result.data?.amount}');
          return result;
        }
        
        // Handle direct Razorpay response (old format)
        if (response.data is Map && response.data.containsKey('razorpayOrderId')) {
          debugPrint('📦 TOPUP - Razorpay order created');
          final wrappedData = {
            'message': 'Razorpay order created',
            'data': response.data,
          };
          final result = wallet.WalletModel.fromJson(wrappedData);
          debugPrint('✅ TOPUP - Razorpay Order ID: ${result.data?.razorpayOrderId}');
          debugPrint('✅ TOPUP - Razorpay Key: ${result.data?.razorpayKey}');
          return result;
        }
        
        // Handle wrapped response
        final result = wallet.WalletModel.fromJson(response.data);
        debugPrint('✅ TOPUP - Parsed successfully');
        return result;
      } catch (e, stackTrace) {
        debugPrint('🔴 TOPUP - Parsing error: $e');
        debugPrint('🔴 Stack trace: $stackTrace');
        debugPrint('🔴 Raw response data: ${response.data}');
        rethrow;
      }
    });

  @override
  Future<Either<Failure, CommonResponse>> addCard({required Map<String, dynamic> body}) async => await safeApiCall(() async {
      final response = await walletService.addCard(body: body);
      return CommonResponse.fromMap(response.data);
    });

  @override
  Future<Either<Failure, MyCardModel>> myCards() async => await safeApiCall(() async {
      final response = await walletService.myCards();
      return MyCardModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> deleteCard({required String? id}) async => await safeApiCall(() async {
      final response = await walletService.deleteCard(id);
      return CommonResponse.fromMap(response.data);
    });
}
