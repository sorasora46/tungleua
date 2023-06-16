import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/models/store.dart';
import 'package:tungleua/pages/shop_detail.dart';
import 'package:tungleua/services/store_service.dart';
import 'package:tungleua/widgets/images_gallery.dart';

class ShopBottomSheet extends StatefulWidget {
  const ShopBottomSheet({Key? key, required this.storeId}) : super(key: key);
  final String storeId;

  @override
  State<ShopBottomSheet> createState() => _ShopBottomSheetState();
}

class _ShopBottomSheetState extends State<ShopBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
            future: StoreService().getStoreById(widget.storeId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final Store store = snapshot.data!;

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 25),

                      // Shop Name
                      // TODO: Handle Authorization (Shop's Owner, Shop's Customer)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShopDetail(store: store)));
                        },
                        child: Text(
                          store.name,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Shop open - close
                      Text(
                        '${store.timeOpen} - ${store.timeClose}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Shop Address (Description)
                      Text(
                        store.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Pictures of shop's products
                      // TODO: Handle render product images
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ImagesGallery(storeId: store.id),
                        ),
                      )
                    ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
