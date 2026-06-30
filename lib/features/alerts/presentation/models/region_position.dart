class RegionPosition {
  double left;
  double top;
  double width;

  RegionPosition({required this.left, required this.top, required this.width});

  RegionPosition copy() {
    return RegionPosition(left: left, top: top, width: width);
  }

  @override
  String toString() {
    return 'RegionPosition('
        'left: $left, '
        'top: $top, '
        'width: $width'
        ')';
  }
}
