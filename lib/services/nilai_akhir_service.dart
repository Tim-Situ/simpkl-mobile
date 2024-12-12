import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/daftarNilai.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

class NilaiAkhirService {
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

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List<dynamic> nilai = data['data'];
      
      // Convert to List<daftarNilai>
      return nilai.map((datanilai) => daftarNilai.fromJson(datanilai)).toList();
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}

