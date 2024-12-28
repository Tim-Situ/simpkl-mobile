class PerusahaanModel {
  final String nama_perusahaan;
  final String pimpinan;
  final String alamat;
  final String no_hp;
  final String email;
  final String website;
  final String foto;

  PerusahaanModel({
    required this.nama_perusahaan,
    required this.pimpinan,
    required this.alamat,
    required this.no_hp,
    required this.email,
    required this.website,
    required this.foto,
  });

  factory PerusahaanModel.fromJson(Map<String, dynamic> json) {
    return PerusahaanModel(
      nama_perusahaan: json['nama_perusahaan'],
      pimpinan: json['pimpinan'],
      alamat: json['alamat'],
      no_hp: json['no_hp'],
      email: json['email'],
      website: json['website'],
      foto: json['foto'],
    );
  }

  factory PerusahaanModel.fromMap(Map<String, dynamic> map) {
    return PerusahaanModel(
      nama_perusahaan: map['nama_perusahaan'],
      pimpinan: map['pimpinan'],
      alamat: map['alamat'],
      no_hp: map['no_hp'],
      email: map['email'],
      website: map['website'],
      foto: map['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_perusahaan': nama_perusahaan,
      'pimpinan': pimpinan,
      'alamat': alamat,
      'no_hp': no_hp,
      'email': email,
      'website': website,
      'foto': foto
    };
  }
}
