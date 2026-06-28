class AlertModel {
  const AlertModel({
    required this.id,
    required this.locationUid,
    required this.locationTitle,
    required this.locationType,
    required this.locationOblast,
    required this.alertType,
    required this.startedAt,
  });

  final int id;

  final String locationUid;

  final String locationTitle;

  final String locationType;

  final String locationOblast;

  final String alertType;

  final DateTime startedAt;

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] as int,
      locationUid: json['location_uid'].toString(),
      locationTitle: json['location_title'] as String,
      locationType: json['location_type'] as String,
      locationOblast: json['location_oblast'] as String,
      alertType: json['alert_type'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
    );
  }
}
