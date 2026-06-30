import 'package:flutter/material.dart';
import '../controllers/map_calibration_controller.dart';

class MapCalibrationPanel extends StatelessWidget {
  const MapCalibrationPanel({super.key, required this.controller});

  final MapCalibrationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black26)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Calibration",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              //----------------------------------
              // Move
              //----------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: controller.moveUp,
                    icon: const Icon(Icons.keyboard_arrow_up),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: controller.moveLeft,
                    icon: const Icon(Icons.keyboard_arrow_left),
                  ),

                  IconButton(
                    onPressed: controller.moveDown,
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),

                  IconButton(
                    onPressed: controller.moveRight,
                    icon: const Icon(Icons.keyboard_arrow_right),
                  ),
                ],
              ),

              const Divider(),

              //----------------------------------
              // Width
              //----------------------------------
              Row(
                children: [
                  const Expanded(child: Text("Width")),

                  IconButton(
                    onPressed: controller.decreaseWidth,
                    icon: const Icon(Icons.remove),
                  ),

                  Text(controller.width.toStringAsFixed(0)),

                  IconButton(
                    onPressed: controller.increaseWidth,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              //----------------------------------
              // Height
              //----------------------------------
              Row(
                children: [
                  const Expanded(child: Text("Height")),

                  IconButton(
                    onPressed: controller.decreaseHeight,
                    icon: const Icon(Icons.remove),
                  ),

                  Text(controller.height.toStringAsFixed(0)),

                  IconButton(
                    onPressed: controller.increaseHeight,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              const Divider(),

              Text("Left : ${controller.left.toStringAsFixed(0)}"),
              Text("Top : ${controller.top.toStringAsFixed(0)}"),

              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: () {
                  debugPrint(controller.exportLayout());
                },
                child: const Text("Print Layout"),
              ),

              const SizedBox(height: 8),

              ElevatedButton(
                onPressed: controller.reset,
                child: const Text("Reset"),
              ),
            ],
          ),
        );
      },
    );
  }
}
