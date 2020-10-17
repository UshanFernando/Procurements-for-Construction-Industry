import 'package:construction_procurement_app/Models/Payment.dart';
import 'package:construction_procurement_app/Models/PurchaseOrder.dart';

class PurchaseOrderPayment {
  PurchaseOrder po;
  Payment payment;

  PurchaseOrderPayment({this.po, this.payment});

  Map<String, dynamic> toMap() {
    return {
      'po': po.toMap(),
      'Payment': payment.toMap(),
    };
  }
}
