import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/policy_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';


class PolicyPage extends StatelessWidget {
   PolicyPage({super.key,required this.vendorId});

final String vendorId;


  @override
  Widget build(BuildContext context) {
      final PolicyController controller = Get.put(PolicyController());
    return Scaffold(
      appBar: CustomAppBar(title: isArabicLocale()?  "📜 إدارة السياسات":"Terms Managment 📜"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              _buildTextField("🔹 شروط الخدمة (العربية)", controller.termsAr),
              _buildTextField("🔹 شروط الخدمة (الإنجليزية)", controller.termsEn),
              _buildTextField("🔐 سياسة الخصوصية (العربية)", controller.privacyAr),
              _buildTextField("🔐 سياسة الخصوصية (الإنجليزية)", controller.privacyEn),
              _buildTextField("↩️ سياسة الإعادة (العربية)", controller.returnPolicyAr),
              _buildTextField("↩️ سياسة الإعادة (الإنجليزية)", controller.returnPolicyEn),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:()=> controller.saveToFirestore(vendorId),
                child: Text("💾 حفظ السياسات"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, RxString controllerValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [

          TextField(
            decoration: inputTextField.copyWith(labelText: label),
            onChanged: (value) => controllerValue.value = value,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}
