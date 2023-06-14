import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tungleua/models/product.dart';
import 'package:tungleua/models/store.dart';
import 'package:tungleua/pages/create_product.dart';
import 'package:tungleua/services/store_service.dart';
import 'package:tungleua/widgets/product_card.dart';

// TODO: Render page based on role of user (Customer, Shop's owner)
class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key, required this.store}) : super(key: key);
  final Store? store;

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    if (widget.store != null) {
      StoreService()
          .getProductsFromStoreId(widget.store!.id)
          .then((products) => setState(() {
                if (products != null) {
                  this.products = products;
                }
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          surfaceTintColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          backgroundColor: const Color(0x44000000),
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: <Widget>[
            // TODO: Implement Option menu
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ]),
      // TODO: Create rounded top border
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Shop's picture
            SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.memory(base64Decode(widget.store!.image),
                    fit: BoxFit.cover)),

            // Shop Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                widget.store!.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Shop Address (Description)
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              iconColor: Colors.black,
              title: Text(widget.store!.description),
            ),

            const Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),

            // Shop open - close
            ListTile(
              leading: const Icon(Icons.watch_later_outlined),
              iconColor: Colors.black,
              title: Text(
                  '${widget.store!.timeOpen} - ${widget.store!.timeClose}'),
            ),

            const Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),

            // Shop contact
            ListTile(
              leading: const Icon(Icons.language),
              iconColor: Colors.black,
              title: Text(widget.store!.contact),
            ),

            const Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),

            const SizedBox(height: 5),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                'Our Products',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Add Product Button
            // TODO: Handle Create Product
            Center(
                child: MaterialButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateProduct(storeId: widget.store!.id)))
                    .then((_) => setState(() {}));
              },
              color: Colors.grey,
              textColor: Colors.black,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                size: 24,
              ),
            )),

            const SizedBox(height: 5),

            // List of Products
            Expanded(
              child: ListView(
                  // https://stackoverflow.com/questions/67555582/flutter-listview-has-gap-at-beginning
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: products
                      .map((product) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 5),
                            child: ProductCard(product: product),
                          ))
                      .toList()),
            ),
          ]),
    );
  }
}
