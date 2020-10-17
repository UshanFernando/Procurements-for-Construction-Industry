import 'package:construction_procurement_app/Models/Product.dart';

import 'Requistion.dart';
import 'Supplier.dart';

class SupplierQuotation {
  String details;
  Supplier supplier;
  Product product;
  Requisition requisition;

  SupplierQuotation(
      {this.details, this.product, this.requisition, this.supplier});

  Map<String, dynamic> toMap() {
    return {
      'details': details,
      'supplier': supplier.toMap(),
      'product': product.toMap(),
      'requisition': requisition.toMap()
    };
  }

  SupplierQuotation.fromFirestore(Map<String, dynamic> firestore)
      : details = firestore['details'],
        supplier = Supplier(
            supplierName:
                firestore['supplier']['supplierName'].toString() ?? 'N/A',
            supplierTerm:
                firestore['supplier']['supplierTerm'].toString() ?? 'N/A',
            phoneNo: firestore['supplier']['phoneNo'].toString() ?? 'N/A',
            email: firestore['supplier']['email'].toString() ?? 'N/A'),
        product = Product(
          desc: firestore['product']['desc'].toString() ?? 'N/A',
          price: double.parse(firestore['product']['price'].toString()) ?? 0,
          qty: double.parse(firestore['product']['qty'].toString()) ?? 0,
          discount:
              double.parse(firestore['product']['discount'].toString()) ?? 0,
          code: firestore['product']['code'].toString() ?? 'N/A',
        ),
        requisition = Requisition(
          reqNo: firestore['requisition']['reqNo'].toString(),
          location: firestore['requisition']['location'].toString(),
        );
}
