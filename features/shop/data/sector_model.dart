class SectorModel {
  String? id;
  String name;
  String englishName;
  String arabicName;

  SectorModel(
      {this.id,
      required this.name,
      required this.englishName,
      required this.arabicName});
  static SectorModel empty() =>
      SectorModel(id: '', name: '', englishName: '', arabicName: '');

  factory SectorModel.fromMap(Map<String, dynamic> data, String documentId) {
    return SectorModel(
      id: documentId,
      name: data['name'],
      englishName: data['englishname'] ?? '',
      arabicName: data['arabicName'] ?? '',
    );
  }
}
