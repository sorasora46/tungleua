import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungleua/services/api.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      // register with our server
      final response = await Api().dio.post('/users', data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'is_shop': false,
      });

      if (response.statusCode == 200) {
        // register with firebase
        return await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await Api()
          .dio
          .post('/auth/login', data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final token = response.data['token'];
        final userCred = await auth.signInWithCustomToken(token);
        print(await auth.currentUser?.getIdToken());
        return userCred;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
