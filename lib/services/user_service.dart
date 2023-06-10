import 'package:tungleua/models/user.dart';
import 'package:tungleua/services/api.dart';

class UserService {
  Future<AppUser?> getUserById(String uid) async {
    final response = await Api().dio.get('/users/find-by-id/$uid');
    if (response.statusCode != 200) return null;
    final user = AppUser.fromJSON(response.data);
    return user;
  }
}
