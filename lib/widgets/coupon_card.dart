import 'package:flutter/material.dart';
import 'package:tungleua/models/coupon.dart';

class CouponCard extends StatefulWidget {
  const CouponCard(
      {Key? key, required this.coupon, required this.handleSelectCoupon})
      : super(key: key);
  final Coupon coupon;
  final Function(Coupon) handleSelectCoupon;

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.handleSelectCoupon(widget.coupon);
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          height: 80,
          child: Row(children: <Widget>[
            // Product Title + Detail
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                  '${widget.coupon.title} : ${widget.coupon.discount * 100}%',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            const SizedBox(height: 8),
                            Flexible(
                              child: Text(
                                  'use before: ${widget.coupon.expireAt}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ]),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isSelected = !isSelected;
                            widget.handleSelectCoupon(widget.coupon);
                          });
                        },
                        icon: Icon(isSelected
                            ? Icons.radio_button_on
                            : Icons.radio_button_off))
                  ]),
            ))
          ]),
        ),
      ),
    );
  }
}
