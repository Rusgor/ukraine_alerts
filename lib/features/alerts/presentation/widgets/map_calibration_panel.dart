import 'package:flutter/material.dart';
import '../controllers/map_calibration_controller.dart';

class MapCalibrationPanel extends StatelessWidget {
  const MapCalibrationPanel({super.key, required this.controller});

  final MapCalibrationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Card(
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Map Calibration',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),

                const SizedBox(height: 10),

                Text('X: ${controller.left.toStringAsFixed(1)}'),

                Text('Y: ${controller.top.toStringAsFixed(1)}'),

                Text('Width: ${controller.width.toStringAsFixed(1)}'),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ElevatedButton(
                      onPressed: controller.moveUp,
                      child: const Text('↑'),
                    ),
                    ElevatedButton(
                      onPressed: controller.moveDown,
                      child: const Text('↓'),
                    ),
                    ElevatedButton(
                      onPressed: controller.moveLeft,
                      child: const Text('←'),
                    ),
                    ElevatedButton(
                      onPressed: controller.moveRight,
                      child: const Text('→'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 6,
                  children: [
                    ElevatedButton(
                      onPressed: controller.decreaseWidth,
                      child: const Text('- Width'),
                    ),
                    ElevatedButton(
                      onPressed: controller.increaseWidth,
                      child: const Text('+ Width'),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 6,
                  children: [
                    ElevatedButton(
                      onPressed: controller.printCurrentPosition,
                      child: const Text('Print'),
                    ),
                    ElevatedButton(
                      onPressed: controller.reset,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
