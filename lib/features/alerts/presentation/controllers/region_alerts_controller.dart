import 'package:flutter/material.dart';
import '../../domain/models/location_item.dart';
import '../../data/repositories/region_alerts_repository.dart';

class RegionAlertsController extends ChangeNotifier {
  LocationItem? selectedLocation;

  final RegionAlertsRepository _repository = RegionAlertsRepository();

  bool isLoading = false;

  bool? isAlertActive;

  String? error;

  void selectLocation(LocationItem location) {
    selectedLocation = location;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setAlertState(bool value) {
    isAlertActive = value;
    notifyListeners();
  }

  void setError(String? value) {
    error = value;
    notifyListeners();
  }

  Future<void> loadAlert() async {
    if (selectedLocation == null) return;

    isLoading = true;
    error = null;

    notifyListeners();

    try {
      isAlertActive = await _repository.getRegionAlert(selectedLocation!.uid);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;

    notifyListeners();
  }
}
