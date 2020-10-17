import 'package:construction_procurement_app/Models/SupplierQuotation.dart';

class PurchaseOrderItem {
  String diliveryAddress;
  String phone;
  String diliveryDate;
  String requestedBy;
  String department;
  String approvedBy;
  SupplierQuotation quotation;

  PurchaseOrderItem(
      {this.diliveryAddress,
      this.phone,
      this.diliveryDate,
      this.requestedBy,
      this.department,
      this.approvedBy,
      this.quotation});

  Map<String, dynamic> toMap() {
    return {
      'diliveryAddress': diliveryAddress,
      'phone': phone,
      'diliveryDate': diliveryDate,
      'requestedBy': requestedBy,
      'department': department,
      'approvedBy': approvedBy,
      'quotation': quotation.toMap()
    };
  }

  // PurchaseOrderItem.fromFirestore(Map<String, dynamic> firestore)
  //     : reqNo = firestore['reqNo'] ?? 'N/A',
  //       date = firestore['date'] ?? 'N/A',
  //       status = firestore['status'] ?? 'Pending',
  //       location = firestore['location'] ?? 'N/A',
  //       totPrice = double.parse(firestore['total'].toString()) ?? 0;
}
