import 'package:construction_procurement_app/Models/Product.dart';
import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:intl/intl.dart';

class PurchaseOrder {
  String reqNo;
  String date;
  double totPrice;
  List<PurchaseOrderItem> poItems;

  PurchaseOrder({this.reqNo, this.date, this.poItems, this.totPrice});

  Map<String, dynamic> toMap() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return {
      'reqNo': reqNo,
      'date': formatted,
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
