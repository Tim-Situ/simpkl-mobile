import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/daftarNilai.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

class NilaiAkhir {
  final String _baseUrl = ApiConstants.baseUrl;
  Future<List<daftarNilai>> fetchNilai() async {
    
    final url = Uri.parse('$_baseUrl/nilai-akhir/siswa');
    final token = await AuthService().getToken();
    if (token == null) {
      throw Exception('Token not found!');
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    // Periksa respons
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body)['data'];
      return jsonData.map((nilai) => daftarNilai.fromJson(nilai)).toList();
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}
