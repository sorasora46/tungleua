import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/models/cart_item.dart';
import 'package:tungleua/services/cart_service.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard(
      {Key? key, required this.cartItem, required this.handleTotalPriceChange})
      : super(key: key);
  final CartItem cartItem;
  final Function(int) handleTotalPriceChange;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  int? amount;

  Future<void> handleIncrease() async {
    if (amount != null && amount! < widget.cartItem.maxAmount) {
      setState(() {
        // if (amount < widget.product.amount) amount++;
        amount = amount! + 1;
        widget.handleTotalPriceChange(widget.cartItem.price);
      });
    }
    await CartService()
        .updateItemInCart(userId, widget.cartItem.productId, amount!);
  }

  Future<void> handleDecrease() async {
    if (amount != null) {
      if (amount! > 1) {
        setState(() {
          amount = amount! - 1;
          widget.handleTotalPriceChange(-widget.cartItem.price);
        });
      }
    }
    await CartService()
        .updateItemInCart(userId, widget.cartItem.productId, amount!);
  }

  @override
  void initState() {
    super.initState();
    amount = widget.cartItem.amount;
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
                            Text(widget.cartItem.title,
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
                      Text('฿ ${widget.cartItem.price * amount!}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ]),
              ),
            ),

            // Product Image
            AspectRatio(
              aspectRatio: 0.7,
              child: Image.memory(
                base64Decode(widget.cartItem.image),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
