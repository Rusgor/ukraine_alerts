import 'package:dio/dio.dart';

class DioProvider {
  DioProvider._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.alerts.in.ua',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization':
            'Bearer 89f7fd8b8eb24e67113b985852c3e087239724a4ab2203',
        'Content-Type': 'application/json',
      },
    ),
  );
}
