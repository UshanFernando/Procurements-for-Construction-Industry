import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';

class PurchaseOrder {
  String reqNo;
  String date;
  double totPrice;
  List<PurchaseOrderItem> poItems;

  PurchaseOrder({this.reqNo, this.date, this.poItems, this.totPrice});

  Map<String, dynamic> toMap() {
    return {
      'reqNo': reqNo,
      'date': date,
      'total': totPrice,
      'poItems': poItems.map((i) => i.toMap()).toList(),
    };
  }

  // PurchaseOrder.fromFirestore(Map<String, dynamic> firestore)
  //     : reqNo = firestore['reqNo'] ?? 'N/A',
  //       date = firestore['date'] ?? 'N/A',
  //       status = firestore['status'] ?? 'Pending',
  //       location = firestore['location'] ?? 'N/A',
  //       totPrice = double.parse(firestore['total'].toString()) ?? 0;
}
