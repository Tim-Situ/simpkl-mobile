import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/models/jurnal_harian_model.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

class JurnalHarianService with ChangeNotifier {
  List<JurnalHarianModel> _dataJurnalHarian = [];
  bool _isLoading = false;
  final _authService = AuthService();

  List<JurnalHarianModel> get dataJurnalHarian => _dataJurnalHarian;
  bool get isLoading => _isLoading;

  final String _baseUrl = ApiConstants.baseUrl;

  Future<void> getJurnal(String tanggal) async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Token not found!');
      }

      final response = await http.get(
          Uri.parse('$_baseUrl/jurnal-harian/siswa/get-new?tanggal=$tanggal'),
          headers: {
            'Authorization': 'Bearer $token',
          });

      // print("Response Jurnal : ${_dataJurnalHarian}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['data'] != null) {
          final List<dynamic> jsonData = responseData['data'];
          _dataJurnalHarian =
              jsonData.map((item) => JurnalHarianModel.fromJson(item)).toList();
        } else {
          _dataJurnalHarian = [];
        }
      } else {
        _dataJurnalHarian = [];
      }
    } catch (e) {
      _dataJurnalHarian = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> addUser(JurnalHarianModel user) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(_baseUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(user.toJson()),
  //     );
  //     if (response.statusCode == 201) {
  //       final newUser = JurnalHarianModel.fromJson(jsonDecode(response.body));
  //       _dataJurnalHarian.add(newUser);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print('Failed to add user: $e');
  //   }
  // }

  // Future<void> updateUser(JurnalHarianModel user) async {
  //   try {
  //     final response = await http.put(
  //       Uri.parse('$_baseUrl/${user.id}'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(user.toJson()),
  //     );
  //     if (response.statusCode == 200) {
  //       final updatedUser = JurnalHarianModel.fromJson(jsonDecode(response.body));
  //       final index = _dataJurnalHarian.indexWhere((u) => u.id == user.id);
  //       if (index != -1) {
  //         _dataJurnalHarian[index] = updatedUser;
  //         notifyListeners();
  //       }
  //     }
  //   } catch (e) {
  //     print('Failed to update user: $e');
  //   }
  // }

  // Future<void> deleteUser(int id) async {
  //   try {
  //     final response = await http.delete(Uri.parse('$_baseUrl/$id'));
  //     if (response.statusCode == 200) {
  //       _dataJurnalHarian.removeWhere((user) => user.id == id);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print('Failed to delete user: $e');
  //   }
  // }
}
