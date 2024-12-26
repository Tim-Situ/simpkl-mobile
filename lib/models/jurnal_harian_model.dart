import 'package:flutter/material.dart';

class JurnalHarianModel {
  final String id;
  final String idBimbingan;
  final String hari;
  final DateTime tanggal;
  final String jenisPekerjaan;
  final String deskripsiPekerjaan;
  final String bentukKegiatan;
  final TimeOfDay jamMulai;
  final TimeOfDay jamSelesai;
  final String staf;
  final String foto;
  final String? catatanPembimbing;
  final String status;

  JurnalHarianModel({
    required this.id,
    required this.idBimbingan,
    required this.hari,
    required this.tanggal,
    required this.jenisPekerjaan,
    required this.deskripsiPekerjaan,
    required this.bentukKegiatan,
    required this.jamMulai,
    required this.jamSelesai,
    required this.staf,
    required this.foto,
    this.catatanPembimbing,
    required this.status,
  });

  factory JurnalHarianModel.fromJson(Map<String, dynamic> json) {
    
    TimeOfDay parseTime(String isoString) {
      final dateTime = DateTime.parse(isoString);
      return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    }

    return JurnalHarianModel(
      id: json['id'],
      idBimbingan: json['id_bimbingan'],
      hari: json['hari'],
      tanggal: DateTime.parse(json['tanggal']),
      jenisPekerjaan: json['jenis_pekerjaan'],
      deskripsiPekerjaan: json['deskripsi_pekerjaan'],
      bentukKegiatan: json['bentuk_kegiatan'],
      jamMulai: parseTime(json['jam_mulai']),
      jamSelesai: parseTime(json['jam_selesai']),
      staf: json['staf'],
      foto: json['foto'],
      catatanPembimbing: json['catatan_pembimbing'],
      status: json['status']
    );
  }

  Map<String, dynamic> toJson() {

    String timeToIso(TimeOfDay time) {
      return DateTime(1970, 1, 1, time.hour, time.minute).toIso8601String();
    }

    return {
      'id': id,
      'id_bimbingan': idBimbingan,
      'hari': hari,
      'tanggal': tanggal.toIso8601String(),
      'jenis_pekerjaan': jenisPekerjaan,
      'deskripsi_pekerjaan': deskripsiPekerjaan,
      'bentuk_kegiatan': bentukKegiatan,
      'jam_mulai': timeToIso(jamMulai),
      'jam_selesai': timeToIso(jamSelesai),
      'staf': staf,
      'foto': foto,
      'catatan_pembimbing': catatanPembimbing,
      'status': status,
    };
  }
}