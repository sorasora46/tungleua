import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  late final String _baseUrl;
  late final Dio dio;

  Api() {
    _baseUrl = dotenv.env["BASE_URL"] ?? "";
    dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      responseType: ResponseType.json,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ));
  }
}
