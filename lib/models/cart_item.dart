class CartItem {
  final String userId;
  final String productId;
  final int amount;
  final String title;
  final int price;
  final String image;

  CartItem({
    required this.userId,
    required this.productId,
    required this.amount,
    required this.title,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toJSON() {
    return {
      'user_id': userId,
      'product_id': productId,
      'amount': amount,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  factory CartItem.fromJSON(Map<String, dynamic> json) {
    return CartItem(
      userId: json['user_id'] as String,
      productId: json['product_id'] as String,
      amount: json['amount'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
    );
  }
}
