import '../../domain/models/ukraine_region.dart';

class RegionAssets {
  const RegionAssets._();

  static const String baseMap = "assets/images/ukraine_map.png";

  static const Map<UkraineRegion, String> overlays = {
    UkraineRegion.luhansk: "assets/maps/oblasts/Luhanska.png",

    UkraineRegion.crimea: "assets/maps/oblasts/Krym.png",
  };
}
