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
  Requisition _requisition;
  StreamController<PurchaseOrderItem> _controller;

  group('[PaymentModelTest]', () {
    //
    test('[Model] Check individual values', () async {
      _requisition = Requisition(
          date: '2020.05.20',
          location: 'malabe',
          reqNo: 's1542',
          totPrice: 45.45);
// BEGIN TESTS....
      expect(_requisition.date, '2020.05.20');
      expect(_requisition.location.runtimeType, equals(String));
      expect(_requisition.reqNo, isNotNull);
      expect(_requisition.totPrice, isNotNull);
      expect(_requisition.toMap(), isNotEmpty);
    });
  });
}
