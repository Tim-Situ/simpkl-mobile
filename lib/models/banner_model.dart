
class BannerModel{
  final String link;
  final String gambar;

  BannerModel({
    required this.gambar,
    required this.link
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
  
    return BannerModel(
      link: json['link'],
      gambar: json['gambar']
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'link': link,
      'gambar': gambar
    };
  }
}