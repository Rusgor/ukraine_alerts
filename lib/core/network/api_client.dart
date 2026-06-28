import 'dio_provider.dart';
import 'package:dio/dio.dart';
import '../../features/alerts/data/models/alert_model.dart';

class ApiClient {
  ApiClient();

  final Dio _dio = DioProvider.dio;

  Future<List<AlertModel>> getActiveAlerts() async {
    final response = await _dio.get('/v1/alerts/active.json');

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;

    final List<dynamic> alerts = json['alerts'] as List<dynamic>;

    return alerts
        .map((e) => AlertModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
