import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/profile_model.dart';

class ProfileRepository extends GetxController {
  static ProfileRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  ProfileModel thisProfile = ProfileModel();

  Future<ProfileModel> fetchData() async {
    final snapshot = await _db.collection('users').doc(userId).get();
    final user = ProfileModel.fromSnapshot(snapshot);
    thisProfile = user;
    return user;
  }

  Future<ProfileModel> fetchVendoByIdr(String vendorId) async {
    final snapshot = await _db.collection('users').doc(vendorId).get();
    final user = ProfileModel.fromSnapshot(snapshot);

    return user;
  }
}
