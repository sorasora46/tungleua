import 'package:flutter/material.dart';
import 'package:tungleua/models/product.dart';
import 'package:tungleua/widgets/cart_item.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({Key? key}) : super(key: key);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Cart'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Column(
                    children: [
                      CartItem(
                          product: Product(
                              id: "id",
                              title: "title",
                              description: "description",
                              price: 20,
                              storeId: "storeId",
                              image: "11114444",
                              amount: 50)),
                      CartItem(
                          product: Product(
                              id: "id",
                              title: "title",
                              description: "description",
                              price: 20,
                              storeId: "storeId",
                              image: "11114444",
                              amount: 50)),
                      CartItem(
                          product: Product(
                              id: "id",
                              title: "title",
                              description: "description",
                              price: 20,
                              storeId: "storeId",
                              image: "11114444",
                              amount: 50)),
                      CartItem(
                          product: Product(
                              id: "id",
                              title: "title",
                              description: "description",
                              price: 20,
                              storeId: "storeId",
                              image: "11114444",
                              amount: 50)),
                      CartItem(
                          product: Product(
                              id: "id",
                              title: "title",
                              description: "description",
                              price: 20,
                              storeId: "storeId",
                              image: "11114444",
                              amount: 50)),
                      CartItem(
                          product: Product(
                              id: "id",
                              title: "title",
                              description: "description",
                              price: 20,
                              storeId: "storeId",
                              image: "11114444",
                              amount: 50)),
                    ],
                  ),
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
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('Select Code', style: TextStyle(fontSize: 14)),
                          Icon(Icons.arrow_forward_ios, size: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
                    FilledButton(onPressed: () {}, child: const Text('Pay')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
