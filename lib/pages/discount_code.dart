import 'package:flutter/material.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/widgets/coupon_card.dart';

class DiscountCode extends StatefulWidget {
  const DiscountCode({Key? key}) : super(key: key);

  @override
  State<DiscountCode> createState() => _DiscountCodeState();
}

class _DiscountCodeState extends State<DiscountCode> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Select Code'), centerTitle: true),
        body: Column(children: <Widget>[
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Column(children: <Widget>[
                  CouponCard(),
                  CouponCard(),
                  CouponCard(),
                  CouponCard(),
                  CouponCard(),
                  CouponCard(),
                ]),
              ),
            ),
          ),

          // Confirm Button
          Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(
                      vertical: BorderSide.none,
                      horizontal:
                          BorderSide(width: 1, color: Colors.grey.shade300))),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: FilledButton(
                      onPressed: () {},
                      style: filledButton,
                      child: const Text('Confirm'),
                    ))
                  ]))),
        ]),
      ),
    );
  }
}
