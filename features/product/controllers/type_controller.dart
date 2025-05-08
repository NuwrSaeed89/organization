import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';

class ProductTypeController extends GetxController {
  var products = <ProductModel>[].obs;

  Future<void> fetchProducts(String type, String vendorId) async {
    var snapshot = await await ProductRepository.instance
        .getProductsbyType(vendorId, type);
    products.value = snapshot;
  }

  // Future<void> addProduct(ProductModel newProduct) async {
  //   await FirebaseFirestore.instance.collection('products').add({'name': newProduct});
  //   await fetchProducts(); // تحديث القائمة بعد الإضافة
  // }
}
