class WalletBalance {
  final double balance;
  final String currency;
  final double blockedAmount;

  WalletBalance({required this.balance, required this.currency, this.blockedAmount = 0.0});

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      balance: (json['balance'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'INR',
      blockedAmount: (json['blockedAmount'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'balance': balance, 'currency': currency, 'blockedAmount': blockedAmount};
  }
}
