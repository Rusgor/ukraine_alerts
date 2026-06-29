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

      alerts = result.where((alert) => alert.locationType == 'oblast').toList();

      activeRegions.clear();

      for (final alert in alerts) {
        final region = alert.region;

        if (region != null) {
          activeRegions[region] = alert;
        }
      }
      // DEBUG
      activeRegions[UkraineRegion.kyiv] = alerts.first;
      activeRegions[UkraineRegion.kharkiv] = alerts.first;
      activeRegions[UkraineRegion.odesa] = alerts.first;

      debugPrint('Loaded oblast alerts: ${alerts.length}');
      debugPrint('Unique active regions: ${activeRegions.length}');
    } catch (e, stackTrace) {
      error = e.toString();

      debugPrint('================ ERROR ================');
      debugPrint(error);
      debugPrint(stackTrace.toString());
      debugPrint('=======================================');
    }

    isLoading = false;

    notifyListeners();
  }

  bool isRegionActive(UkraineRegion region) {
    return activeRegions.containsKey(region);
  }

  void startAutoRefresh() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 30), (_) => loadAlerts());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
