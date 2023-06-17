import 'package:flutter/material.dart';
import 'package:tungleua/widgets/product_card.dart';

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
        body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                      const Spacer(),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(border: Border.all()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
