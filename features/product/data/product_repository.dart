import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  // var userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<ProductModel>> getFeaturesProducts(String vendorId) async {
    try {
      if (vendorId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }
      final snapshot = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  void updateProduct(ProductModel product, String vendorId) async {
    try {
      if (vendorId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .doc(product.id)
          .update(product.toJson());
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .update(product.toJson());
    } catch (e) {
      throw 'some thing go wrong while updating category';
    }
  }

//fetchProductPageinations
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getAllProductsByIds(
      List<String> productIds, String vendorId) async {
    try {
      final snapshot = await _db
          .collection('users')
          .doc(vendorId)
          
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getProductsbyIds(
      List<String> productIds, String vendorId) async {
    try {
      final snapshot = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId,
      required String vendorId,
      int limit = 20}) async {
    try {
      final vv = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .where('Category.Id', isEqualTo: categoryId)
          .limit(limit)
          .get();
      List<ProductModel> products =
          vv.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      if (kDebugMode) {
        print("=========!====product length ${products.length}");
      }
      return products;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getProductsbyType(
      String vendorId, String type) async {
    try {
      final userCategoryCollection = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .where('ProductType', isEqualTo: type)
          .get();

// STORE

      final resultList = userCategoryCollection.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      if (kDebugMode) {
        print(
            "=======data== product============${resultList.length}============");
        print(resultList);
      }
      return resultList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<ProductModel>> getAllProducts(String vendorId) async {
    try {
      final userCategoryCollection = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .get();

// STORE

      final resultList = userCategoryCollection.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      if (kDebugMode) {
        print(
            "=======data== product============${resultList.length}============");
        print(resultList);
      }
      return resultList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }



   Future<List<ProductModel>> getAllTempProducts(String vendorId) async {
    try {
      final userCategoryCollection = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('temporary_data')
          .get();

// STORE

      final resultList = userCategoryCollection.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      if (kDebugMode) {
        print(
            "=======data== product============${resultList.length}============");
        print(resultList);
      }
      return resultList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<void> deleteProduct(ProductModel product, String vendorId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(vendorId)
        .collection('organization')
        .doc('1')
        .collection('Products')
        .doc(product.id)
        .delete();
    await FirebaseFirestore.instance
        .collection('products')
        .doc(product.id)
        .delete();
  }

 Future<bool> addProductToTemps(ProductModel product, String vendorId) async {
    try {
      final currentproduct = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('temporary_data')
          .add(product.toJson());
      if (kDebugMode) {
        print('currentproduct $currentproduct.id');
      }
      product.id = currentproduct.id;
      _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection("temporary_data")
          .doc(currentproduct.id)
          .update(product.toJson());

      await _db
          .collection('temporary_data')
          .doc(currentproduct.id)
          .set(product.toJson());
      if (kDebugMode) {
        print('================product added on root===========');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('=======================insert product faild=============');
      }
      throw 'Some thing wrong while saving product';
    }
  }


  Future<bool> addProducts(ProductModel product, String vendorId) async {
    try {
      final currentproduct = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .add(product.toJson());
      if (kDebugMode) {
        print('currentproduct $currentproduct.id');
      }
      product.id = currentproduct.id;
      _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection("Products")
          .doc(currentproduct.id)
          .update(product.toJson());

      await _db
          .collection('products')
          .doc(currentproduct.id)
          .set(product.toJson());
      if (kDebugMode) {
        print('================product added on root===========');
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('=======================insert product faild=============');
      }
      throw 'Some thing wrong while saving product';
    }
  }

  Future<Widget> getProductCount(String categoryId) async {
    FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .where('Category.Id', isEqualTo: categoryId)
            .get(),
        builder: (context, Snapshot) {
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: TLoaderWidget());
          }
          if (Snapshot.hasError) {
            return const Center(child: Text("opps"));
          }

          var s = Snapshot.data!.docs;
          if (s.isNotEmpty) {
            return Text("${s.length}");
          }
          return SizedBox.shrink();
        });
    return SizedBox.shrink();
  }

  Future<int> getUserProductCount(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.size; // عدد المنتجات الخاصة بالمستخدم
  }
}
  // getFavoritesProducts(List<String> list) {

  //       try {
  //     final snapshot = _db
  //         .collection('Products')
  //         .where(FieldPath.documentId, whereIn: list)
  //         .get();
  //     final t = snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  //     return t;
  //   } on FirebaseException catch (e) {
  //     throw e.code;
  //   }
  // }
