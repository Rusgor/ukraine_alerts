import 'region_assets.dart';
import 'package:flutter/material.dart';
import '../controllers/alerts_map_controller.dart';

class UkraineMapWidget extends StatelessWidget {
  const UkraineMapWidget({super.key, required this.controller});

  final AlertsMapController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 261,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: AspectRatio(
          aspectRatio: 1.58,
          child: Stack(
            fit: StackFit.expand,
            children: [
              //-----------------------------------
              // Base map
              //-----------------------------------
              Image.asset('assets/images/ukraine_map.png', fit: BoxFit.contain),

              //-----------------------------------
              // Active region overlays
              //-----------------------------------
              ...controller.activeRegions.keys.map((region) {
                final asset = RegionAssets.overlays[region];

                if (asset == null) {
                  return const SizedBox.shrink();
                }

                return ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.red,
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(asset, fit: BoxFit.contain),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
