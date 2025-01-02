import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simpkl_mobile/core/contstants/api_constants.dart';
import 'package:simpkl_mobile/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpkl_mobile/models/perusahaan_model.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/models/pembimbing_model.dart';

class AuthService with ChangeNotifier {
  final String _baseUrl = ApiConstants.baseUrl;

  // Login method
  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login-mobile');
    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {

      final data = json.decode(response.body);
        if (data['success']) {
          final token = data['data']['accessToken'];

        // Save token to SQLite
        await DatabaseHelper().insertToken(token);

        //Simpan Profile ke DBLocal
        final response =
            await http.get(Uri.parse('$_baseUrl/auth/profile'), headers: {
          'Authorization': 'Bearer $token',
        });

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (responseData['data'] != null) {
            final dynamic jsonDataPengguna =
                responseData['data']['dataPengguna'];
            ProfileModel dataProfile = ProfileModel.fromJson(jsonDataPengguna);
            await DatabaseHelper().insertProfile(dataProfile);
          }
          if (responseData['data']['dataPengguna']['kelompok_bimbingan'] !=
              null) {
            final kelompokBimbingan =
                responseData['data']['dataPengguna']['kelompok_bimbingan'];

            for (var item in kelompokBimbingan) {
              if (item['guru_pembimbing'] != null) {
                final pembimbingJson = item['guru_pembimbing'];
                PembimbingModel pembimbing =
                    PembimbingModel.fromJson(pembimbingJson);
                await DatabaseHelper().insertPembimbing(pembimbing);
              }
            }
          }
          if (responseData['data']['dataPengguna']['kelompok_bimbingan'] !=
              null) {
            final kelompokBimbingan =
                responseData['data']['dataPengguna']['kelompok_bimbingan'];

            for (var item in kelompokBimbingan) {
              if (item['perusahaan'] != null) {
                final perusahaanJson = item['perusahaan'];
                PerusahaanModel perusahaan =
                    PerusahaanModel.fromJson(perusahaanJson);
                await DatabaseHelper().insertPerusahaan(perusahaan);
              }
            }
          }
        }

        // Save login status to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        return true;
      }
    }
    return false;
  }

  // Get Token method
  Future<String?> getToken() async {
    return DatabaseHelper().getToken();
  }

  // Check login status
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> setMessageToken(String token) async {
    final bearerToken = await getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/set-message-token'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
      body: {
        'token': token,
      },
    );

    print(response.body);
  }

  // Logout method
  Future<void> logout() async {
    // Delete token from SQLite
    await DatabaseHelper().deleteToken();
    await DatabaseHelper().deleteProfile();
    await DatabaseHelper().deletePembimbing();
    await DatabaseHelper().deletePerusahaan();

    // Remove login status from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<void> editProfile({
    required String nama,
    required String alamat,
    required String no_hp,
    required String tanggal_lahir,
    required String tempat_lahir,
    File? fileFoto,
  }) async {
    try {
      final token = await getToken();
      if (token == null) throw Exception('Token not found!');

      final request = http.MultipartRequest('PUT', Uri.parse('$_baseUrl/auth/update-profile'));
      request.headers['Authorization'] = 'Bearer $token';
      
      request.fields['nama'] = nama;
      request.fields['alamat'] = alamat;
      request.fields['no_hp'] = no_hp;
      request.fields['tanggal_lahir'] = tanggal_lahir;
      request.fields['tempat_lahir'] = tempat_lahir;

      if (fileFoto != null) {
        request.files.add(
          await http.MultipartFile.fromPath('foto', fileFoto.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        await _refreshLocalData(token);
        notifyListeners();
      } else {
        throw Exception('Failed to update Profile: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> _refreshLocalData(String token) async {
    await DatabaseHelper().deleteProfile();
    await DatabaseHelper().deletePembimbing();
    await DatabaseHelper().deletePerusahaan();

    final response = await http.get(
      Uri.parse('$_baseUrl/auth/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      if (data != null) {
        final jsonDataPengguna = data['dataPengguna'];
        await DatabaseHelper().insertProfile(ProfileModel.fromJson(jsonDataPengguna));
        
        final kelompokBimbingan = jsonDataPengguna['kelompok_bimbingan'];
        if (kelompokBimbingan != null) {
          for (var item in kelompokBimbingan) {
            if (item['guru_pembimbing'] != null) {
              await DatabaseHelper().insertPembimbing(
                PembimbingModel.fromJson(item['guru_pembimbing'])
              );
            }
            if (item['perusahaan'] != null) {
              await DatabaseHelper().insertPerusahaan(
                PerusahaanModel.fromJson(item['perusahaan'])
              );
            }
          }
        }
      }
    }
  }
}
