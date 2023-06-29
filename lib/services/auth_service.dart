import 'package:firebase_auth/firebase_auth.dart';

import 'package:tungleua/services/api.dart';
import 'package:flutter/material.dart';

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
      String email, String password, BuildContext context) async {
    try {
      final response = await Api()
          .dio
          .post('/auth/login', data: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        final token = response.data['token'];
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // User login successful
        User? user = userCredential.user;

        print('User logged in: ${user?.uid}');

        final userCred = await auth.signInWithCustomToken(token);
        // debugPrint(await auth.currentUser?.getIdToken());
        return userCred;
      } else {
        debugPrint(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'The password is invalid or the user does not have a password.'),
        ),
      );
      return null;
    }
  }
}
