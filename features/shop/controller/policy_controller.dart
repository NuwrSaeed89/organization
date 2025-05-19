import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';

class PolicyController extends GetxController {
   var userId = FirebaseAuth.instance.currentUser!.uid;
  var sellerId = ''.obs;
  RxString termsAr = ''.obs;
  var aboutusEn = ''.obs;
  var aboutusAr = ''.obs;
  var termsEn = ''.obs;
  var privacyAr = ''.obs;
  var privacyEn = ''.obs;
  var returnPolicyAr = ''.obs;
  var returnPolicyEn = ''.obs;
var loadPolicies=false.obs;

  var termsTx = TextEditingController();
  var aboutusEnTx = TextEditingController();
  var aboutusArTx = TextEditingController();
  var termsEnTx = TextEditingController();
  var privacyArTx = TextEditingController();
  var privacyEnTx = TextEditingController();
  var returnPolicyArTx = TextEditingController();
  var returnPolicyEnTx = TextEditingController();
var loadPoliciesTx=TextEditingController();



  void initialValues( String vendorId)async{
    loadPolicies(true);
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
             loadPolicies(false);

if(vendorId==userId){
              termsTx.text=data['terms_ar']??'';
                termsEnTx.text=data['terms_en']??'';
                  aboutusArTx.text=data['about_us_ar']??'';
            aboutusEnTx.text=data['about_us_en']??'';
            privacyArTx.text=data['privacy_ar']??'';
            privacyEnTx.text=data['privacy_en']??'';
            returnPolicyArTx.text=data['return_policy_ar']??'';
             returnPolicyEnTx.text=data['return_policy_en']??'';
                
                
                
                }
  }
  void saveToFirestore(String vendorId) async {
    if (vendorId.isEmpty) {
      TLoader.warningSnackBar(title: '',message: isArabicLocale()?"يجب إدخال معرف التاجر قبل الحفظ!":"There is no user defined" );

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
      TLoader.successSnackBar(title: "✅ نجاح",message: "تم حفظ السياسات الخاصة بالتاجر بنجاح!", duration: 3);
    } catch (e) {
      Get.snackbar("⚠️ خطأ", "حدث خطأ أثناء الحفظ: $e");
    }
  }
}
