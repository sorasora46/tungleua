import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: <Widget>[
              Text('200'),
              Container(
                child: Center(
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.wallet)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
