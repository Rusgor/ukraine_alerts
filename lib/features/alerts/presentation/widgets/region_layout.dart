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
      left: 303,
      top: 53,
      width: 82,
      height: 82,
    ),

    UkraineRegion.crimea: RegionLayout(
      left: 192,
      top: 178,
      width: 88,
      height: 56,
    ),
  };
}
