import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tungleua/models/product.dart';
import 'package:tungleua/styles/button_style.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int amount = 1;

  void handleIncrease() {
    setState(() {
      if (amount < widget.product.amount) amount++;
    });
  }

  void handleDecrease() {
    setState(() {
      if (amount > 1) amount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: 110,
        child: Row(
          children: <Widget>[
            // Product Title + Detail
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.product.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    onPressed: handleDecrease,
                                    icon: const Icon(Icons.remove)),
                                const SizedBox(width: 10),
                                Text(amount.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 10),
                                IconButton(
                                    onPressed: handleIncrease,
                                    icon: const Icon(Icons.add)),
                              ],
                            )
                          ]),
                      Text('฿ ${widget.product.price}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ]),
              ),
            ),

            // Product Image
            // AspectRatio(
            //   aspectRatio: 1.1,
            //   child: Image.memory(
            //     base64Decode(widget.product.image),
            //     fit: BoxFit.fill,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
