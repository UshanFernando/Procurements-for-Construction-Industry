import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:construction_procurement_app/Models/PurchaseOrder.dart';
import 'package:construction_procurement_app/Services/FirestoreService.dart';
import 'package:flutter/material.dart';

class SupplierProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  List<SupplierQuotation> _supplierQuotationToLoad = List();
  List<SupplierQuotation> _supplierQuotation = List();
  int _selectedQIndex = 0;
  bool _completed = false;
  double _poTotal = -1;

  List<PurchaseOrderItem> _poItems = List();

  //getters
  bool get completedList => _completed;
  int get selectdQIndex => _selectedQIndex;
  double get poTotal => _poTotal;
  List<SupplierQuotation> get supplierQuotations => _supplierQuotation;
  List<SupplierQuotation> get supplierQuotationsOnly =>
      _supplierQuotationToLoad;

  List<PurchaseOrderItem> get poItems => _poItems;

  addSQ(SupplierQuotation quotation) {
    _supplierQuotation.add(quotation);
    print(_supplierQuotation);
  }

  deleteSQ(SupplierQuotation quotation) {
    _supplierQuotation.removeWhere(
        (e) => quotation.toMap().toString() == e.toMap().toString());
    print(_supplierQuotation);
  }

  SupplierQuotation getSelectedQ() {
    if (selectdQIndex < _supplierQuotation.length) {
      return _supplierQuotation[_selectedQIndex];
    } else
      return null;
  }

  addPO(PurchaseOrderItem poi) {
    if (selectdQIndex < _supplierQuotation.length) {
      _poItems.add(poi);
      _selectedQIndex++;
    } else {
      _completed = true;
    }
    notifyListeners();
  }

  calcToatal() {
    _poTotal = 0;
    for (PurchaseOrderItem p in _poItems) {
      _poTotal = _poTotal +
          ((p.quotation.product.price * p.quotation.product.qty) -
              p.quotation.product.discount);
    }
    notifyListeners();
  }

  sendOrder() {
    firestoreService.savePurchaseOrder(PurchaseOrder(
        reqNo: _poItems[0].quotation.requisition.reqNo,
        poItems: poItems,
        totPrice: _poTotal));

    _poTotal = -1;
    _poItems.clear();
  }

  saveDraft() {
    firestoreService.savePurchaseOrderDraft(PurchaseOrder(
        reqNo: _poItems[0].quotation.requisition.reqNo,
        poItems: poItems,
        totPrice: _poTotal));
  }

  finish() {
    _selectedQIndex = 0;
    _supplierQuotation.clear();
  }

  finishPO() {
    _selectedQIndex = 0;
    _supplierQuotation.clear();
    _poTotal = -1;
    _poItems.clear();
  }

  List<PurchaseOrder> getPos() {
    List<PurchaseOrder> list = List();
    // firestoreService.getPurchaseOrders().then((e) => list = e);
    list.map((e) => print("Item Found ${e.totPrice}"));
    return list;
  }

  getSupQ(String req) {
    firestoreService.getSupplierQuatationsOnly(req).listen((event) {
      onData(event);
    });
  }

  void onData(List<SupplierQuotation> event) {
    _supplierQuotationToLoad = event;
  }

  void sortName() {
    _supplierQuotationToLoad.sort(
        (a, b) => a.supplier.supplierName.compareTo(b.supplier.supplierName));
    notifyListeners();
  }

  void sortProduct() {
    _supplierQuotationToLoad
        .sort((a, b) => a.product.desc.compareTo(b.product.desc));
    notifyListeners();
  }
}
