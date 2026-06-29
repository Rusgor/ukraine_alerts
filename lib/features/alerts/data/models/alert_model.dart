import '../../domain/models/ukraine_region.dart';

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
  final int locationUid;
  final String locationTitle;
  final String locationType;
  final String locationOblast;
  final String alertType;
  final DateTime startedAt;

  UkraineRegion? get region => UkraineRegion.fromUid(locationUid);

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'] as int,
      locationUid: int.parse(json['location_uid'].toString()),
      locationTitle: json['location_title'] as String,
      locationType: json['location_type'] as String,
      locationOblast: json['location_oblast'] as String,
      alertType: json['alert_type'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
    );
  }
}
