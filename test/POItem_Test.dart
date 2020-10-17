import 'dart:async';

import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/Supplier.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  //
  PurchaseOrderItem _poItem;
  StreamController<PurchaseOrderItem> _controller;
  setUp(() {
    _controller = StreamController<PurchaseOrderItem>();
    _poItem = PurchaseOrderItem(
      approvedBy: 'Saman',
      diliveryAddress: 'Colombo',
    );
  });
  group('[PurchaseOrder]', () {
    //
    test('[Model] Check individual values', () async {
      _poItem = PurchaseOrderItem(
          approvedBy: 'Saman',
          department: 'Construction',
          diliveryAddress: 'Colombo',
          diliveryDate: '2020/10/17',
          phone: '078888882',
          quotation: new SupplierQuotation(
              product: new Product(desc: "Bricks"),
              supplier: new Supplier(supplierName: "Saman"),
              requisition: new Requisition(reqNo: '123')));
// BEGIN TESTS....
      expect(_poItem.diliveryAddress, 'Colombo');
      expect(_poItem.approvedBy.runtimeType, equals(String));
      expect(_poItem.department, isNotNull);
      expect(_poItem.diliveryDate, isNotNull);
      expect(_poItem.phone, isNotNull);
      expect(_poItem.toMap(), isNotEmpty);
// expect(_locationModel.languages, contains('EN'));
// expect(_locationModel.currency, startsWith('G'));
// expect(_locationModel.country, matches('England'));
    });
  });
}
