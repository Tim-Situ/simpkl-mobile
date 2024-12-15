import 'package:flutter/material.dart';

class ProfileModel {
  final String nisn;
  final String nama;
  final String alamat;
  final String no_hp;
  final String tempat_lahir;
  final DateTime tanggal_lahir;
  final bool status_aktif;
  final String jurusan;

  ProfileModel({
    required this.nisn,
    required this.nama,
    required this.alamat,
    required this.no_hp,
    required this.tempat_lahir,
    required this.tanggal_lahir,
    required this.status_aktif,
    required this.jurusan,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nisn: json['nisn'],
      nama: json['nama'],
      alamat: json['alamat'],
      no_hp: json['no_hp'],
      tempat_lahir: json['tempat_lahir'],
      tanggal_lahir: DateTime.parse(json['tanggal_lahir']),
      status_aktif: json['status_aktif'] == true,
      jurusan: json['jurusan']['bidang_keahlian'],
    );
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      nisn: map['nisn'],
      nama: map['nama'],
      alamat: map['alamat'],
      no_hp: map['no_hp'],
      tempat_lahir: map['tempat_lahir'],
      tanggal_lahir: DateTime.parse(map['tanggal_lahir']),
      status_aktif: map['status_aktif']==1,
      jurusan: map['jurusan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nisn': nisn,
      'nama': nama,
      'alamat': alamat,
      'no_hp': no_hp,
      'tempat_lahir': tempat_lahir,
      'tanggal_lahir': tanggal_lahir.toIso8601String(),
      'status_aktif': status_aktif,
      'jurusan': jurusan
    };
  }
}