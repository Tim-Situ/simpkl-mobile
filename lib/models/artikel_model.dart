class ArtikelModel{
  final String judul;
  final String thumbnail;
  final String link;
  final DateTime createdAt;

  ArtikelModel({
    required this.judul,
    required this.thumbnail,
    required this.link,
    required this.createdAt
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {

    return ArtikelModel(
      judul: json['judul'],
      thumbnail: json['thumbnail'],
      link: json['link'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'thumbnail': thumbnail,
      'link': link,
      'createdAt' : createdAt.toIso8601String()
    };
  }
}