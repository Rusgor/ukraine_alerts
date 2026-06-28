import 'package:flutter/foundation.dart';
import '../../data/models/alert_model.dart';
import '../../data/repositories/alerts_repository.dart';


class AlertsMapController extends ChangeNotifier {
  final AlertsRepository _repository = AlertsRepository();

  bool isLoading = false;

  String? error;

  List<AlertModel> alerts = [];

  Future<void> loadAlerts() async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      final result = await _repository.getActiveAlerts();

      alerts = result
          .where(
            (alert) => alert.locationType == 'oblast',
          )
          .toList();

      debugPrint(
        'Loaded oblast alerts: ${alerts.length}',
      );
    } catch (e) {
      error = e.toString();

      debugPrint(error);
    }

    isLoading = false;

    notifyListeners();
  }
}
