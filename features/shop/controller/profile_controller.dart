import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/profile_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/profile_repository.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final repository = Get.put(ProfileRepository());
  final isLoading = false.obs;
  Rx<ProfileModel> profilData = ProfileModel().obs;
  Rx<ProfileModel> vendorData = ProfileModel().obs;
  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  Future<void> fetchAllData() async {
    try {
      isLoading.value = true;

      var c = await repository.fetchData();
      profilData.value = c;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      //TLoader.erroreSnackBar(title: 'oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVendorData(String vendorId) async {
    try {
      isLoading.value = true;

      var c = await repository.fetchVendoByIdr(vendorId);
        profilData.value=c;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    
     // return profilData;
      //TLoader.erroreSnackBar(title: 'oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
   
  }
}
