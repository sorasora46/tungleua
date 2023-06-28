import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tungleua/services/api.dart';

import 'package:flutter/material.dart';

class PaymentService {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // return QRCode image
  Future<String?> depositMoney(double amount) async {
    final response = await Api()
        .dio
        .post('/payments/deposit?amount=$amount&user_id=$userId');
    if (response.statusCode != 200) return null;
    return '';
  }

  // pay without deposit return QRCode image
  Future<String?> genPaymentQRCode() async {
    final response = await Api().dio.get('/payments/pay/qrcode/$userId');
    if (response.statusCode != 200) return null;
    return '';
  }

  Future<String?> topUp(String amount) async {
    final response =
        await Api().dio.post('/payments/user/$userId/amount/$amount');
    if (response.statusCode == 200) {
      final responseData = response.data;
      print(responseData);

      return responseData;
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load image');
    }
  }

  // pay from wallet
  Future<String?> payByWallet(String userId) async {
    final response = await Api().dio.post('/payments/payWallet/$userId');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.data);
      final jsonString = jsonEncode(responseData);
      print(jsonString);

      return jsonString;
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load image');
    }
  }

  Future<String?> sentInfo(String userId) async {
    final response = await Api().dio.post('/payments/user/$userId');

    if (response.statusCode == 200) {
      final responseData = response.data;

      return responseData;
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load image');
    }
  }
}
