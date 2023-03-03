class Wallet {
  double balance;
  int id;
  String cinClient;
  String reference;

  Wallet({
    required this.balance,
    required this.id,
    required this.cinClient,
    required this.reference
  });

  factory Wallet.fromJson(Map<dynamic, dynamic> json) {
    return Wallet(
      balance: json['balance'],
      id: json['id'],
      cinClient: json['cinClient'],
      reference: json['reference']
    );
  }
}