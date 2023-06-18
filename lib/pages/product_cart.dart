import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/pages/discount_code.dart';
import 'package:tungleua/services/cart_service.dart';
import 'package:tungleua/widgets/cart_item_card.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({Key? key}) : super(key: key);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Cart'),
            centerTitle: true),
        body: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: FutureBuilder(
                    future: CartService().getCartItems(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final list = snapshot.data;
                        return Column(
                            children: list!
                                .map((item) => CartItemCard(cartItem: item))
                                .toList());
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ),

          // Code
          Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide.none,
                      horizontal:
                          BorderSide(width: 1, color: Colors.grey.shade300))),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Code',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DiscountCode())),
                            style: const ButtonStyle(
                                splashFactory: NoSplash.splashFactory),
                            child: const Row(children: [
                              Text('Select Code',
                                  style: TextStyle(fontSize: 14)),
                              Icon(Icons.arrow_forward_ios, size: 12)
                            ]))
                      ]))),

          // Pay
          Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide.none,
                      horizontal:
                          BorderSide(width: 1, color: Colors.grey.shade300))),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text('Total: ฿ ${260}',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        FilledButton(onPressed: () {}, child: const Text('Pay'))
                      ])))
        ]),
      ),
    );
  }
}
