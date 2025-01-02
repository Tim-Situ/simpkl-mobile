import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/pengumuman_model.dart';

class PengumumanService {
  final String _baseUrl = ApiConstants.baseUrl;

  Future<List<PengumumanModel>> fetchPengumuman() async {
    final url = Uri.parse('$_baseUrl/pengumuman/all');

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> pengumuman = data['data'];

      // Convert to List<DaftarNilai>
      return pengumuman.map((datapengumuman) => PengumumanModel.fromJson(datapengumuman)).toList();
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}
