import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/banner_model.dart';

class BannerService {
  final String _baseUrl = ApiConstants.baseUrl;

  Future<List<BannerModel>> fetchBanner() async {
    final url = Uri.parse('$_baseUrl/banner/all');

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> banner = data['data'];

      // Convert to List<DaftarNilai>
      return banner.map((databanner) => BannerModel.fromJson(databanner)).toList();
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}
