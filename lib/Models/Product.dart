class Product {
  final String desc;
  final double price;
  final double qty;
  // final String location;

  Product({this.qty, this.price, this.desc});

  Map<String, dynamic> toMap() {
    return {'desc': desc, 'qty': qty, 'price': price};
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : desc = firestore['name'],
        price = firestore['price'],
        qty = firestore['qty'];
}
