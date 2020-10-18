import 'package:construction_procurement_app/Models/Product.dart';

class Requisition {
  String reqNo;
  String date;
  double totPrice;
  String status;
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
      if(products!= null)
      'products': products.map((i) => i.toMap()).toList(),
      'location': location,
      'status':'Pending'
    };
  }

  Requisition.fromFirestore(Map<String, dynamic> firestore)
      : reqNo = firestore['reqNo'] ?? 'N/A',
        date = firestore['date'] ?? 'N/A',
        status = firestore['status'] ?? 'Pending',
        location = firestore['location'] ?? 'N/A',
        totPrice = double.parse(firestore['total'].toString()) ?? 0;
}
