import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/wallet_transaction.dart';
import '../../services/user_wallet_service.dart';
import '../../widgets/transaction_item.dart';
import '../../data/services/api/dio_client.dart';

final allTransactionsProvider = FutureProvider.family<List<WalletTransaction>, int>((ref, page) async {
  final service = UserWalletService(dioClient: DioClient());
  return service.getTransactions(page: page, size: 20);
});

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends ConsumerState<TransactionHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  List<WalletTransaction> _transactions = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Create a temporary provider access or use the service directly for pagination logic
      // Ideally this should be handled by a more robust state management solution (e.g. AsyncNotifier)
      // For simplicity in this implementation guide, we'll fetch directly.
      final service = UserWalletService(dioClient: DioClient());
      final newTransactions = await service.getTransactions(page: _currentPage, size: 20);

      if (mounted) {
        setState(() {
          _transactions.addAll(newTransactions);
          _currentPage++;
          _isLoading = false;
          if (newTransactions.length < 20) {
            _hasMore = false;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading transactions: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: _transactions.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _transactions.isEmpty && !_isLoading
          ? const Center(child: Text('No transactions found'))
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _transactions.length) {
                  return const Center(
                    child: Padding(padding: EdgeInsets.all(16.0), child: CircularProgressIndicator()),
                  );
                }
                return TransactionItem(transaction: _transactions[index]);
              },
            ),
    );
  }
}
