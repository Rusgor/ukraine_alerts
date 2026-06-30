import 'package:flutter/foundation.dart';

class MapCalibrationController extends ChangeNotifier {
  double left = 0;
  double top = 0;
  double width = 420;
  double height = 261;

  //----------------------------------
  // Move
  //----------------------------------

  void moveLeft([double step = 1]) {
    left -= step;
    notifyListeners();
  }

  void moveRight([double step = 1]) {
    left += step;
    notifyListeners();
  }

  void moveUp([double step = 1]) {
    top -= step;
    notifyListeners();
  }

  void moveDown([double step = 1]) {
    top += step;
    notifyListeners();
  }

  //----------------------------------
  // Resize
  //----------------------------------

  void increaseWidth([double step = 1]) {
    width += step;
    notifyListeners();
  }

  void decreaseWidth([double step = 1]) {
    width -= step;
    notifyListeners();
  }

  void increaseHeight([double step = 1]) {
    height += step;
    notifyListeners();
  }

  void decreaseHeight([double step = 1]) {
    height -= step;
    notifyListeners();
  }

  //----------------------------------
  // Reset
  //----------------------------------

  void reset() {
    left = 0;
    top = 0;
    width = 420;
    height = 261;

    notifyListeners();
  }

  //----------------------------------
  // Export
  //----------------------------------

  String exportLayout() {
    return '''
RegionLayout(
  left: ${left.toStringAsFixed(0)},
  top: ${top.toStringAsFixed(0)},
  width: ${width.toStringAsFixed(0)},
  height: ${height.toStringAsFixed(0)},
)
''';
  }
}
