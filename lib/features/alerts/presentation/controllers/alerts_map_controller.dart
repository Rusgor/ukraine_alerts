import 'package:flutter/foundation.dart';
import '../../data/models/alert_model.dart';
import '../../data/repositories/alerts_repository.dart';

class AlertsMapController extends ChangeNotifier {
  AlertsMapController();

  final AlertsRepository _repository = AlertsRepository();

  List<AlertModel> alerts = [];

  bool isLoading = false;

  String? error;

  Future<void> loadAlerts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      alerts = await _repository.getActiveAlerts();
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
