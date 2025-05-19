class PhotoModel {
  String id;
  String url;
  double size; // حجم الصورة بالميغابايت
  String albumId;
  String userId;

  PhotoModel({
    required this.id,
    required this.url,
    required this.size,
    required this.albumId,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'size': size,
        'albumId': albumId,
        'userId': userId,
      };

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      url: json['url'],
      size: json['size'].toDouble(),
      albumId: json['albumId'],
      userId: json['userId'],
    );
  }
}
