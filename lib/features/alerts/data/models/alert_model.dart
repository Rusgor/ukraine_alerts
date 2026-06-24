class AlertModel {
  const AlertModel({
    required this.regionId,
    required this.regionName,
    required this.regionType,
    required this.startedAt,
  });

  final String regionId;
  final String regionName;
  final String regionType;
  final DateTime startedAt;

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      regionId: json['location_uid'] as String,
      regionName: json['location_title'] as String,
      regionType: json['location_type'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
    );
  }
}
