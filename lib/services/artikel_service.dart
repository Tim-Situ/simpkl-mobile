import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/artikel_model.dart';

class ArtikelService {
  final String _baseUrl = ApiConstants.baseUrl;

  Future<List<ArtikelModel>> fetchArtikel() async {
    final url = Uri.parse('$_baseUrl/artikel/all');

    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> artikel = data['data'];

      // Convert to List<DaftarNilai>
      return artikel.map((dataartikel) => ArtikelModel.fromJson(dataartikel)).toList();
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}
