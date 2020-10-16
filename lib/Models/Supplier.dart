class Supplier {
  String supplierName;
  String supplierTerm;
  String phoneNo;
  String email;

  Supplier({
    this.supplierName,
    this.supplierTerm,
    this.phoneNo,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'supplierName': supplierName,
      'supplierTerm': supplierTerm,
      'phoneNo': phoneNo,
      'email': email
    };
  }

  // Supplier.fromFirestore(Map<String, dynamic> firestore)
  //     : supplierName = firestore['supplierName'] ?? 'N/A';
}
