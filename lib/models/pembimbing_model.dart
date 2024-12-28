class PembimbingModel {
  final String nip;
  final String nama;
  final String alamat;
  final String noHp;
  final bool statusAktif;
  final String foto;

  PembimbingModel({
    required this.nip,
    required this.nama,
    required this.alamat,
    required this.noHp,
    required this.statusAktif,
    required this.foto,
  });

  factory PembimbingModel.fromJson(Map<String, dynamic> json) {
    return PembimbingModel(
      nip: json['nip'],
      nama: json['nama'],
      alamat: json['alamat'],
      noHp: json['no_hp'],
      statusAktif: json['status_aktif'] == true,
      foto: json['foto'],
    );
  }

  factory PembimbingModel.fromMap(Map<String, dynamic> map) {
    return PembimbingModel(
      nip: map['nip'],
      nama: map['nama'],
      alamat: map['alamat'],
      noHp: map['no_hp'],
      statusAktif: map['status_aktif'] == 1,
      foto: map['foto'],
    );
  }

  Map<String, dynamic> toMap() {

    return {
      'nip': nip,
      'nama': nama,
      'alamat': alamat,
      'no_hp': noHp,
      'status_aktif': statusAktif,
      'foto': foto
    };
  }
}