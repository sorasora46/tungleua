import 'package:firebase_auth/firebase_auth.dart';
import 'package:tungleua/services/api.dart';

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

  // pay from wallet
  Future<void> payByWallet() async {
    await Api().dio.get('/payments/pay/wallet/$userId');
  }
}
