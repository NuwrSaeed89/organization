import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/banner/data/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners(String vendorId) async {
    try {
      final result = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Banners')
          .get();

      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw e.code;
    }
  }

  Future<void> deleteBanner(BannerModel banner, String vendorId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(vendorId)
        .collection('organization')
        .doc('1')
        .collection('Banners')
        .doc(banner.id)
        .delete();
  }

  Future<bool> addBanner(BannerModel banner, String vendorId) async {
    try {
      final currentBanner = await _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Banners')
          .add(banner.toJson());
      if (kDebugMode) {
        print('currentBanner $banner.id');
      }
      banner.id = currentBanner.id;
      _db
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Banners')
          .doc(currentBanner.id)
          .update(banner.toJson());
      return true;
    } catch (e) {
      throw 'Some thing wrong while saving Banner';
    }
  }

  Future<void> updateBanner(BannerModel banner, String vendorId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(vendorId)
        .collection('organization')
        .doc('1')
        .collection('Banners')
        .doc(banner.id)
        .update(banner.toJson());
  }
}
