import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/policy_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';


class PolicyPage extends StatelessWidget {
   PolicyPage({super.key,required this.vendorId});

final String vendorId;


  @override
  Widget build(BuildContext context) {
      final PolicyController controller = Get.put(PolicyController());
      controller.initialValues(vendorId);
    return Scaffold(
      appBar: CustomAppBar(title: isArabicLocale()?  "📜 إدارة السياسات":"Terms Managment 📜"),
      body: 
      
      
      
      
      Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
           DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.symmetric(vertical: 4),

                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: TColors.darkerGray,
                      labelStyle: titilliumSemiBold.copyWith(fontSize: 18),
                      unselectedLabelStyle:
                          titilliumSemiBold.copyWith(fontSize: 16),
                      tabs: [
                        const Tab(
                          text: "عربي",
                        ),
                        const Tab(
                          text: "English",
                        ),
                      ],
                    ),
                    SizedBox(
                     height:2020,
                      child: TabBarView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: TSizes.sm,
                                ),
                              
                                _buildTextField( "🔹من نحن ", controller.aboutusAr),
                                          SizedBox(height: 16),
                                          _buildTextField( "🔹 شروط الخدمة ", controller.termsAr),
                                          SizedBox(height: 16),
                                           _buildTextField("🔐 سياسة الخصوصية ", controller.privacyAr),
                                           SizedBox(height: 16),
                                           _buildTextField("↩️ سياسة الإعادة ", controller.returnPolicyAr),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: TSizes.sm,
                                ),
                               
                                _buildTextField("🔹About Us", controller.aboutusEn),
                                        SizedBox(height: 16),
                                          _buildTextField("🔹Terms Conditions", controller.termsEn),
                                        SizedBox(height: 16),
                                          _buildTextField("🔐 Privacy Policy ", controller.privacyEn),
                                        SizedBox(height: 16),
                                          _buildTextField("↩️ Return Policy ", controller.returnPolicyEn),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              




             // SizedBox(height: 16),
              CustomButtonBlack(
              
                onTap:()=> controller.saveToFirestore(vendorId),
                text:isArabicLocale()? "💾 حفظ السياسات"  :"💾 Save Policies",
            
              ),
                SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
   RxString controllerValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
Text( label, style: titilliumBold.copyWith(fontSize: 18),),
SizedBox(height: TSizes.spaceBtWItems,),
          TextField(
            decoration: inputTextField,
            onChanged: (value) => controllerValue.value = value,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}
