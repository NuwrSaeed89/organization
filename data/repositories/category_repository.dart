import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  Stream<List<CategoryModel>> readCategories() =>
      _db.collection('Categories').snapshots().map((snapshot) => snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList());

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }

      final userCategoryCollection = await _db
          .collection('users')
          .doc(userId)
          .collection('organization')
          .doc('1')
          .collection('category')
          .get();
      if (kDebugMode) {
        print("=======data==============");
        print(userCategoryCollection.docs.toString());
      }
// STORE

      final resultList = userCategoryCollection.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      if (kDebugMode) {
        print("=======data==============");
        print(resultList);
      }
      return resultList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<List<CategoryModel>> getAllCategoriesUserId(String userId) async {
    try {
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }

      final userCategoryCollection = await _db
          .collection('users')
          .doc(userId)
          .collection('organization')
          .doc('1')
          .collection('category')
          .get();
      if (kDebugMode) {
        print("=======data==============");
        print(userCategoryCollection.docs.toString());
      }
// STORE

      final resultList = userCategoryCollection.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();

      if (kDebugMode) {
        print("=======data==============");
        print(resultList);
      }
      return resultList;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<void> addCategory(CategoryModel newCat) async {
    try {
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }
      var docCategory = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('organization')
          .doc('1')
          .collection('category')
          .add(newCat.toJson());
      newCat.id = docCategory.id;
      final json = newCat.toJson();
      await docCategory.set(json);
    } catch (e) {
      throw 'some thing go wrong while add category';
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('organization')
          .doc('1')
          .collection('category')
          .doc(category.id)
          .update(category.toJson());
    } catch (e) {
      throw 'some thing go wrong while updating category';
    }
  }

  Future<void> deleteCategory(CategoryModel category) async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('organization')
          .doc('1')
          .collection('category')
          .doc(category.id)
          .delete();
    } catch (e) {
      throw 'some thing go wrong while updating category';
    }
  }

  Future<List<CategoryModel>> getSubCategories(
      String categoryId, String userId) async {
    try {
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('organization')
          .doc('1')
          .collection("category")
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      if (kDebugMode) {
        print("=======data= subcategory=============");
        print(result);
      }
      return result;
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  // Future<List<CategoryModel>> getCategoryForBrand(String brandId) async {
  //   try {
  //     QuerySnapshot brandCategoryQuery = await _db
  //         .collection('BrandCategory')
  //         .where('BrandId', isEqualTo: brandId)
  //         .get();
  //     List<String> brandIds = brandCategoryQuery.docs
  //         .map((doc) => doc['CategoryId'] as String)
  //         .toList();
  //     final brandQuery = await _db
  //         .collection('Categories')
  //         .where(FieldPath.documentId, whereIn: brandIds)
  //         .limit(4)
  //         .get();
  //     List<CategoryModel> brands =
  //         brandQuery.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
  //     return brands;
  //   } on FirebaseException catch (e) {
  //     throw e.code;
  //   } catch (e) {
  //     throw (e.toString());
  //   }
  // }
}
