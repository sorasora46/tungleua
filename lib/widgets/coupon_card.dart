import 'package:flutter/material.dart';

class CouponCard extends StatefulWidget {
  const CouponCard({Key? key}) : super(key: key);

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('Discount 10%',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(height: 8),
                        Flexible(
                          child: Text('use before: 07/06/23',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w300)),
                        ),
                      ]),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      icon: Icon(isSelected
                          ? Icons.radio_button_on
                          : Icons.radio_button_off))
                ]),
          ))
        ]),
      ),
    );
  }
}
