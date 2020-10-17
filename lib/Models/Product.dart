class Product {
  String desc;
  double price;
  double qty;
  String code;
  double discount;
  // final String location;

  Product({this.qty, this.price, this.desc,this.code,this.discount});

  Map<String, dynamic> toMap() {
    return {'desc': desc, 'qty': qty, 'price': price,'code':code};
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : desc = firestore['name'] ?? 'N/A',
        price = firestore['price'] ?? 'N/A',
        qty = firestore['qty'] ?? 'N/A';
}
