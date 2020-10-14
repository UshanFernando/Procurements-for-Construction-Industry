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
      : desc = firestore['name']??'N/A',
        price = firestore['price']??'N/A',
        qty = firestore['qty']??'N/A';
}
