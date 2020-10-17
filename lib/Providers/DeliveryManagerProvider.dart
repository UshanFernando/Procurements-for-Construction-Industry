import 'package:construction_procurement_app/Models/Payment.dart';
import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrder.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderPayments.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Services/FirestoreService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryManagerProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  List<Product> _deliveryItems = List();
  double _qty;
  double _allQty;
  String _desc;
  String _reqNo;
  String _imageUrl;
  double _amount;
  String _paymentID;

  PurchaseOrder _purchaseOrder;
  bool _isButtonDisabled = true;

  List<Product> get deliveryItems => _deliveryItems;
  double get qty => _qty;
  double get allQty => _allQty;
  String get desc => _desc;
  String get reqNo => _reqNo;
  String get imageUrl => _imageUrl;
  double get amount => _amount;
  String get paymentID => _paymentID;
  PurchaseOrder get purchaseOrder => _purchaseOrder;
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

  changeAmount(double value) {
    _amount = value;
  }

  changePaymentID(String value) {
    _paymentID = value;
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
    _purchaseOrder = poi[0];
    for (var item in _purchaseOrder.poItems) {
      for (var item1 in _deliveryI) {
        if (item.quotation.product.desc.toLowerCase() ==
            item1.desc.toLowerCase()) {
          if (item.quotation.product.qty == item1.qty) {
            i++;
          }
        }
      }
    }
    if (i == _purchaseOrder.poItems.length) {
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

  saveToDbDelivery() {
    final now = new DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    firestoreService.savePurchaseOrderPayments(PurchaseOrderPayment(
        po: _purchaseOrder,
        payment: Payment(
          amount: amount,
          paymentID: paymentID,
          invoiceURL: imageUrl,
          paymentDate: formatter,
        )));
    print(reqNo);

    _deliveryItems = List();
    _qty = null;
    _allQty = null;
    _desc = null;
    _reqNo = null;
    _imageUrl = null;
    _isButtonDisabled = null;
  }
}
