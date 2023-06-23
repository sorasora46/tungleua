class AppUser {
  final String id;
  final String email;
  final String name;
  final String phone;
  final bool isShop;
  final String? image;
  final double balance;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.isShop,
    this.image,
    required this.balance,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'is_shop': isShop,
      'image': image,
    };
  }

  factory AppUser.fromJSON(Map<String, dynamic> json) {
    final balanceJson = json['balance'];
    final castedBalance = balanceJson.runtimeType.toString() == 'int'
        ? (balanceJson as int).toDouble()
        : balanceJson as double;

    return AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      isShop: json['is_shop'] as bool,
      image: json['image'] as String,
      balance: castedBalance,
    );
  }

  @override
  String toString() {
    return 'AppUser{id: $id, email: $email, name: $name, phone: $phone, isShop: $isShop, image: $image}';
  }
}
