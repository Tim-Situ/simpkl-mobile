class ProfileModel {
  final String nisn;
  final String nama;
  final String alamat;
  final String noHp;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final bool statusAktif;
  final String jurusan;

  ProfileModel({
    required this.nisn,
    required this.nama,
    required this.alamat,
    required this.noHp,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.statusAktif,
    required this.jurusan,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nisn: json['nisn'],
      nama: json['nama'],
      alamat: json['alamat'],
      noHp: json['no_hp'],
      tempatLahir: json['tempat_lahir'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      statusAktif: json['status_aktif'] == true,
      jurusan: json['jurusan']['bidang_keahlian'],
    );
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      nisn: map['nisn'],
      nama: map['nama'],
      alamat: map['alamat'],
      noHp: map['no_hp'],
      tempatLahir: map['tempat_lahir'],
      tanggalLahir: DateTime.parse(map['tanggal_lahir']),
      statusAktif: map['status_aktif'] == 1,
      jurusan: map['jurusan'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nisn': nisn,
      'nama': nama,
      'alamat': alamat,
      'no_hp': noHp,
      'tempat_lahir': tempatLahir,
      'tanggal_lahir': tanggalLahir.toIso8601String(),
      'status_aktif': statusAktif,
      'jurusan': jurusan
    };
  }
}
