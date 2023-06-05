// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

// TODO: Take Shop or Shop detail as argument for render bottom sheet
class ShopBottomSheet extends StatelessWidget {
  const ShopBottomSheet({Key? key}) : super(key: key);

  final shopPic =
      'https://scontent.fbkk5-5.fna.fbcdn.net/v/t39.30808-6/240585651_972435579980123_8072977601646520572_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_eui2=AeFX_8K7-vKC5SlN1CIzX3o1YjiUm-tYyBFiOJSb61jIEUlPRTmC-8U4KFYqVxBEc5BpybJcgdnaLje_ngBUdcHo&_nc_ohc=A0upwk9UygEAX-MWT_L&_nc_ht=scontent.fbkk5-5.fna&oh=00_AfAyd3GTlDufsbsQOdb_eEufqZ0OCNCH_8wAB6nR4ZMN0g&oe=648242C5';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25),

              // Shop Name
              const Text(
                'John Doe Coffee Shop',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              // Shop open - close
              const Text(
                'Open 7:00 AM - 8:00 PM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 10),

              // Shop Address
              const Text(
                '115/1 115/2 Pracha Uthit Rd, Bang Mot, Thung Khru, Bangkok 10140',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 20),

              // Shop's pictures (Gallery? wtf?)
              Center(
                child: Row(children: <Widget>[
                  SizedBox(
                    height: 150,
                    width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(shopPic, fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 10),
                  Column(children: <Widget>[
                    SizedBox(
                      height: 70,
                      width: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(shopPic, fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 70,
                      width: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(shopPic, fit: BoxFit.cover)),
                    ),
                  ]),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 150,
                    width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(shopPic, fit: BoxFit.cover)),
                  ),
                ]),
              )
            ]),
      ),
    );
  }
}
