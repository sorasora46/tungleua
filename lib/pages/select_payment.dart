import 'dart:async';
import 'dart:convert';

import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tungleua/pages/product_cart.dart';

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
      }
      print(selectPayment);
    });
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
                  await saveImageToDevice(imgConvert);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductCart()),
                  );
                },
                child: const Text('Save Image'),
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
