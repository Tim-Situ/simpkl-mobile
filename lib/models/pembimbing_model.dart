import 'package:flutter/material.dart';

class PembimbingModel {
  final String nip;
  final String nama;
  final String alamat;
  final String noHp;
  // final String tempat_lahir;
  // final String tanggal_lahir;
  // final String status;
  

  PembimbingModel({
    required this.nip,
    required this.nama,
    required this.alamat,
    required this.noHp,
    // required this.tempat_lahir,
    // required this.tanggal_lahir,
    // required this.status,
    
  });

  factory PembimbingModel.fromJson(Map<String, dynamic> json) {
    return PembimbingModel(
      nip: json['nip'],
      nama: json['nama'],
      alamat: json['alamat'],
      noHp: json['noHp'],
      // tempat_lahir: json['tempat_lahir'],
      // tanggal_lahir: json['tanggal_lahir'],
      // status: json['status'],
      
    );
  }

  factory PembimbingModel.fromMap(Map<String, dynamic> map) {
    return PembimbingModel(
      nip: map['nip'],
      nama: map['nama'],
      alamat: map['alamat'],
      noHp: map['noHp'],
      // tempat_lahir: map['tempat_lahir'],
      // tanggal_lahir: map['tanggal_lahir'],
      // status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {

    return {
      'nip': nip,
      'nama': nama,
      'alamat': alamat,
      'noHp': noHp,
      // 'tempat_lahir': tempat_lahir,
      // 'tanggal_lahir': tanggal_lahir,
      // 'status': status,
    };
  }
}