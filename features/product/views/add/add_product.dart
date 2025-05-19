import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

import 'widgets/create_product_form.dart';

class CreateProduct extends StatelessWidget {
  CreateProduct(
      {super.key,
      required this.sectionId,
      required this.type,
      required this.vendorId,
      required this.initialList,
     required this.sectorTitle,
      this.viewCategory=true});
  String vendorId;
  String sectionId;
    SectorModel sectorTitle;
  bool viewCategory;
  String type;
  List<ProductModel> initialList;
  @override
  Widget build(BuildContext context) {
      final controller = ProductController.instance;
    return Directionality(
      textDirection: isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          appBar: 
         CustomAppBar(
              title: isLocaleEn(context) ? 'Add Item ' : 'إضافة عنصر'), //)),
         
          body: SafeArea(
            child: CreateProductForm(
              vendorId: vendorId,
              initialList: initialList,
              sectionId: sectionId,
              type: type,
              sectorTitle:sectorTitle,
              viewCategory: viewCategory,
            ),
          )),
    );
  }
}
