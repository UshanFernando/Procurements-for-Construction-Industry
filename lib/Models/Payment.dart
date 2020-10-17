class Payment {
  String paymentID;
  String paymentDate;
  double amount;
  String invoiceURL;

  Payment({this.paymentID, this.paymentDate, this.amount, this.invoiceURL});

  Map<String, dynamic> toMap() {
    return {
      'paymentID': paymentID,
      'paymentDate': paymentDate,
      'amount': amount,
      'invoiceURL': invoiceURL,
    };
  }
}
