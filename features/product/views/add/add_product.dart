import 'package:flutter/material.dart';
import 'package:winto/app/data.dart';
import 'package:winto/app/providers.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

import 'widgets/create_product_form.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct(
      {super.key,
      required this.sectionId,
      required this.type,
      required this.vendorId});
  String vendorId;
  String sectionId;
  String type;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                title: isLocaleEn(context) ? 'Add Item' : 'إضافة عنصر'), //)),
            body: CreateProductForm(
              vendorId: vendorId,
              sectionId: sectionId,
              type: type,
            )),
      ),
    );
  }
}
