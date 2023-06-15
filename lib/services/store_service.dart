import 'package:tungleua/models/product.dart';
import 'package:tungleua/services/api.dart';
import 'package:tungleua/models/store.dart';

class StoreService {
  Future<Store?> getStoreByUserId(String uid) async {
    final response = await Api().dio.get("/stores/find-by-id/$uid");
    if (response.statusCode != 200) return null;
    final store = Store.fromJSON(response.data);
    return store;
  }

  Future<bool> updateStoreByStoreId(String storeId, Object updates) async {
    final response =
        await Api().dio.put("/stores/update/$storeId", data: updates);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<Product>?> getProductsFromStoreId(String storeId) async {
    final response = await Api().dio.get("/products/find-many-by-id/$storeId");
    if (response.statusCode != 200) {
      return null;
    }
    final data = response.data as Map<String, dynamic>;
    final rawProducts = data['products'] as List<dynamic>;
    final products = rawProducts
        .map((product) => Product.fromJSON(product as Map<String, dynamic>))
        .toList();

    return products;
  }

  Future<List<String>?> getStoreProductImages(String storeId) async {
    final response = await Api().dio.get("/products/images/$storeId");
    if (response.statusCode != 200) {
      return null;
    }
    final responseJSON = response.data as Map<String, dynamic>;
    final rawData = responseJSON['images'] as List<dynamic>;
    final images = rawData.map((data) => data as String).toList();
    return images;
  }
}
