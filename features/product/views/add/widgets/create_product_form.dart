import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/helpers/helper_functions.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';
import 'package:winto/features/organization/e_commerce/utils/validators/validator.dart';

class CreateProductForm extends StatelessWidget {
  CreateProductForm(
      {super.key,
      required this.sectionId,
      required this.type,
      required this.vendorId});
  // CategoryModel? suggestingCategory;

  String vendorId;
  String sectionId;
  String type;
  @override
  Widget build(BuildContext context) {
      final CategoryTabControllerX tabController = Get.put(CategoryTabControllerX());
    final controller = ProductController.instance;

    //if (suggestingCategory != null) controller.category = suggestingCategory!;
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            // Center(
            //   child: Text(
            //     isArabicLocale() ? 'اضافة عنصر' : "Add Item",
            //     style: titilliumSemiBold.copyWith(
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('product.title'),
                      style: titilliumSemiBold.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: TSizes.sm),
                    const Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    TabBar(
                            onTap: tabController.changeTab,
                      //  indicator: BoxDecoration(),

                      // indicatorColor: TColors.red,
                      isScrollable: true,

                      // indicatorColor: TColors.red,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),

                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: TColors.darkerGray,
                      labelStyle: titilliumSemiBold.copyWith(fontSize: 16),
                      unselectedLabelStyle:
                          titilliumSemiBold.copyWith(fontSize: 16),
                      tabs: const [
                        Tab(
                          text: "عربي",
                        ),
                        Tab(text: "English")
                      ],
                    ),
                    SizedBox(
                      height: 170,
                      child: TabBarView(
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                TextFormField(
                                   focusNode: tabController.arabicFocusNode,
                                  style: titilliumBold.copyWith(fontSize: 18),
                                  controller: controller.arabicTitle,
                                  validator: (value) =>
                                      TValidator.validateEmptyText(
                                    'عنوان',
                                    value,
                                  ),
                                  decoration: inputTextField.copyWith(
                                    labelStyle: titilliumSemiBold,
                                    labelText: ' عنوان *',
                                  ),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                TextFormField(
                                  style: titilliumBold.copyWith(fontSize: 18),
                                  controller: controller.arabicDescription,
                                  maxLines: 3,
                                  decoration: inputTextField.copyWith(
                                    labelStyle: titilliumSemiBold,
                                    // prefixIcon: const Icon(Icons.edit_document),
                                    labelText: 'وصف',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              TextFormField(
                                   focusNode: tabController.englishFocusNode,
                                style: titilliumBold.copyWith(
                                  fontSize: 18,
                                ),
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                  'title *',
                                  value,
                                ),
                                controller: controller.title,
                                decoration: inputTextField.copyWith(
                                  labelText: 'title',
                                  labelStyle: titilliumSemiBold,
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwInputFields,
                              ),
                              TextFormField(
                                style: titilliumBold.copyWith(fontSize: 18),
                                controller: controller.description,
                                maxLines: 3,
                                decoration: inputTextField.copyWith(
                                  // prefixIcon: const Icon(Icons.edit_document),
                                  labelText: 'Description',
                                  labelStyle: titilliumSemiBold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TCustomWidgets.buildDivider(),

            const SizedBox(
              height: TSizes.spaceBtWItems,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CategoryController.instance.isLoading.value
                  ? const TShimmerEffect(width: double.infinity, height: 55)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: THelperFunctions.screenwidth() - 100,
                          child: Obx(() {
                            List<CategoryModel> dropdownItems =
                                CategoryController.instance.allItems;

                            return DropdownButtonFormField2(
                              // value: suggestingCategory,
                              decoration: inputTextField.copyWith(
                                labelStyle: titilliumSemiBold,
                                labelText:
                                    isArabicLocale() ? 'التصنيف' : 'Category',
                              ),

                              items: dropdownItems.map((cat) {
                                return DropdownMenuItem(
                                    value: cat,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          isLocaleEn(context)
                                              ? cat.name
                                              : cat.arabicName,
                                          style: titilliumSemiBold,
                                        )
                                      ],
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                              
                                  controller.category =
                                      newValue!;}
                            );
                            
                          }),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateCategory(
                                        vendorId: vendorId,
                                      ))),
                          child: const Icon(
                            CupertinoIcons.add_circled,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
            ),

            // const SizedBox(height: TSizes.spaceBtwInputFields),
            // TextFormField(
            //   controller: controller.skucode,
            //   decoration: InputDecoration(
            //     labelStyle: titilliumSemiBold,
            //     // prefixIcon: const Icon(Icons.edit_document),
            //     labelText: isLocaleEn(context)
            //         ? 'code like Ex: 456565'
            //         : "رمز العنصر مثلا : 33366",
            //   ),
            // ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: titilliumSemiBold.copyWith(fontSize: 22),
                      controller: controller.price,
                      validator: (value) =>
                          TValidator.validateEmptyText('price', value),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: inputTextField.copyWith(
                        labelStyle: titilliumSemiBold,
                        // prefixIcon: const Icon(Icons.edit_document),
                        labelText: isLocaleEn(context) ? 'price' : 'السعر',
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      style: titilliumSemiBold.copyWith(fontSize: 22),
                      controller: controller.salePrice,
                      // autovalidateMode: AutovalidateMode.onUnfocus,
                      validator: (value) => TValidator.validateSaleprice(
                          value, controller.price.text),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: inputTextField.copyWith(
                        // prefixIcon: const Icon(Icons.edit_document),
                        labelStyle: titilliumSemiBold,
                        labelText:
                            isLocaleEn(context) ? 'Sale Price' : 'سعر التخفيض',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtWsections),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    isArabicLocale() ? 'الصور' : 'Images',
                    style: titilliumSemiBold,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtWItems),
                Obx(
                  () => Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              children: [
                                controller.selectedImage.isNotEmpty
                                    ? SizedBox(
                                        height: 370,
                                        child: Obx(
                                          () => ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                controller.selectedImage.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () => controller
                                                    .cropImage(controller
                                                        .selectedImage[index]
                                                        .path),
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding: isArabicLocale()
                                                          ? EdgeInsets.only(
                                                              left: index ==
                                                                      controller
                                                                              .selectedImage
                                                                              .length -
                                                                          1
                                                                  ? 16
                                                                  : 0,
                                                              right: 16)
                                                          : EdgeInsets.only(
                                                              right: index ==
                                                                      controller
                                                                              .selectedImage
                                                                              .length -
                                                                          1
                                                                  ? 16
                                                                  : 0,
                                                              left: 16),
                                                      child: TRoundedContainer(
                                                        width: 257,
                                                        height: 342,
                                                        showBorder: true,
                                                        radius: BorderRadius
                                                            .circular(15),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Image.file(
                                                            File(controller
                                                                .selectedImage[
                                                                    index]
                                                                .path),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 16,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            controller
                                                                .selectedImage
                                                                .removeAt(
                                                                    index),
                                                        icon: TRoundedContainer(
                                                          width: 30,
                                                          height: 30,
                                                          radius: BorderRadius
                                                              .circular(40),
                                                          backgroundColor:
                                                              TColors.black
                                                                  .withValues(
                                                                      alpha:
                                                                          .5),
                                                          child: const Icon(
                                                            Icons.close_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          controller.takeCameraImages(),
                                      child: Center(
                                        child: TRoundedContainer(
                                            width: 60,
                                            height: 60,
                                            showBorder: true,
                                            radius: BorderRadius.circular(50),
                                            child: const Center(
                                                child: Icon(
                                                    CupertinoIcons.photo_camera,
                                                    size: 30))),
                                      ),
                                    ),
                                    const SizedBox(width: TSizes.spaceBtWItems),
                                    GestureDetector(
                                      onTap: () => controller.selectImages(),
                                      child: Center(
                                        child: TRoundedContainer(
                                            width: 60,
                                            height: 60,
                                            showBorder: true,
                                            radius: BorderRadius.circular(50),
                                            child: const Center(
                                                child: Icon(
                                                    CupertinoIcons.photo_fill,
                                                    size: 30))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),
            // Text(createController.message.value),
            // Obx(() => Text(createController.message.value)),
            SizedBox(
              width: double.infinity,
              child: CustomButtonBlack(
                text: isArabicLocale() ? 'نشر' : 'Post',
                // text: AppLocalizations.of(
                //   context,
                // ).translate('product.createProduct'),
                onTap: () async {
                  if (controller.formKey.currentState!.validate()) {
                    await showSimpleLoadingDialog<String>(
                      context: context,
                      future: () async {
                        await controller.createProduct(type, vendorId);
                        return "done2";
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
                                Text(
                                  controller.message.value,
                                  style: titilliumBold,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            // const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
