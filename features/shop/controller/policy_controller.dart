import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PolicyController extends GetxController {
  var sellerId = ''.obs;
  var termsAr = ''.obs;
  var termsEn = ''.obs;
  var privacyAr = ''.obs;
  var privacyEn = ''.obs;
  var returnPolicyAr = ''.obs;
  var returnPolicyEn = ''.obs;

  void saveToFirestore(String vendorId) async {
    if (vendorId.isEmpty) {
      Get.snackbar("⚠️ خطأ", "يجب إدخال معرف التاجر قبل الحفظ!");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('store_policies').doc(vendorId).set({
        'seller_id': sellerId.value,
        'terms_ar': termsAr.value,
        'terms_en': termsEn.value,
        'privacy_ar': privacyAr.value,
        'privacy_en': privacyEn.value,
        'return_policy_ar': returnPolicyAr.value,
        'return_policy_en': returnPolicyEn.value,
      });
      Get.snackbar("✅ نجاح", "تم حفظ السياسات الخاصة بالتاجر بنجاح!");
    } catch (e) {
      Get.snackbar("⚠️ خطأ", "حدث خطأ أثناء الحفظ: $e");
    }
  }
}
