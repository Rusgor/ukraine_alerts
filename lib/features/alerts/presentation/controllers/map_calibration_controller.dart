import '../models/region_position.dart';
import 'package:flutter/foundation.dart';

class MapCalibrationController extends ChangeNotifier {
  MapCalibrationController();

  RegionPosition position = RegionPosition(left: 0, top: 0, width: 120);

  //==================================================
  // Compatibility API (для поточної Calibration Panel)
  //==================================================

  double get left => position.left;

  double get top => position.top;

  double get width => position.width;

  // Поки використовуємо квадратний PNG
  double get height => position.width;

  //==================================================
  // Move
  //==================================================

  void moveLeft() {
    position.left -= 1;
    notifyListeners();
  }

  void moveRight() {
    position.left += 1;
    notifyListeners();
  }

  void moveUp() {
    position.top -= 1;
    notifyListeners();
  }

  void moveDown() {
    position.top += 1;
    notifyListeners();
  }

  //==================================================
  // Resize
  //==================================================

  void increaseWidth() {
    position.width += 1;
    notifyListeners();
  }

  void decreaseWidth() {
    if (position.width > 10) {
      position.width -= 1;
      notifyListeners();
    }
  }

  void increaseHeight() {
    increaseWidth();
  }

  void decreaseHeight() {
    decreaseWidth();
  }

  //==================================================
  // Reset
  //==================================================

  void reset() {
    position = RegionPosition(left: 0, top: 0, width: 120);

    notifyListeners();
  }

  //==================================================
  // Export
  //==================================================

  String exportLayout() {
    return position.toString();
  }

  void printCurrentPosition() {
    debugPrint(position.toString());
  }
}
