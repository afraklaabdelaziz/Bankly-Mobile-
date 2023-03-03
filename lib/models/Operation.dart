class Operation{
   String operationType;
   double amount;
   String dateTransaction;
   String walletRef;
   Operation({
     required this.operationType,
     required this.amount,
     required this.dateTransaction,
     required this.walletRef
});
   factory Operation.fromJson(Map<dynamic, dynamic> json) {
     return Operation(
       dateTransaction:json['dateTransaction'],
       operationType: json['operationType'],
       amount: json['amount'],
       walletRef: json['walletRef']
     );
   }
}