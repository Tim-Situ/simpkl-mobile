class KehadiranResponse {
  bool success;
  String message;
  KehadiranData data;

  KehadiranResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory KehadiranResponse.fromJson(Map<String, dynamic> json) {
    return KehadiranResponse(
      success: json['success'],
      message: json['message'],
      data: KehadiranData.fromJson(json['data']),
    );
  }
}

class KehadiranData {
  JmlKehadiran jmlKehadiran;
  List<DataKehadiran> dataKehadiran;

  KehadiranData({
    required this.jmlKehadiran,
    required this.dataKehadiran,
  });

  factory KehadiranData.fromJson(Map<String, dynamic> json) {
    return KehadiranData(
      jmlKehadiran: JmlKehadiran.fromJson(json['jml_kehadiran']),
      dataKehadiran: (json['data_kehadiran'] as List)
          .map((item) => DataKehadiran.fromJson(item))
          .toList(),
    );
  }
}

class JmlKehadiran {
  int hadir;
  int libur;
  int sakit;
  int alpa;
  int izin;

  JmlKehadiran({
    required this.hadir,
    required this.libur,
    required this.sakit,
    required this.alpa,
    required this.izin,
  });

  factory JmlKehadiran.fromJson(Map<String, dynamic> json) {
    return JmlKehadiran(
      hadir: json['HADIR'],
      libur: json['LIBUR'],
      sakit: json['SAKIT'],
      alpa: json['ALPA'],
      izin: json['IZIN'],
    );
  }
}

class DataKehadiran {
  String id;
  String idBimbingan;
  DateTime tanggal;
  String status;
  String? createdBy;
  String? updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  DataKehadiran({
    required this.id,
    required this.idBimbingan,
    required this.tanggal,
    required this.status,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataKehadiran.fromJson(Map<String, dynamic> json) {
    return DataKehadiran(
      id: json['id'],
      idBimbingan: json['id_bimbingan'],
      tanggal: DateTime.parse(json['tanggal']),
      status: json['status'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
