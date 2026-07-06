import 'dart:convert';
import 'package:http/http.dart' as http;

class RegionAlertsRepository {
  static const _token = '89f7fd8b8eb24e67113b985852c3e087239724a4ab2203';

  Future<bool> getRegionAlert(int uid) async {
    final uri = Uri.parse(
      'https://api.alerts.in.ua/v1/iot/active_air_raid_alerts/$uid.json',
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode != 200) {
      throw Exception('API Error ${response.statusCode}');
    }

    final json = jsonDecode(response.body);

    /// API повертає true / false

    return json.toString() == 'A';
  }
}
