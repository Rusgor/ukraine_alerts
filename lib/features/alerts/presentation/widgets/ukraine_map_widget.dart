import 'region_assets.dart';
import 'region_layout.dart';
import 'package:flutter/material.dart';
import '../controllers/alerts_map_controller.dart';

class UkraineMapWidget extends StatelessWidget {
  const UkraineMapWidget({super.key, required this.controller});

  final AlertsMapController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 420 / 261,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //--------------------------------------------------
          // Base map
          //--------------------------------------------------
          Image.asset(RegionAssets.baseMap, fit: BoxFit.contain),

          //--------------------------------------------------
          // Active alert overlays
          //--------------------------------------------------
          ...controller.activeRegions.keys.map((region) {
            final overlay = RegionAssets.overlays[region];
            final layout = RegionLayouts.layouts[region];

            if (overlay == null || layout == null) {
              return const SizedBox.shrink();
            }

            return Positioned(
              left: layout.left,
              top: layout.top,
              width: layout.width,
              height: layout.height,
              child: IgnorePointer(
                child: Image.asset(overlay, fit: BoxFit.contain),
              ),
            );
          }),
        ],
      ),
    );
  }
}
