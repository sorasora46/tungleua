import 'package:tungleua/models/coupon.dart';
import 'package:tungleua/services/api.dart';

class CouponService {
  Future<List<Coupon>?> getCoupons(String userId) async {
    final response = await Api().dio.get("/discounts/find-by-user/$userId");
    if (response.statusCode != 200) return null;
    final data = response.data as Map<String, dynamic>;
    final rawListData = data['discounts'] as List<dynamic>;
    final coupons = rawListData
        .map((coupon) => Coupon.fromJSON(coupon as Map<String, dynamic>))
        .toList();
    return coupons;
  }
}
