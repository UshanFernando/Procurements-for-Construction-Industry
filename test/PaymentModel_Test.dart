import 'dart:async';

import 'package:construction_procurement_app/Models/Payment.dart';
import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/Supplier.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  //
  Payment _paymentItem;
  StreamController<PurchaseOrderItem> _controller;
  setUp(() {
    _controller = StreamController<PurchaseOrderItem>();
  });
  group('[PaymentModelTest]', () {
    //
    test('[Model] Check individual values', () async {
      _paymentItem = Payment(
        amount: 2000,
        invoiceURL: 'http://firebasecloud/739jkcmkco9832mmd.jpg',
        paymentDate: '2020-10-08',
        paymentID: 'P26267'
      );
// BEGIN TESTS....
      expect(_paymentItem.amount, 2000);
      expect(_paymentItem.paymentID.runtimeType, equals(String));
      expect(_paymentItem.invoiceURL, isNotNull);
      expect(_paymentItem.paymentDate, isNotNull);
      expect(_paymentItem.toMap(), isNotEmpty);
    });
  });
}
