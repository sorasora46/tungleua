import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tungleua/services/store_service.dart';
import 'package:tungleua/widgets/rounded_image.dart';

class ImagesGallery extends StatefulWidget {
  const ImagesGallery({Key? key, required this.storeId}) : super(key: key);
  final String storeId;

  @override
  State<ImagesGallery> createState() => _ImagesGalleryState();
}

class _ImagesGalleryState extends State<ImagesGallery> {
  List<String>? images;

  @override
  void initState() {
    super.initState();
    StoreService()
        .getStoreProductImages(widget.storeId)
        .then((images) => setState(() {
              this.images = images;
            }));
  }

  @override
  Widget build(BuildContext context) {
    if (images != null) {
      return Row(
        children: images!
            .map((image) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RoundedImage(image: base64Decode(image)),
                ))
            .toList(),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
