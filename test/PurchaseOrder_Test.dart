import 'dart:async';
import 'dart:collection';

import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrder.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/Supplier.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  //
  Product _product;
  PurchaseOrderItem _poItem;
  PurchaseOrder _po;

  StreamController<PurchaseOrderItem> _controller;
  setUp(() {
    _controller = StreamController<PurchaseOrderItem>();
    _poItem = PurchaseOrderItem(
      approvedBy: 'Saman',
      diliveryAddress: 'Colombo',
    );
  });
  group('[Product]', () {
    //
    test('[Product] Check individual values', () async {
      _product = Product(desc: 'Bricks', discount: 20, price: 250, qty: 50);
// BEGIN TESTS....
      expect(_product.desc, 'Bricks');
      expect(_product.desc.runtimeType, equals(String));
      expect(_product.discount, 20);
      expect(_product.price, 250);
      expect(_product.toMap(), isNotEmpty);
      expect(_product.toMap()['desc'], 'Bricks');
      expect(_product.toMap()['qty'], 50);
    });
  });
  group('[PurchaseOrder]', () {
    //
    test('[PurchaseOrder] Check individual values', () async {
      List<PurchaseOrderItem> _pOders = new List();
      _pOders.add(PurchaseOrderItem(
          approvedBy: 'Saman',
          department: 'Construction',
          diliveryAddress: 'Colombo',
          diliveryDate: '2020/10/17',
          phone: '078888882',
          quotation: new SupplierQuotation(
              product: new Product(desc: "Bricks"),
              supplier: new Supplier(supplierName: "Saman"),
              requisition: new Requisition(reqNo: '123'))));
      _pOders.add(PurchaseOrderItem(
          approvedBy: 'Kamal',
          department: 'Construction',
          diliveryAddress: 'Colombo',
          diliveryDate: '2020/10/12',
          phone: '078564382',
          quotation: new SupplierQuotation(
              product: new Product(desc: "Bricks"),
              supplier: new Supplier(supplierName: "Kamal"),
              requisition: new Requisition(reqNo: 'f123'))));
      _po = new PurchaseOrder(
          date: '20-15-2020', reqNo: 'b4566', poItems: _pOders, totPrice: 450);
// BEGIN TESTS....
      expect(_po.reqNo, 'b4566');
      expect(_po.date.runtimeType, equals(String));
      expect(_po.date, '20-15-2020');
      expect(_poItem.toMap(), isNotEmpty);
      expect(_poItem.toMap()['date'], '20-15-2020');
      expect(_poItem.toMap()['reqNo'], 'b4566');
    });
  });

  group('[PurchaseOrderItem]', () {
    //
    test('[PurchaseOrderItem] Check individual values', () async {
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
      expect(_poItem.toMap()['quotation']['product']['desc'], 'Bricks');
      expect(_poItem.toMap()['quotation']['supplier']['supplierName'], 'Saman');
    });
  });
}
