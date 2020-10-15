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
  int _selectedQIndex = 0;
  bool _completed = false;

  //getters
  String get suplierName => _supplierName;
  String get details => _details;
  String get item => _item;
  double get price => _price;
  bool get completedList => _completed;
  int get selectdQIndex => _selectedQIndex;
  List<SupplierQuotation> get supplierQuotations => _supplierQuotation;

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

  addSQ(SupplierQuotation quotation) {
    _supplierQuotation.add(quotation);
    print(_supplierQuotation);
    notifyListeners();
  }

  deleteSQ(SupplierQuotation quotation) {
    _supplierQuotation.remove(quotation);
    print(_supplierQuotation);
    notifyListeners();
  }

  SupplierQuotation getSelectedQ() {
    if (selectdQIndex < _supplierQuotation.length) {
      return _supplierQuotation[_selectedQIndex];
    } else
      return null;
  }

  getNextQ() {
    if (selectdQIndex < _supplierQuotation.length) {
      _selectedQIndex++;
    } else {
      _completed = true;
    }
    notifyListeners();
  }

  finish() {
    _selectedQIndex = 0;
    _supplierQuotation.clear();
  }
}
