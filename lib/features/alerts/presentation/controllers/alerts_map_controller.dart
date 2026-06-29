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
}
