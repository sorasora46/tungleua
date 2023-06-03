import 'package:flutter/material.dart';
import 'package:tungleua/pages/login.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          // TODO: Remove Text widget, Change to Login Page
          // TODO: Handle user session
          child: const Text('Login Page'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ),
    );
  }
}
