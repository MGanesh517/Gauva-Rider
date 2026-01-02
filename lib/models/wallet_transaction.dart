import 'package:intl/intl.dart';

class WalletTransaction {
  final String id;
  final double amount;
  final String type; // CREDIT, DEBIT
  final String description;
  final DateTime date;
  final String status; // SUCCESS, PENDING, FAILED

  WalletTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.date,
    required this.status,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) {
    return WalletTransaction(
      id: json['id']?.toString() ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'] ?? 'DEBIT',
      description: json['description'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      status: json['status'] ?? 'SUCCESS',
    );
  }

  String get formattedDate {
    return DateFormat('MMM dd, yyyy hh:mm a').format(date);
  }

  bool get isCredit => type.toUpperCase() == 'CREDIT';
}
