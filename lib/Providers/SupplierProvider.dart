import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:construction_procurement_app/Services/FirestoreService.dart';
import 'package:flutter/material.dart';

class SupplierProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _supplierName;
  String _details;
  String _item;
  double _price = 0;
  List<SupplierQuotation> _supplierQuotation = List();

  //getters
  String get suplierName => _supplierName;
  String get details => _details;
  String get item => _item;
  double get price => _price;
  List<SupplierQuotation> get supplierQuotation => _supplierQuotation;

  //setters
  changeSuplierName(String value) {
    _supplierName = value;
    notifyListeners();
  }

  changeDetails(String value) {
    _details = value;
    notifyListeners();
  }

  changeItem(String value) {
    _item = value;
    notifyListeners();
  }

  changePrice(double value) {
    _price = value;
    notifyListeners();
  }
}
