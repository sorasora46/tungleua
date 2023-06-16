import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
      // register with firebase
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // register with our server
      final response = await Api().dio.post('/users/', data: {
        'id': userCredential.user?.uid,
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'is_shop': false,
      });

      if (response.statusCode == 200) {
        return userCredential;
      } else {
        debugPrint(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
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
        // debugPrint(await auth.currentUser?.getIdToken());
        return userCred;
      } else {
        debugPrint(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
