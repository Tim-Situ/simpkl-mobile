import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/presensi.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

class PresensiService {
  final String _baseUrl = ApiConstants.baseUrl;

  Future<KehadiranResponse> fetchKehadiran() async {
    final url = Uri.parse('$_baseUrl/absensi/get/siswa');
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

      // Convert to KehadiranResponse
      return KehadiranResponse.fromJson(data);
    } else {
      throw Exception('Failed to load data: ${response.reasonPhrase}');
    }
  }
}
