class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String storeId;
  final String image;
  final int amount;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.storeId,
    required this.image,
    required this.amount,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'store_id': storeId,
      'image': image,
      'amount': amount,
    };
  }

  factory Product.fromJSON(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as double,
      storeId: json['store_id'] as String,
      image: json['image'] as String,
      amount: json['amount'] as int,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, description: $description, '
        'price: $price, storeId: $storeId, image: $image, amount: $amount}';
  }
}
