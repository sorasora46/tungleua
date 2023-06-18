import 'package:tungleua/models/product.dart';
import 'package:tungleua/models/responses/populate_map.dart';
import 'package:tungleua/services/api.dart';
import 'package:tungleua/models/store.dart';

class StoreService {
  Future<Store?> getStoreById(String uid) async {
    final response = await Api().dio.get("/stores/find-by-id/$uid");
    if (response.statusCode != 200) return null;
    final store = Store.fromJSON(response.data);
    return store;
  }

  Future<Store?> getStoreUserById(String uid) async {
    final response = await Api().dio.get("/stores/find-by-user/$uid");
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

  Future<List<PopulateMapResponse>?> populateMap(
      double latitude, double longitude) async {
    final response = await Api().dio.get(
        "/stores/populate?offset=1&center_lat=$latitude&center_long=$longitude");
    if (response.statusCode != 200) {
      return null;
    }
    final data = response.data['stores'] as List<dynamic>;
    final stores = data
        .map((store) =>
            PopulateMapResponse.fromJSON((store as Map<String, dynamic>)))
        .toList();

    return stores;
  }
}
