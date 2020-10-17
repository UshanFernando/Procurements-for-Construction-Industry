import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrder.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Services/FirestoreService.dart';
import 'package:flutter/material.dart';

class DeliveryManagerProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  List<Product> _deliveryItems = List();
  double _qty;
  double _allQty;
  String _desc;
  String _reqNo;
  String _imageUrl;
  bool _isButtonDisabled = true;

  List<Product> get deliveryItems => _deliveryItems;
  double get qty => _qty;
  double get allQty => _allQty;
  String get desc => _desc;
  String get reqNo => _reqNo;
  String get imageUrl => _imageUrl;
  bool get isButtonDisable => _isButtonDisabled;

  changeDescription(String value) {
    _desc = value;
  }

  changeQty(String value) {
    _qty = double.parse(value);
  }

  changeAllQty(String value) {
    _allQty = double.parse(value);
  }

  changeReqNo(String value) {
    _reqNo = value;
  }

  changeImageUrl(String value) {
    _imageUrl = value;
    print(_imageUrl);
  }

  changeButtonDisable(bool value) {
    _isButtonDisabled = value;
    notifyListeners();
  }

  saveDeliveryItems() {
    // if (_reqNo != null) {
    //   var newReq = Requisition(reqNo: reqNo, date: date);
    //   firestoreService.saveRequsition(newReq);
    //   print(newReq);
    // }
    // } else {
    //   //Update
    //   var updatedProduct =
    //       Product(name: name, price: _price, productId: _productId);
    //   firestoreService.saveProduct(updatedProduct);
    // }

    deliveryItems.add(new Product(qty: qty, desc: desc));
    print(_deliveryItems);
    notifyListeners();
  }

  bool deliveryReconciliation(pOders) {
    int i = 0;
    List<Product> _deliveryI = _deliveryItems;
    List<PurchaseOrder> poi = pOders.where((n) => n.reqNo == _reqNo).toList();
    PurchaseOrder poivar = poi[0];
    for (var item in poivar.poItems) {
      for (var item1 in _deliveryI) {
        if (item.quotation.product.desc == item1.desc) {
          if (item.quotation.product.qty == item1.qty) {
            i++;
          }
        }
      }
    }
    if (i == poivar.poItems.length) {
      return true;
    } else {
      return false;
    }
    print(poi);
    //List<Requisition> Reqs =
    //firestoreService.getRequsitions();
    // deliveryItems.add(new Product(qty: qty, desc: desc));
    // print(_deliveryItems);
    // notifyListeners();
  }

  removeDeliveryItems(Product prd) {
    deliveryItems.remove(prd);
    print(_deliveryItems);
    notifyListeners();
  }
}
