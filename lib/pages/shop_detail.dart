import 'package:flutter/material.dart';
import 'package:tungleua/pages/create_product.dart';

// TODO: Fetch data for Shop Detail
// TODO: Render page based on role of user (Customer, Shop's owner)
class ShopDetail extends StatefulWidget {
  const ShopDetail({Key? key}) : super(key: key);

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  final shopPic =
      'https://scontent.fbkk5-5.fna.fbcdn.net/v/t39.30808-6/240585651_972435579980123_8072977601646520572_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=e3f864&_nc_eui2=AeFX_8K7-vKC5SlN1CIzX3o1YjiUm-tYyBFiOJSb61jIEUlPRTmC-8U4KFYqVxBEc5BpybJcgdnaLje_ngBUdcHo&_nc_ohc=A0upwk9UygEAX-MWT_L&_nc_ht=scontent.fbkk5-5.fna&oh=00_AfAyd3GTlDufsbsQOdb_eEufqZ0OCNCH_8wAB6nR4ZMN0g&oe=648242C5';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      // TODO: Create rounded top border
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Shop's picture
            SizedBox(
                height: 225,
                width: double.infinity,
                child: Image.network(shopPic, fit: BoxFit.cover)),

            const SizedBox(height: 20),

            // Shop Name
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'John Doe Coffee Shop',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Shop Address
            const ListTile(
              leading: Icon(Icons.location_on_outlined),
              iconColor: Colors.black,
              title: Text(
                  '115/1 115/2 Pracha Uthit Rd, Bang Mot, Thung Khru, Bangkok 10140'),
            ),

            const Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),

            // Shop open - close
            const ListTile(
              leading: Icon(Icons.watch_later_outlined),
              iconColor: Colors.black,
              title: Text('7:00 AM - 8:00 PM'),
            ),

            const Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),

            // Shop contact
            const ListTile(
              leading: Icon(Icons.language),
              iconColor: Colors.black,
              title: Text('www.facebook.com'),
            ),

            const Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                'Our Products',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Add Product Button
            // TODO: Handle Create Product
            Center(
                child: MaterialButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateProduct()))
                    .then((_) => setState(() {}));
              },
              color: Colors.grey,
              textColor: Colors.black,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                size: 24,
              ),
            )),

            const SizedBox(height: 10),

            // List of Products
            Expanded(
              child: ListView(
                  // https://stackoverflow.com/questions/67555582/flutter-listview-has-gap-at-beginning
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  // TODO: Create Card for Product
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Test'),
                    ),
                    ListTile(
                      leading: Icon(Icons.access_alarm),
                      title: Text('Test'),
                    ),
                  ]),
            ),
          ]),
    );
  }
}
