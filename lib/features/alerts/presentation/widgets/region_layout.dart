import '../../domain/models/ukraine_region.dart';

class RegionLayout {
  const RegionLayout({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  final double left;
  final double top;
  final double width;
  final double height;
}

class RegionLayouts {
  const RegionLayouts._();

  static const Map<UkraineRegion, RegionLayout> layouts = {
    UkraineRegion.luhansk: RegionLayout(
      left: 304,
      top: 52,
      width: 86,
      height: 86,
    ),

    UkraineRegion.crimea: RegionLayout(
      left: 0,
      top: 0,
      width: 420,
      height: 261,
    ),
  };
}
