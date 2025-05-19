import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/create_category_controller.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/all_category/widgets/category_grid_item.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/edit_category/edit_category.dart';
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

import 'image_uploader.dart';

class CreateCategoryForm extends StatelessWidget {
   CreateCategoryForm({super.key});
  final CategoryTabControllerX tabController = Get.put(CategoryTabControllerX());
  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
tabController.selectedIndex= isArabicLocale()?0.obs:1.obs;
    return SingleChildScrollView(
      child: Form(
        key: createController.formKey,
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: TSizes.appBarHeight,
              ),

 viewTempCategory(),
              DefaultTabController(
                initialIndex: isArabicLocale()?0:1,
                length: 2,
                child: Column(
                  children: <Widget>[
                    TabBar(
                        onTap: tabController.changeTab,
                      
                      isScrollable: true,

                      // indicatorColor: TColors.red,
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
                      height: 110,
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

                              TextFormField(
                                
                                 focusNode: tabController.arabicFocusNode,
                             //     textAlign: TextAlign.right,
                              style: titilliumBold.copyWith(fontSize: 18),
                                controller: createController.arabicName,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return "requered $value";
                                  }
                                  return null;
                                },
                                decoration: inputTextField.copyWith(contentPadding: isArabicLocale()? EdgeInsets.only(right:5):EdgeInsets.only(left:5),
                                )
                                 // contentPadding: EdgeInsets.only(right: 5),
                                
                                
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
                                 style: titilliumBold.copyWith(fontSize: 18),
                                 focusNode: tabController.englishFocusNode,
                                  
                                controller: createController.name,
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return "requered $value";
                                  }
                                  return null;
                                },
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
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
           TCustomWidgets.buildLabel( isArabicLocale() ? 'الصورة' : 'Image'),
             
              Obx(
                () => Visibility(
                  visible: createController.localImage.isEmpty,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => createController.pickImage(),
                      child: Center(
                        child: Visibility(
                          visible: createController.localImage.isEmpty,
                          child: TRoundedContainer(
                              width: 60,
                              height: 60,
                              showBorder: true,
                              radius: BorderRadius.circular(50),
                              child: Center(
                                  child: Icon(CupertinoIcons.photo_fill,
                                      size: 30))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Obx(
                () => Visibility(
                  visible: createController.localImage.isNotEmpty,
                  child: Center(
                    child: TImageUploader(
                      circuler: true,
                      imageType: createController.localImage.isNotEmpty
                          ? ImageType.file
                          : ImageType.asset,
                      width: 150,
                      height: 150,
                      image: createController.localImage.isNotEmpty
                          ? createController.localImage.value
                          : TImages.imagePlaceholder,
                      onIconButtonPressed: () => createController.pickImage(),
                    ),
                  ),
                ),
              ),
            
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              CustomButtonBlack(
                  text: isLocaleEn(context) ? 'Post' : 'نشر',
                  onTap: () async {
                    await showSimpleLoadingDialog<String>(
                      context: context,
                      future: () async {
                        await createController.createCategory();
                        return "add category done";
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
                                Text(createController.message.value, style:titilliumBold),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center viewTempCategory() {
    var controller=CreateCategoryController.instance;
    return Center(
                            child:
                            
                             Obx(
                               ()=> controller.tempItems.isNotEmpty?
                                Container(
                                color: Colors.transparent,
                                height: 120,
                                width: 85 *
                                    (controller.tempItems.length +
                                        0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                     controller.tempItems.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditCategory(category: controller.tempItems[index]))), 
                                      child: TCategoryGridItem(
                                          category: controller.tempItems[index],
                                          editMode: false,
                                        ),
                                    );
                                  },
                                ),
                                                           ):const SizedBox.shrink(),
                             ),
                          );
  }
}


