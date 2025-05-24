// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';

class FavoriteProductsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var favoriteProducts = <ProductModel>[].obs;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  static FavoriteProductsController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
    fetchFavoriteProducts();
  }

  // Fetch saved products list from Firebase
  void fetchFavoriteProducts() async {
    var snapshot = await _firestore
        .collection('saved_products')
        .where('userId', isEqualTo: userId)
        .get();

    favoriteProducts.value =
        snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  }

  void saveProduct(ProductModel product) async {
    if (favoriteProducts.any((p) => p.id == product.id)) {
      print("Product already saved.");
      return;
    }

    favoriteProducts.add(product); // Update local list

    // Push the entire updated list to Firebase
    var updatedList = favoriteProducts.map((p) => p.toJson()).toList();

    await _firestore.collection('favorite_products').doc(userId).set({
      'userId': userId,
      'products': updatedList,
    });

    fetchFavoriteProducts(); // Refresh list after update
  }

  void removeProduct(String productId) async {
    favoriteProducts
        .removeWhere((product) => product.id == productId); // Remove locally

    // Convert updated list to JSON format
    var updatedList = favoriteProducts.map((p) => p.toJson()).toList();

    // Push the updated list to Firestore
    await FirebaseFirestore.instance
        .collection('favorite_products')
        .doc(userId)
        .set({
      'userId': userId,
      'products': updatedList,
    });

    fetchFavoriteProducts(); // Refresh list after update
  }

  bool isSaved(String productId) {
    return favoriteProducts.any((product) => product.id == productId);
  }
}
