
class PengumumanModel{
  final String pengumuman;
  final bool status;
  final DateTime createdAt;

  PengumumanModel({
    required this.pengumuman,
    required this.status,
    required this.createdAt
  });

  factory PengumumanModel.fromJson(Map<String, dynamic> json) {

    return PengumumanModel(
      pengumuman: json['pengumuman'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pengumuman': pengumuman,
      'status': status,
      'createdAt' : createdAt.toIso8601String()
    };
  }
}