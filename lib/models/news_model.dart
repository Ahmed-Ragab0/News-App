class NewsModel {
  final String? title;
  final String? desc;
  final String? image;
  final String? url;

  NewsModel(
      {required this.title,
      required this.desc,
      required this.image,
      required this.url});

  factory NewsModel.fromJson(json) {
    return NewsModel(
        title: json['title'],
        desc: json['description'],
        image: json['urlToImage'],
        url: json['url']);
  }
}
