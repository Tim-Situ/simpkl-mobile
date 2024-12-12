import 'package:flutter/material.dart';

class ProfileModel {
  final String nisn;
  final String nama;
  final String jurusan;

  ProfileModel({
    required this.nisn,
    required this.nama,
    required this.jurusan,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nisn: json['nisn'],
      nama: json['nama'],
      jurusan: json['jurusan']['bidang_keahlian'],
    );
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      nisn: map['nisn'],
      nama: map['nama'],
      jurusan: map['jurusan'],
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'nisn': nisn,
      'nama': nama,
      'jurusan': jurusan
    };
  }
}