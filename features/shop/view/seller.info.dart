import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/policy_page.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class PolicyDisplayPage extends StatelessWidget {
  final String vendorId;


  PolicyDisplayPage({required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: isArabicLocale() ? "سياسات المتجر" : "Store Policies"),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users')
            .doc(vendorId).collection('store_policies').doc(vendorId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: TLoaderWidget());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text(isArabicLocale() ? "لا توجد بيانات متاحة" : "No data available"));
            }
      
            var data = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: [
                 
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Text(isArabicLocale() ? "📜من نحن :" : "About us 📜:", style: titilliumBold),
                         SizedBox(height: 10),
                        Text( isArabicLocale() ? data['about_us_ar']??'':  data['about_us_en']??'',style:titilliumRegular),
                        SizedBox(height: 10),
                         TCustomWidgets.buildDivider(),
                          SizedBox(height: 10),
                        Text(isArabicLocale() ? "🔒 سياسة الخصوصية:" : "🔒 Privacy Policy:", style:titilliumBold),
                         SizedBox(height: 10),
                        Text( isArabicLocale() ? data['privacy_ar']??'':  data['privacy_en']??'',style:titilliumRegular),
                        SizedBox(height: 10),
                            TCustomWidgets.buildDivider(),
                          SizedBox(height: 10),
                        Text(isArabicLocale() ? "🔄 سياسة الإرجاع:" : "🔄 Return Policy:", style: titilliumBold),
                         SizedBox(height: 10),
                        Text( isArabicLocale() ? data['return_policy_ar']:data['return_policy_en'],style:titilliumRegular ),
                        SizedBox(height: 10),
                            TCustomWidgets.buildDivider(),
                          SizedBox(height: 10),
                        Text(isArabicLocale() ? "📜 الشروط والبنود:" : "📜 Terms & Conditions:", style:titilliumBold),
                         SizedBox(height: 10),
                        Text(isArabicLocale()? data['terms_en']    :data['terms_en']  ,style:titilliumRegular    ),
                  //       CustomButtonBlack(text: 'Edit', onTap: ()  =>
                

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PolicyPage(vendorId: vendorId,))) ,)
                      ],
                    ),
                  ),
                
                
                
                 Visibility(
                  visible: vendorId== FirebaseAuth.instance.currentUser!.uid,
                   child: Positioned(
                      bottom: 0,
                      left: isArabicLocale()?16:null,
right: isArabicLocale()?null:16,
                      child: CustomFloatActionButton(  onTap: ()  =>
                                   
                   
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PolicyPage(vendorId: vendorId,)))
                                   , icon: Icons.edit,)),
                 ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
