import 'package:cloud_firestore/cloud_firestore.dart';

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


  factory SectorModel.fromMap(Map<String, dynamic> map) {
    return SectorModel(
      id: map['id'],
      arabicName: map['arabicName'],
      englishName: map['englishName'],
  name: map['name']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name':name,
      'arabicName': arabicName,
      'englishName': englishName,
    };
  }
}
