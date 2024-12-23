class DaftarNilai {
  String id;
  String idSiswa;
  String idAspekPenilaian;
  int nilai;
  String keterangan;
  AspekPenilaian aspekPenilaian;

  DaftarNilai({
    required this.id,
    required this.idSiswa,
    required this.idAspekPenilaian,
    required this.nilai,
    required this.keterangan,
    required this.aspekPenilaian,
  });

  factory DaftarNilai.fromJson(Map<String, dynamic> json) {
    return DaftarNilai(
      id: json['id'],
      idSiswa: json['id_siswa'],
      idAspekPenilaian: json['id_aspek_penilaian'],
      nilai: json['nilai'],
      keterangan: json['keterangan'],
      aspekPenilaian: AspekPenilaian.fromJson(json['aspek_penilaian']),
    );
  }
}

class AspekPenilaian {
  String id;
  String judul;
  String? kode;
  String kelompokPenilaian;

  AspekPenilaian({
    required this.id,
    required this.judul,
    this.kode,
    required this.kelompokPenilaian,
  });

  factory AspekPenilaian.fromJson(Map<String, dynamic> json) {
    return AspekPenilaian(
      id: json['id'],
      judul: json['judul'],
      kode: json['kode'],
      kelompokPenilaian: json['kelompok_penilaian'],
    );
  }
}
