import 'dart:io';

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

  Future<void> addJournal({
    required String hari,
    required String tanggal,
    required String jenisPekerjaan,
    required String deskripsiPekerjaan,
    required String bentukKegiatan,
    required String jamMulai,
    required String jamSelesai,
    required String staf,
    required File fileFoto,
  }) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Token not found!');
      }

      final request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/jurnal-harian/create"));
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['hari'] = hari;
      request.fields['tanggal'] = tanggal;
      request.fields['jenis_pekerjaan'] = jenisPekerjaan;
      request.fields['deskripsi_pekerjaan'] = deskripsiPekerjaan;
      request.fields['bentuk_kegiatan'] = bentukKegiatan;
      request.fields['jam_mulai'] = jamMulai;
      request.fields['jam_selesai'] = jamSelesai;
      request.fields['staf'] = staf;

      request.files.add(
        await http.MultipartFile.fromPath(
          'foto',
          fileFoto.path,
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        notifyListeners();
      } else {
        print('Failed to add journal: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Failed to add user: $e');
    }
  }

  Future<void> deleteJournal(String id) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Token not found!');
      }

      final response = await http.delete(
        Uri.parse('$_baseUrl/jurnal-harian/delete'),
        body: {"id": id},
        headers: {
          'Authorization': 'Bearer $token',
        }
      );

      if (response.statusCode == 200) {
        notifyListeners();
      }
    } catch (e) {
      print('Failed to delete journal: $e');
    }
  }
}
