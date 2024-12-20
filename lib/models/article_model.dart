class ArticleModel {
  final String? image;
  final String title;
  final String? subTitle;
  // final String url;

  ArticleModel({
    // required this.url,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  ArticleModel.fromJson(Map<String, dynamic> json)
    : image = json['urlToImage'],
      title = json['title'],
      subTitle = json['description'];
}
