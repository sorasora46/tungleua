import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/models/cart_item.dart';
import 'package:tungleua/models/coupon.dart';
import 'package:tungleua/pages/discount_code.dart';
import 'package:tungleua/pages/select_payment.dart';
import 'package:tungleua/services/cart_service.dart';

import 'package:tungleua/widgets/cart_item_card.dart';

import 'package:tungleua/widgets/show_dialog.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({Key? key}) : super(key: key);

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  List<CartItem>? items;
  double? totalPrice = 0;
  Coupon? selectedCoupon;

  void handleSelectCoupon(Coupon coupon) {
    setState(() {
      selectedCoupon = coupon;
    });
  }

  double calculatePrice() {
    if (totalPrice != null) {
      if (selectedCoupon != null) {
        return totalPrice! - (totalPrice! * selectedCoupon!.discount);
      }
      return totalPrice!;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    CartService().getCartItems(userId).then((items) => setState(() {
          this.items = items;
          for (int i = 0; i < items!.length; i++) {
            totalPrice = totalPrice! + (items[i].price * items[i].amount);
          }
        }));
  }

  void handleTotalPriceChange(double price) {
    setState(() {
      totalPrice = totalPrice! + price;
    });
  }

  Future<void> handleDeleteItem(String userId, String productId) async {
    await CartService().deleteItemFromCart(userId, productId);
    if (mounted) {
      showCustomSnackBar(context, 'Deleted', SnackBarVariant.success);
    }
  }

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
              child: Column(
                children: items == null
                    ? [const Center(child: CircularProgressIndicator())]
                    : items!
                        .map((item) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Dismissible(
                                key: Key(item.productId),
                                direction: DismissDirection.endToStart,
                                onDismissed: (_) =>
                                    handleDeleteItem(userId, item.productId),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  child: const Center(
                                      child: Text('DELETE',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500))),
                                ),
                                child: CartItemCard(
                                    cartItem: item,
                                    handleTotalPriceChange:
                                        handleTotalPriceChange),
                              ),
                            ))
                        .toList(),
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
                        selectedCoupon == null
                            ? TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DiscountCode(
                                            handleSelectCoupon:
                                                handleSelectCoupon))),
                                style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                child: const Row(children: [
                                  Text('Select Code',
                                      style: TextStyle(fontSize: 14)),
                                  Icon(Icons.arrow_forward_ios, size: 12)
                                ]))
                            : TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DiscountCode(
                                            handleSelectCoupon:
                                                handleSelectCoupon))),
                                style: const ButtonStyle(
                                    splashFactory: NoSplash.splashFactory),
                                child: Row(children: [
                                  Text(
                                      'discount ${selectedCoupon!.discount * 100}% (${selectedCoupon!.title})',
                                      style: const TextStyle(fontSize: 14)),
                                  const Icon(Icons.arrow_forward_ios, size: 12)
                                ]))
                      ]))),
          //Payment
          Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide.none,
                      horizontal:
                          BorderSide(width: 2, color: Colors.grey.shade300))),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total: ฿ ${calculatePrice()}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectPayment())),
                            style: const ButtonStyle(
                                splashFactory: NoSplash.splashFactory),
                            child: const Row(children: [
                              Text('Pay', style: TextStyle(fontSize: 14)),
                            ])),
                      ]))),
        ]),
      ),
    );
  }
}
