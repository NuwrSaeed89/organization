import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

import 'widgets/edit_category_form.dart';

class EditCategory extends StatelessWidget {
   EditCategory({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(
                title:
                    isLocaleEn(context) ? 'update Category' : "تعديل التصنيف "),
            body: EditCategoryForm(category: category)),
      ),
    );
  }
}
