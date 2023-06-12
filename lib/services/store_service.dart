import 'package:tungleua/services/api.dart';
import 'package:tungleua/models/store.dart';

class StoreService {
  Future<Store?> getStoreByUserId(String uid) async {
    final response = await Api().dio.get("/stores/find-by-id/$uid");
    if (response.statusCode != 200) return null;
    final store = Store.fromJSON(response.data);
    return store;
  }

  Future<bool?> updateStoreByStoreId(String storeId, Object updates) async {
    final response =
        await Api().dio.put("/stores/update/$storeId", data: updates);
    if (response.statusCode == 200) {
      return response.data == 'success';
    }
    return null;
  }
}
