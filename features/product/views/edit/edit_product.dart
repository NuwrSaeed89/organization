import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/scrolle_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/edit/widgets/edit_product_form.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

class EditProduct extends StatelessWidget {
  const EditProduct({super.key, required this.product, required this.vendorId});
  final ProductModel product;
  final String vendorId;
  @override
  Widget build(BuildContext context) {

    return  Directionality(
      textDirection: isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          appBar: CustomAppBar(
              title: isLocaleEn(context) ? 'Edit Item' : 'تعديل العنصر'),
          body: SafeArea(
            child: EditProductForm(
              product: product,
              vendorId: vendorId,
            ),
          )),
    );
  }
}
