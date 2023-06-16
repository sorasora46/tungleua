import 'package:tungleua/models/product.dart';
import 'package:tungleua/services/api.dart';

class ProductService {
  Future<Product?> getProductById(String productId) async {
    final response = await Api().dio.get("/products/find-by-id/$productId");
    if (response.statusCode != 200) {
      return null;
    }
    final product = Product.fromJSON(response.data);
    return product;
  }
}
