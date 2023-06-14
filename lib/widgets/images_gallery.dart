import 'package:flutter/material.dart';

class ImagesGallery extends StatelessWidget {
  const ImagesGallery({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  final shopPic = 'https://placehold.co/600x400';

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
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
    ]);
  }
}
