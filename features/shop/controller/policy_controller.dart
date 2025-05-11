import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PolicyController extends GetxController {
  var sellerId = ''.obs;
  RxString termsAr = ''.obs;
  var aboutusEn = ''.obs;
  var aboutusAr = ''.obs;
  var termsEn = ''.obs;
  var privacyAr = ''.obs;
  var privacyEn = ''.obs;
  var returnPolicyAr = ''.obs;
  var returnPolicyEn = ''.obs;




  void initialValues( String vendorId)async{
    var snapshot= await FirebaseFirestore.instance.collection('users')
            .doc(vendorId).collection('store_policies').doc(vendorId).get();
      var data = snapshot.data as Map<String, dynamic>;

            termsAr.value=data['terms_ar']??'';
            termsEn.value=data['terms_en']??'';
            aboutusAr.value=data['about_us_ar']??'';
            aboutusEn.value=data['about_us_en']??'';
            privacyAr.value=data['privacy_ar']??'';
            privacyEn.value=data['privacy_en']??'';
            returnPolicyAr.value=data['return_policy_ar']??'';
             returnPolicyEn.value=data['return_policy_en']??'';
  }
  void saveToFirestore(String vendorId) async {
    if (vendorId.isEmpty) {
      Get.snackbar("⚠️ خطأ", "يجب إدخال معرف التاجر قبل الحفظ!");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users')
          .doc(vendorId).collection('store_policies').doc(vendorId).set({
        'vendor_id': vendorId,
        'about_us_ar': aboutusAr.value,
        'about_us_en': aboutusEn.value,
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
