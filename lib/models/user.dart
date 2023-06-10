class AppUser {
  final String id;
  final String email;
  final String name;
  final String phone;
  final bool isShop;
  final String? image;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.isShop,
    this.image,
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
    return AppUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      isShop: json['is_shop'],
      image: json['image'],
    );
  }

  @override
  String toString() {
    return 'AppUser{id: $id, email: $email, name: $name, phone: $phone, isShop: $isShop, image: $image}';
  }
}
