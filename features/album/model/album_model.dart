class AlbumModel {
  String id;
  String name;
  String userId;
  int photoCount;
  double totalSize; // الحجم الإجمالي للصور داخل الألبوم

  AlbumModel({
    required this.id,
    required this.name,
    required this.userId,
    this.photoCount = 0,
    this.totalSize = 0.0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userId': userId,
        'photoCount': photoCount,
        'totalSize': totalSize,
      };

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      name: json['name'],
      userId: json['userId'],
      photoCount: json['photoCount'] ?? 0,
      totalSize: json['totalSize']?.toDouble() ?? 0.0,
    );
  }
}
