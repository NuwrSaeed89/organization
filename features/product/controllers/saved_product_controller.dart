// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';

class SavedProductsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var savedProducts = <ProductModel>[].obs;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  static SavedProductsController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
    fetchSavedProducts();
  }

  // Fetch saved products list from Firebase
  void fetchSavedProducts() async {
    var snapshot = await _firestore
        .collection('saved_products')
        .where('userId', isEqualTo: userId)
        .get();

    savedProducts.value =
        snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  }

  void saveProduct(ProductModel product) async {
    if (savedProducts.any((p) => p.id == product.id)) {
      print("Product already saved.");
      return;
    }

    savedProducts.add(product); // Update local list

    // Push the entire updated list to Firebase
    var updatedList = savedProducts.map((p) => p.toJson()).toList();

    await _firestore.collection('saved_products').doc(userId).set({
      'userId': userId,
      'products': updatedList,
    });

    fetchSavedProducts(); // Refresh list after update
  }

  void removeProduct(String productId) async {
    savedProducts
        .removeWhere((product) => product.id == productId); // Remove locally

    // Convert updated list to JSON format
    var updatedList = savedProducts.map((p) => p.toJson()).toList();

    // Push the updated list to Firestore
    await FirebaseFirestore.instance
        .collection('saved_products')
        .doc(userId)
        .set({
      'userId': userId,
      'products': updatedList,
    });

    fetchSavedProducts(); // Refresh list after update
  }

  bool isSaved(String productId) {
    return savedProducts.any((product) => product.id == productId);
  }
}
