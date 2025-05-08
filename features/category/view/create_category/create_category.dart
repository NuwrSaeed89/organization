import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

import 'widget/create_category_form.dart';

class CreateCategory extends StatelessWidget {
  const CreateCategory({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                title: isLocaleEn(context)
                    ? 'Add New Category'
                    : "اضافة تصنيف جديد"),
            body: CreateCategoryForm()),
      ),
    );
  }
}
