import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/editing._controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/market_header_organization.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class HelloClient extends StatelessWidget {
  const HelloClient({
    super.key,
    required this.vendorId,
    required this.editMode,
  });

  final String vendorId;
  final bool editMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          marketHeaderSection(vendorId, editMode, false),
          const SizedBox(
            height: 30,
          ),
          TRoundedContainer(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            enableShadow: true,
            showBorder: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_bag, size: 60, color: Colors.black),
                SizedBox(height: 10),
                Text(
                  isLocaleEn(context) ? "COMING SOON" : "قريبا جدا ",
                  style: titilliumBold.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  isArabicLocale()
                      ? "ترقبوا التفعيل  قريبًا!"
                      : "Wait For Activating Soon",
                  textAlign: TextAlign.center,
                  style:
                      titilliumBold.copyWith(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 15),
                TLoaderWidget(),
              ],
            ),
          ),
          SizedBox(
            height: 130,
          )
        ],
      ),
    );
  }
}
