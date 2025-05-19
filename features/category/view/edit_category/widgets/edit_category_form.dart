import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/edit_category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/widget/image_uploader.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';
import 'package:winto/features/organization/e_commerce/utils/validators/validator.dart';

class EditCategoryForm extends StatelessWidget {
   EditCategoryForm({super.key, required this.category});
  final CategoryModel category;
     final CategoryTabControllerX tabController = Get.put(CategoryTabControllerX());
  @override
  Widget build(BuildContext context) {
    final editController = EditCategoryController.instance;
    editController.init(category);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: editController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: TSizes.appBarHeight,
              ),

              const SizedBox(
                height: TSizes.spaceBtWsections,
              ),

              DefaultTabController(
                  initialIndex: isArabicLocale()?0:1,
                length: 2,
                child: Column(
                  children: <Widget>[
                    TabBar(
                        onTap: tabController.changeTab,
                      //backgroundColor: Colors.red,

                      isScrollable: true,

                      // indicatorColor: TColors.red,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 0),

                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: TColors.darkerGray,
                      labelStyle: titilliumSemiBold.copyWith(fontSize: 16),
                      unselectedLabelStyle:
                          titilliumSemiBold.copyWith(fontSize: 16),

                      // indicatorColor: TColors.black,
                      // indicatorSize: TabBarIndicatorSize.label,
                      //borderColor: Colors.black,
                      // labelStyle: Theme.of(context)
                      //     .textTheme
                      //     .bodyLarge!
                      //     .copyWith(color: TColors.black, fontSize: 18),
                      // unselectedLabelStyle: Theme.of(context)
                      //     .textTheme
                      //     .bodyLarge!
                      //     .copyWith(color: TColors.darkGrey, fontSize: 16),
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
                      height: 130,
                      child: TabBarView(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: TSizes.sm,
                              ),
                               Directionality(
                                
                                textDirection: TextDirection.rtl,
                                child: TCustomWidgets.buildLabel('التصنيف *')),

                               Directionality(
                                
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                 focusNode: tabController.arabicFocusNode,
                                  style: titilliumNormal.copyWith(fontSize: 18),
                                  controller: editController.arabicName,
                                  validator: (value) =>
                                      TValidator.validateEmptyText(
                                          "التصنيف", value),
                                  decoration: inputTextField.copyWith(
                                     contentPadding: isArabicLocale()? EdgeInsets.only(right:5):EdgeInsets.only(left:5),
                                  
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: TSizes.sm,
                              ),
                                      TCustomWidgets.buildLabel('Category *'),
                              TextFormField(
                                focusNode: tabController.englishFocusNode,
                                 style: titilliumNormal.copyWith(fontSize: 18),
                                controller: editController.name,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        "Category Name", value),
                                decoration: inputTextField.copyWith(
                                   contentPadding: isArabicLocale()? EdgeInsets.only(right:5):EdgeInsets.only(left:5),
                                
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TCustomWidgets.buildLabel( isArabicLocale() ? 'الصورة' : 'Image'),
              
              Center(
                child: Obx(
                  () => TImageUploader(
                    circuler: true,
                    imageType: editController.localImage.isNotEmpty
                        ? ImageType.file
                        : category.image!.isNotEmpty
                            ? ImageType.network
                            : ImageType.asset,
                    width: 100,
                    height: 100,
                    image: editController.localImage.isNotEmpty
                        ? editController.localImage.value
                        : category.image!.isNotEmpty
                            ? category.image!
                            : TImages.imagePlaceholder,
                    onIconButtonPressed: () => editController.pickImage(),
                  ),
                ),
              ),
              // CheckboxMenuButton(
              //     value: editController.isFeatured.value,
              //     onChanged: (value) =>
              //         editController.isFeatured.value = value ?? false,
              //     child: const Text("featured")),
              const SizedBox(
                height: TSizes.spaceBtwInputFields * 2,
              ),
              CustomButtonBlack(
                  text: isLocaleEn(context) ? 'Post' : 'نشر',
                  onTap: () async {
                    // editController.updateCategory(category);

                    await showSimpleLoadingDialog<String>(
                      context: context,
                      future: () async {
                        await editController.updateCategory(category);
                        return "updated1";
                      },
                      // Custom dialog
                      dialogBuilder: (context, _) {
                        return AlertDialog(
                          content: Obx(
                            () => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                const TLoaderWidget(),
                                const SizedBox(height: 16),
                                Text(editController.message.value),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
