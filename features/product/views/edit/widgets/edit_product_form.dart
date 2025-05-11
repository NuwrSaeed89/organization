import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';
import 'package:winto/features/organization/e_commerce/utils/validators/validator.dart';

class EditProductForm extends StatelessWidget {
  const EditProductForm(
      {super.key, required this.product, required this.vendorId});
  final ProductModel product;
  final String vendorId;
  
  @override
  Widget build(BuildContext context) {
      EditProductController.instance.init(product);
          final CategoryTabControllerX tabController = Get.put(CategoryTabControllerX());
    final controller = EditProductController.instance;
    var images = product.images!;
    if (CategoryController.instance.allItems.isEmpty) {
      
      CategoryController.instance.fetchCategoryData();
    }

    controller.type = product.productType ?? '';
  
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('product.title'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: TSizes.sm),
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
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
                      tabs: const [Tab(text: "عربي"), Tab(text: "English")],
                    ),
                    SizedBox(
                      height: 220,
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
                                      labelText: 'عنوان'),
                                ),
                                const SizedBox(
                                  height: TSizes.spaceBtwInputFields,
                                ),
                                TextFormField(
                                  
                                  style: titilliumBold.copyWith(fontSize: 18),
                                  controller: controller.arabicDescription,
                                  maxLines: 3,
                                  decoration: inputTextField.copyWith(
                                    // prefixIcon: const Icon(Icons.edit_document),
                                    labelText: 'وصف المنتج',
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
                                style: titilliumBold.copyWith(fontSize: 18),
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                  'product title',
                                  value,
                                ),
                                controller: controller.title,
                                decoration: inputTextField.copyWith(
                                  labelText: 'product title',
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
                                  labelText: 'Product Description',
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

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(() => CategoryController.instance.isLoading.value
                  ? const TShimmerEffect(width: double.infinity, height: 55)
                  : TypeAheadField(
                      builder: (context, ctr, foucsNode) {
                        return TextFormField(
                          style: titilliumBold.copyWith(fontSize: 18),
                          focusNode: foucsNode,
                          controller: controller.categoryTextField,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            //labelText: "Select Category",
                          ),
                        );
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(
                            suggestion.arabicName,
                            style: titilliumBold,
                          ),
                        );
                      },
                      onSelected: (suggestion) {
                        controller.category.value = suggestion;
                        controller.categoryTextField.text =
                            suggestion.arabicName;
                      },
                      suggestionsCallback: (pattern) {
                        return CategoryController.instance.allItems
                            .where((cat) => cat.arabicName.contains(pattern))
                            .toList();
                      },
                    )),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: titilliumBold.copyWith(fontSize: 18),
                      controller: controller.price,
                      validator: (value) =>
                          TValidator.validateEmptyText('price', value),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        // prefixIcon: const Icon(Icons.edit_document),
                        labelText: 'price',
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields / 2),
                  Expanded(
                    child: TextFormField(
                      style: titilliumBold.copyWith(fontSize: 18),
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.salePrice,
                      validator: (value) => TValidator.validateSaleprice(
                          value, controller.price.text),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        // prefixIcon: const Icon(Icons.edit_document),
                        labelText: 'Sale Price',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            const SizedBox(height: TSizes.spaceBtwInputFields),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                isArabicLocale() ? 'الصور' : 'Images',
                style: titilliumSemiBold,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtWItems),

            SizedBox(
              height: 380,
              child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Stack(
                  children: [
                    SizedBox(
                        width: 257,
                        height: 342,
                        child: Padding(
                            padding: isArabicLocale()
                                ? EdgeInsets.only(
                                    left: index == images.length - 1 ? 16 : 0,
                                    right: 16)
                                : EdgeInsets.only(
                                    right: index == images.length - 1 ? 16 : 0,
                                    left: 16),
                            child: CustomCaChedNetworkImage(
                                width: 257,
                                height: 342,
                                url: images[index],
                                raduis: BorderRadius.circular(15)))
                        //  Image.network(
                        //   image,
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: IconButton(
                        onPressed: () => product.images!.removeAt(index),
                        icon: TRoundedContainer(
                          width: 30,
                          height: 30,
                          radius: BorderRadius.circular(100),
                          backgroundColor: TColors.black.withValues(alpha: .5),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Obx(
              () => Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          children: [
                            Column(
                              children: [
                                controller.selectedImage.isNotEmpty
                                    ? SizedBox(
                                        height: 400,
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
                                                              fit:
                                                                  BoxFit.cover),
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
                                    : SizedBox.shrink()
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
                                            child: Center(
                                                child: Icon(
                                                    CupertinoIcons.photo_camera,
                                                    size: 30))),
                                      ),
                                    ),
                                    SizedBox(width: TSizes.spaceBtWItems),
                                    GestureDetector(
                                      onTap: () => controller.selectImages(),
                                      child: Center(
                                        child: TRoundedContainer(
                                            width: 60,
                                            height: 60,
                                            showBorder: true,
                                            radius: BorderRadius.circular(50),
                                            child: Center(
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
                  ],
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            // Text(createController.message.value),
            // Obx(() => Text(createController.message.value)),
            SizedBox(
              width: double.infinity,
              child: CustomButtonBlack(
                text: AppLocalizations.of(
                  context,
                ).translate('product.editProduct'),
                onTap: () async {
                  if (controller.formKey.currentState!.validate()) {
                    await showSimpleLoadingDialog<String>(
                      context: context,
                      future: () async {
                        await controller.updateProduct(product, vendorId);
                        return "done3";
                      },
                      // Custom dialog
                      dialogBuilder: (context, _) {
                        return AlertDialog(
                          content: Obx(
                            () => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                TLoaderWidget(),
                                const SizedBox(height: 16),
                                Text(controller.message.value),
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
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
