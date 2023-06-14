import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tungleua/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: 100,
        child: Row(
          children: <Widget>[
            // Product Title + Detail
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(product.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 8),
                            Text(product.description,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300))
                          ]),
                      Text('฿ ${product.price}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500))
                    ]),
              ),
            ),

            // Product Image
            AspectRatio(
              aspectRatio: 1.1,
              child: Image.memory(
                base64Decode(product.image),
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }
}
