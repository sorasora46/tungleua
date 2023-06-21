class Coupon {
  final String id;
  final String title;
  final double discount;
  final DateTime expireAt;

  Coupon({
    required this.id,
    required this.title,
    required this.discount,
    required this.expireAt,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'discount': discount,
      'expireAt': expireAt.toIso8601String(),
    };
  }

  factory Coupon.fromJSON(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as String,
      title: json['title'] as String,
      discount: json['discount'] as double,
      expireAt: DateTime.parse(json['expire_at'] as String),
    );
  }

  @override
  String toString() {
    return 'Coupon{id: $id, title: $title, discount: $discount, expireAt: $expireAt}';
  }
}
