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

  Future<bool> updateProductById(String productId, Object updates) async {
    final response =
        await Api().dio.put("/products/update/$productId", data: updates);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deleteProductById(String productId) async {
    final response = await Api().dio.delete("/products/delete/$productId");
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
