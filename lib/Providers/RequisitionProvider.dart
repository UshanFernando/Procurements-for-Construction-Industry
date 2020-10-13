import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Services/FirestoreService.dart';
import 'package:flutter/material.dart';

class RequisitionProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _date;
  String _reqNo;
  List<Product> _products = List();
  //product
  double _qty;
  double _total = 0;
  String _desc;
  double _price;
  String _location;

  //Getters
  String get date => _date;
  String get reqNo => _reqNo;
  List<Product> get products => _products;

  double get qty => _qty;
  double get total => _total;
  String get desc => _desc;
  double get price => _price;
  String get location => _location;

  //Setters

  changeReqNo(String value) {
    _reqNo = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _desc = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  changeDate(String value) {
    _date = value;
    notifyListeners();
  }

  changeLocation(String value) {
    _location = value;
    notifyListeners();
  }

  changeQty(String value) {
    _qty = double.parse(value);
    notifyListeners();
  }

  calcToatal() {
    _total = 0;
    for (Product p in products) {
      _total = _total + (p.price * p.qty);
    }
    notifyListeners();
  }

  // loadValues(Product product) {
  //   _desc = product.desc;
  //   _price = product.price;
  //   _reqNo = product.reqNo;
  // }

  loadValues(Requisition requisition) {
    _date = requisition.date;
    _reqNo = requisition.reqNo;
  }

  saveProduct() {
    print(_reqNo);
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

    products.add(new Product(qty: qty, desc: desc, price: price));
    print(_products);
  }

  sendRequsition() {
    firestoreService.saveRequsition(Requisition(
        reqNo: reqNo,
        date: date,
        products: products,
        totPrice: total,
        location: location));
    print(reqNo);
    _reqNo = null;
    _date = null;
    _qty = null;

    _desc = null;
    _price = null;
    _location = null;
    _total = 0;

    _products.clear();
  }
  // removeProduct(String productId) {
  //   firestoreService.removeProduct(productId);
  // }
}
