class Notifikasi {
  final int? id;
  final String title;
  final String body;
  final DateTime createdAt;

  Notifikasi({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Convert map to Notifikasi
  factory Notifikasi.fromMap(Map<String, dynamic> map) {
    return Notifikasi(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}