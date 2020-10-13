import 'package:construction_procurement_app/Models/Product.dart';

class Requisition {
  String reqNo;
  String date;
  double totPrice;
  List<Product> products;
  // final double qty;
  String location;

  Requisition(
      {this.reqNo, this.date, this.products, this.totPrice, this.location});

  Map<String, dynamic> toMap() {
    return {
      'reqNo': reqNo,
      'date': date,
      'total': totPrice,
      'products': products.map((i) => i.toMap()).toList(),
      'location': location
    };
  }

  Requisition.fromFirestore(Map<String, dynamic> firestore)
      : reqNo = firestore['reqNo'],
        date = firestore['date'],
        products = firestore['products'],
        location = firestore['location'],
        totPrice = firestore['total'];
}
