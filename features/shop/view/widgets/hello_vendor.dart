import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/editing._controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/market_header_organization.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';

class HellowVendor extends StatelessWidget {
  const HellowVendor({
    super.key,
    required this.vendorId,
    required this.editMode,
  });

  final String vendorId;

  final bool editMode;

  @override
  Widget build(BuildContext context) {
     var userId = FirebaseAuth.instance.currentUser!.uid;
    var editingController = Get.put(EditingController());
    return SingleChildScrollView(
      child: Column(
        children: [
          marketHeaderSection(
              vendorId, editingController.localEditing.value, true),
          const SizedBox(
            height: 30,
          ),
          TRoundedContainer(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            enableShadow: true,
            showBorder: true,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.storefront, size: 60, color: Colors.black),
                const SizedBox(height: 10),
                Text(
                  isArabicLocale()
                      ? "ابدأ عملك الخاص الأن"
                      : "Start Your Business Now",
                  style: titilliumBold.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isArabicLocale()
                      ? "قم بإضافة منتجاتك وتصنيفاتك وابدأ البيع الآن!"
                      : "Add Your Categories And Products And Start Selling Now",
                  textAlign: TextAlign.center,
                  style:
                      titilliumBold.copyWith(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (editMode) {
                      editingController.localEditing.value = true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarketPlaceManagment(
                                    vendorId: vendorId,
                                    editMode: vendorId==userId,
                                  )));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(isArabicLocale() ? " إبدأ" : "Start",
                      style:
                          titilliumBold.copyWith(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
