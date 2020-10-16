import 'package:construction_procurement_app/Models/PurchaseOrderItem.dart';
import 'package:flutter/material.dart';

class PurchaseOrderItemWidget extends StatelessWidget {
  PurchaseOrderItem item;
  PurchaseOrderItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Item NO : #${item.quotation.product.code}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Order Item : ${item.quotation.product.desc}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Quantity : ${item.quotation.product.qty}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Amount : ${(item.quotation.product.price * item.quotation.product.qty)}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Supplier : ${item.quotation.supplier.supplierName}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Dilivery Site : ${item.quotation.requisition.location}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Due Date : ${item.diliveryDate}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
