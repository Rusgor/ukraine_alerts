import '../models/alert_model.dart';
import '../../../../core/network/api_client.dart';

class AlertsRepository {
  AlertsRepository();

  final ApiClient _apiClient = ApiClient();

  Future<List<AlertModel>> getActiveAlerts() async {
    return _apiClient.getActiveAlerts();
  }
}
