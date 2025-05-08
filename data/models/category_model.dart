import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/features/organization/e_commerce/utils/formatters/formatter.dart';
import 'package:winto/features/organization/e_commerce/utils/logging/logger.dart';

class CategoryModel {
  String? id;
  String name;
  String arabicName;
  String? image;
  bool? isFeature;
  int status;
  String parentId;
  final List<CategoryModel>? subCategories;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel(
      {this.id,
      required this.name,
      this.subCategories,
      this.status = 2,
      required this.arabicName,
      this.image = "",
      this.isFeature = false,
      this.parentId = '',
      this.createdAt,
      this.updatedAt});

  static CategoryModel empty() => CategoryModel(
      id: '', name: '', arabicName: '', image: '', status: 0, isFeature: false);

  toJson() {
    return {
      'Id': id,
      'Name': name,
      'ArabicName': arabicName,
      'Image': image,
      'ParentId': parentId,
      'IsFeature': isFeature,
      'CreatedAt': createdAt,
      'Status': status,
      'UpdatedAt': updatedAt = DateTime.now()
    };
  }

  String get statusDecrypt {
    var result = "";
    switch (status) {
      case 1:
        result = AppLocalizations.of(Get.context!).translate('category.1');
        break;
      case 2:
        result = AppLocalizations.of(Get.context!).translate('category.2');
        break;
      case 3:
        result = AppLocalizations.of(Get.context!).translate('category.3');
        break;
    }

    return result;
  }

  String get formatedCreatedAt => TFormatter.formateDate(createdAt);
  String get formatedUpdatedAt => TFormatter.formateDate(updatedAt);

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      TLoggerHelper.info(data['Name']);

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        arabicName: data['ArabicName'] ?? '',
        parentId: data['ParentId'] ?? '',
        image: data['Image'] ?? '',
        status: data['Status'] ?? '',
        isFeature: data['IsFeature'] ?? false,
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    }
    return CategoryModel.empty();
  }

  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['Id'] ?? '',
        name: json['Name'] ?? '',
        arabicName: json['ArabicName'] ?? '',
        parentId: json['ParentId'] ?? '',
        image: json['Image'] ?? '',
        isFeature: json['IsFeature'] ?? '',
      );
}
