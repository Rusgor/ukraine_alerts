import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../data/models/alert_model.dart';
import '../../domain/models/ukraine_region.dart';
import '../../data/repositories/alerts_repository.dart';

class AlertsMapController extends ChangeNotifier {
  final AlertsRepository _repository = AlertsRepository();

  bool isLoading = false;

  String? error;

  List<AlertModel> alerts = [];

  final Map<UkraineRegion, AlertModel> activeRegions = {};

  Timer? _timer;

  Future<void> loadAlerts() async {
    isLoading = true;
    error = null;

    notifyListeners();

    try {
      final result = await _repository.getActiveAlerts();

      alerts = result.where((e) => e.locationType == "oblast").toList();

      activeRegions.clear();

      for (final alert in alerts) {
        if (alert.region != null) {
          activeRegions[alert.region!] = alert;
        }
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;

    notifyListeners();
  }

  void refresh() {
    loadAlerts();
  }

  void startAutoRefresh() {
    stopAutoRefresh();

    _timer = Timer.periodic(const Duration(seconds: 30), (_) => loadAlerts());
  }

  void stopAutoRefresh() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
}
