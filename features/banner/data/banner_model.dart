// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BannerModel {
  String image;
  String id;
  final String targetScreen;

  bool active;

  BannerModel({
    required this.id,
    required this.image,
    required this.targetScreen,
    required this.active,
  });
  static BannerModel empty() =>
      BannerModel(targetScreen: '', image: '', active: false, id: '');

  Map<String, dynamic> toJson() {
    return {
      'Image': image,
      'TargetScreen': targetScreen,
      'Active': active,
      'Id': id
    };
  }

  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    if (kDebugMode) {
      print(data);
    }
    return BannerModel(
      image: data['Image'] ?? '',
      id: data['Id'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
    );
  }
}
