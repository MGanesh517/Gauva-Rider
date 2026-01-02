import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/wallet_balance.dart';
import '../../models/wallet_transaction.dart';
import '../../services/user_wallet_service.dart';
import '../../widgets/wallet_balance_card.dart';
import '../../widgets/transaction_item.dart';
import '../../data/services/api/dio_client.dart';
import 'transaction_history_screen.dart';

final userWalletServiceProvider = Provider<UserWalletService>((ref) {
  return UserWalletService(dioClient: DioClient());
});

final walletBalanceProvider = FutureProvider<WalletBalance>((ref) async {
  final service = ref.read(userWalletServiceProvider);
  return service.getWalletBalance();
});

final recentTransactionsProvider = FutureProvider<List<WalletTransaction>>((ref) async {
  final service = ref.read(userWalletServiceProvider);
  return service.getTransactions(page: 0, size: 5);
});

class WalletScreen extends ConsumerWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(walletBalanceProvider);
    final transactionsAsync = ref.watch(recentTransactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet'), elevation: 0),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(walletBalanceProvider);
          return ref.refresh(recentTransactionsProvider.future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              balanceAsync.when(
                data: (balance) => WalletBalanceCard(balance: balance.balance, currency: balance.currency),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
              const SizedBox(height: 24),
              Row(
                children: [Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))],
              ),
              const SizedBox(height: 12),
              transactionsAsync.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const Center(
                      child: Padding(padding: EdgeInsets.all(20.0), child: Text('No recent transactions')),
                    );
                  }
                  return Column(children: transactions.map((tx) => TransactionItem(transaction: tx)).toList());
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
