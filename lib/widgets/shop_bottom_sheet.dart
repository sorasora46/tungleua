import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/models/store.dart';
import 'package:tungleua/pages/shop_detail.dart';
import 'package:tungleua/services/store_service.dart';
import 'package:tungleua/widgets/images_gallery.dart';

class ShopBottomSheet extends StatefulWidget {
  const ShopBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShopBottomSheet> createState() => _ShopBottomSheetState();
}

class _ShopBottomSheetState extends State<ShopBottomSheet> {
  Store? store;

  @override
  void initState() {
    super.initState();
    StoreService()
        .getStoreByUserId(FirebaseAuth.instance.currentUser!.uid)
        .then((store) => setState(() {
              this.store = store;
            }));
  }

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
              // TODO: Handle Authorization (Shop's Owner, Shop's Customer)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopDetail(store: store)));
                },
                child: Text(
                  store?.name ?? "",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Shop open - close
              Text(
                '${store?.timeOpen ?? ""} - ${store?.timeClose ?? ""}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 10),

              // Shop Address (Description)
              Text(
                store?.description ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 20),

              // Pictures of shop's products
              // TODO: Handle render product images
              // TODO: Handle create product
              const Center(
                child: ImagesGallery(images: []),
              )
            ]),
      ),
    );
  }
}
