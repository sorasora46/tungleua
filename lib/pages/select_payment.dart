import 'dart:async';
import 'dart:convert';

import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tungleua/pages/product_cart.dart';
import 'package:tungleua/services/cart_service.dart';

import 'package:tungleua/services/payment_service.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class SelectPayment extends StatefulWidget {
  const SelectPayment({Key? key}) : super(key: key);

  @override
  State<SelectPayment> createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  List<String> listTitles = [
    'QR PromptPay',
    'TungleuaPay',
  ];

  String selectPayment = '';
  String Qr = 'QR PromptPay';
  void selectList(String check) {
    setState(() {
      selectPayment = check;
      if (selectPayment == 'QR PromptPay') {
        displayImageModal(context, userId);
      } else if (selectPayment == 'TungleuaPay') {
        checkMoney(context, userId);
      }
      print(selectPayment);
    });
  }

  void checkMoney(BuildContext context, String userId) async {
    try {
      String? result = await PaymentService().payByWallet(userId);
      if (result != null) {
        Map<String, dynamic> jsonData = jsonDecode(result);

        // Access the data in the jsonData map using the correct keys
        String? message = jsonData['message'];
        String? balance = jsonData['Balance'];
        String? image = jsonData['image'];

        // Perform actions with the extracted data
        if (message == "Payment was success") {
          print('Payment was successful');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$message : $balance")),
          );
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => ProductCart()),
          );
          CartService().deleteAllItemFromCart(userId);
        } else {
          print('Payment was fail');
          displayImageModal2(context, image!, balance!);
        }
      } else {
        print('Payment failed');
      }
    } catch (e) {
      print(e);
    }
  }

  void displayImageModal2(
      BuildContext context, String image, String balance) async {
    try {
      Uint8List imgConvert = const Base64Decoder().convert(image);

      // Create a Uint8List from the bytes

      Future<void> saveImageToDevice(Uint8List imageData) async {
        final result = await ImageGallerySaver.saveImage(imageData);
        if (result['isSuccess']) {
          // Image saved successfully
          String savedFilePath = result['filePath'];

          print('Image saved at: $savedFilePath');
        } else {
          // Error saving image
          print('Failed to save image.');
        }
      }

      // Replace with your image data

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please top up: $balance',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Image.memory(imgConvert),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // await CartService().deleteAllItemFromCart(userId);
                  await saveImageToDevice(imgConvert);
                  Navigator.pop(context);
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => ProductCart()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Your already save the QrCode')),
                  );
                },
                child: const Text('Save QrCode'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error: $error');
      // Handle the error case
      // ...
    }
  }

  void displayImageModal(BuildContext context, String userId) async {
    try {
      String? image = await PaymentService().sentInfo(userId);

      Uint8List imgConvert = const Base64Decoder().convert(image!);

      // Create a Uint8List from the bytes

      Future<void> saveImageToDevice(Uint8List imageData) async {
        final result = await ImageGallerySaver.saveImage(imageData);
        if (result['isSuccess']) {
          // Image saved successfully
          String savedFilePath = result['filePath'];

          print('Image saved at: $savedFilePath');
        } else {
          // Error saving image
          print('Failed to save image.');
        }
      }

      // Replace with your image data

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(imgConvert),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  // await CartService().deleteAllItemFromCart(userId);
                  await saveImageToDevice(imgConvert);
                  Navigator.pop(context);
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => ProductCart()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Your already save the QrCode')),
                  );
                },
                child: const Text('Save QrCode'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error: $error');
      // Handle the error case
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Method'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: listTitles.length,
          itemBuilder: (context, index) {
            final check = listTitles[index];
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Card(
                child: ListTile(
                  title: Text(check,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  onTap: () {
                    selectList(check);
                  },
                  trailing: selectPayment == check
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: (Colors.green),
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
