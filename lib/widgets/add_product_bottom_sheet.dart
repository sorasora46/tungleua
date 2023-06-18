import 'package:flutter/material.dart';
import 'package:tungleua/models/product.dart';
import 'package:tungleua/styles/button_style.dart';

class AddProductBottomSheet extends StatefulWidget {
  const AddProductBottomSheet({Key? key, required this.product})
      : super(key: key);
  final Product? product;

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  int amount = 1;

  void handleIncrease() {
    setState(() {
      if (amount < widget.product!.amount) amount++;
    });
  }

  void handleDecrease() {
    setState(() {
      if (amount > 1) amount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.product == null
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: handleDecrease,
                      icon: const Icon(Icons.remove)),
                  const SizedBox(width: 10),
                  Text(amount.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: handleIncrease, icon: const Icon(Icons.add)),
                  const SizedBox(width: 20),
                  FilledButton(
                    style: filledButton,
                    child: Text('Add to Cart  ฿${widget.product!.price}'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
  }
}
