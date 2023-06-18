import 'package:tungleua/services/api.dart';

class CartService {
  Future<void> addItemToCart(
      String userId, String productId, int amount) async {
    await Api().dio.post(
        "/carts/add?user_id=$userId&product_id=$productId&amount=$amount");
  }
}
