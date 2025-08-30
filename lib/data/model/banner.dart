class BannerModel {
  int id;
  String imageUrl;

  BannerModel.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      imageUrl = json['image'];
}
