import 'package:construction_procurement_app/Models/Product.dart';

import 'Requistion.dart';
import 'Supplier.dart';

class SupplierQuotation {
  String details;
  Supplier supplier;
  Product product;
  Requisition requisition;

  SupplierQuotation(
      this.details, this.product, this.requisition, this.supplier);

  SupplierQuotation.fromFirestore(Map<String, dynamic> firestore)
      : details = firestore['details'],
        //supplier.suplierName = firestore['supplier'],
        product = firestore['product'].desc,
        requisition = firestore['requisition'];
}
