import 'package:construction_procurement_app/Models/Product.dart';

class Requisition {
  String reqNo;
  String date;
  double totPrice;
  List<Product> products;
  // final double qty;
  // final String location;

  Requisition({this.reqNo, this.date,this.products});

  Map<String, dynamic> toMap() {
    return {
      'reqNo': reqNo,
      'date': date,
      'products': products.map((i) => i.toMap()).toList(),  
    };
  }

  Requisition.fromFirestore(Map<String, dynamic> firestore)
      : reqNo = firestore['reqNo'],
        date = firestore['date'],
        products = firestore['products'];
}
