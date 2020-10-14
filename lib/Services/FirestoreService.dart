import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_procurement_app/Models/Requistion.dart';
import 'package:construction_procurement_app/Models/SupplierQuotation.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  // Future<void> saveProduct(Product product){
  //   return _db.collection('products').document(product.reqNo).setData(product.toMap());
  // }

  Future<void> saveRequsition(Requisition requisition) {
    return _db
        .collection('requisitions')
        .document(requisition.reqNo)
        .setData(requisition.toMap());
  }

  Stream<List<Requisition>> getRequsitions() {
    return _db.collection('requisitions').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Requisition.fromFirestore(document.data))
        .toList());
  }

  Stream<List<SupplierQuotation>> getSupplierQuatations() {
    var object = _db.collection('supplierQuotation').snapshots().map(
        (snapshot) => snapshot.documents
            .map((document) => SupplierQuotation.fromFirestore(document.data))
            .toList());
    debugPrint(object.toString());
    return object;
  }
  // Future<void> removeProduct(String productId){
  //   return _db.collection('products').document(productId).delete();
  // }

}
