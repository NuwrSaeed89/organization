import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/profile_model.dart';
import 'package:winto/features/organization/e_commerce/utils/logging/logger.dart';

class ProductModel {
  String id;
  //int stock;
  // String? sku;
  ProfileModel? vendor;
  double price;
  String title;
  String arabicTitle;
  double salePrice;
  String vendorId;
  bool? isFeature;
  int? salePersent;
  //BrandModel? brand;
  String? description;
  String? arabicDescription;
  CategoryModel? category;
  List<String>? images;
  String? productType;
  String? thumbnail;
  // List<ProductAtributeModel>? productAtributes;
  //List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.arabicTitle,
    required this.price,
    required this.vendorId,
    this.productType,
    // this.vendor,
    // required this.stock,
    // this.sku,
    //this.brand,
    this.images,
    this.thumbnail,
    this.salePrice = 0.0,
    this.isFeature,
    this.description,
    this.arabicDescription,
    this.category,
    // this.productAtributes,
    //this.productVariations
  });

  toJson() {
    return {
      'Id': id,
      //'SKU': sku ?? '',
      'Title': title,
      'ArabicTitle': arabicTitle,
      'VendorId': vendorId,
      'ProductType': productType,
      'IsFeature': isFeature,
      'Description': description ?? '',
      'ArabicDescription': arabicDescription ?? '',
      //'Brand': brand!.toJson(),
      'Images': images ?? [],
      'Price': price,
      'SalePrice': salePrice,
      'Category': category!.toJson(),
      //  'Vendor': vendor!.toJson(),
      //'Stock': stock,
      // 'ProductAtributes': productAtributes != null
      //     ? productAtributes!.map((e) => e.toJason()).toList()
      //     : [],
    };
  }

  static ProductModel empty() => ProductModel(
      id: '',
      title: '',
      arabicTitle: '',
      productType: '',
      vendorId: '',
      // stock: 0,
      price: 0);

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
   
    return ProductModel(
      id: data['Id'] ?? '',
      title: data['Title']??'',
      // thumbnail: data['Thumbnail'] ?? '',
      arabicTitle: data['ArabicTitle']??'',
      description: data['Description']??'',
      arabicDescription: data['ArabicDescription']??'',
      vendorId: data['VendorId'] ?? '',
      productType: data['ProductType'] ?? '',
      // sku: data['SKU'] ?? '',
      category: CategoryModel.fromJson(data['Category']??''),
      // vendor: data['Vendor'] != null
      //     ? ProfileModel.fromJson(data['Vendor'])
      //     : ProfileModel.empty(),
      isFeature: data['IsFeature'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      // stock: int.parse((data['Stock'] ?? 0).toString()),
      //stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),

      // productAtributes: (data['ProductAttributs'] as List<dynamic>)
      //     .map((e) => ProductAtributeModel.fromJason(e))
      //     .toList(),
      // productVariations: (data['ProductVariations'] as List<dynamic>)
      //     .map((e) => ProductVariationModel.fromJason(e))
      //     .toList()
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data() as Map<String, dynamic>;
    if (kDebugMode) {
      print(data);
    }
    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      arabicTitle: data['ArabicTitle'] ?? '',
      description: data['Description'],
      arabicDescription: data['ArabicDescription'],
      vendorId: data['VendorId'] ?? '',
      //thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      // sku: data['SKU'] ?? '',
      category: data['Category'] != null
          ? CategoryModel.fromSnapshot(data['Category'])
          : CategoryModel.empty(),
      // vendor: data['Vendir'] != null
      //     ? ProfileModel.fromSnapshot(data['Vendor'])
      //     : ProfileModel.empty(),
      isFeature: data['IsFeature'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      // stock: data['Stock'] ?? 0,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      //  stock: int.parse((data['Stock'] ?? 0).toString()),

      // productAtributes: (data['ProductAttributs'] as List<dynamic>)
      //     .map((e) => ProductAtributeModel.fromJason(e))
      //     .toList(),
      // productVariations: (data['ProductVariations'] as List<dynamic>)
      //     .map((e) => ProductVariationModel.fromJason(e))
      //     .toList()
    );
  }
}
