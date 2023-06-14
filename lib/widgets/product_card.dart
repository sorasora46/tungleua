import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tungleua/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        height: 100,
        child: Row(
          children: <Widget>[
            // Product Title + Detail
            Expanded(
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text(product.title),
                  Text(product.description)
                ]),
                Text(product.price.toString())
              ]),
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
