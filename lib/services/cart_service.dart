import 'package:tungleua/models/cart_item.dart';
import 'package:tungleua/services/api.dart';

class CartService {
  Future<void> addItemToCart(
      String userId, String productId, int amount) async {
    await Api().dio.post(
        "/carts/add?user_id=$userId&product_id=$productId&amount=$amount");
  }

  Future<List<CartItem>?> getCartItems(String userId) async {
    final response = await Api().dio.get("/carts/find-by-id/$userId");
    if (response.statusCode != 200) {
      return null;
    }
    final rawData = response.data as Map<String, dynamic>;
    final results = rawData['results'] as List<dynamic>;
    final items = results
        .map((item) => CartItem.fromJSON(item as Map<String, dynamic>))
        .toList();
    return items;
  }

  Future<void> deleteItemFromCart(String userId, String productId) async {
    await Api()
        .dio
        .delete("/carts/delete?user_id=$userId&product_id=$productId");
  }
}
