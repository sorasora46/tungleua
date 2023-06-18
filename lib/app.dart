import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/pages/login.dart';
import 'package:tungleua/widgets/navigation/bottom_navbar.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BottomNavbar();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
