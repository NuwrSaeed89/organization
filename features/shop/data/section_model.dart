class SectionModel {
  String id;
  String name;
  String arabicName;

  SectionModel(
      {required this.id, required this.name, required this.arabicName});
  static SectionModel empty() => SectionModel(id: '', name: '', arabicName: '');

  factory SectionModel.fromMap(Map<String, dynamic> data, String documentId) {
    return SectionModel(
      id: documentId,
      name: data['name'] ?? '',
      arabicName: data['arabicName'] ?? '',
    );
  }
}
