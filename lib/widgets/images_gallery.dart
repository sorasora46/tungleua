import 'package:flutter/material.dart';

class ImagesGallery extends StatelessWidget {
  const ImagesGallery({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  final shopPic =
      'https://scontent.fbkk5-5.fna.fbcdn.net/v/t39.30808-6/240585651_972435579980123_8072977601646520572_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_eui2=AeFX_8K7-vKC5SlN1CIzX3o1YjiUm-tYyBFiOJSb61jIEUlPRTmC-8U4KFYqVxBEc5BpybJcgdnaLje_ngBUdcHo&_nc_ohc=A0upwk9UygEAX-MWT_L&_nc_ht=scontent.fbkk5-5.fna&oh=00_AfAyd3GTlDufsbsQOdb_eEufqZ0OCNCH_8wAB6nR4ZMN0g&oe=648242C5';

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
