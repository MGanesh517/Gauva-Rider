import 'package:flutter/material.dart';

class WalletBalanceCard extends StatelessWidget {
  final double balance;
  final String currency;
  // final VoidCallback? onAddMoney;

  const WalletBalanceCard({Key? key, required this.balance, required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      // gradient: LinearGradient(
      //   colors: [Colors.blue.shade800, Colors.blue.shade500],
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      // ),
      gradient: const LinearGradient(
        colors: [Color(0xFF397098), Color(0xFF942FAF)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),

      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Balance',
          style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$currency ${balance.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            // if (onAddMoney != null)
            //   ElevatedButton.icon(
            //     onPressed: onAddMoney,
            //     icon: const Icon(Icons.add, size: 18),
            //     label: const Text('Add Money'),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       foregroundColor: Colors.blue.shade800,
            //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //     ),
            //   ),
          ],
        ),
      ],
    ),
  );
}
