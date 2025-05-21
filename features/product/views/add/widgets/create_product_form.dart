import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/product_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/widget/create_category_form.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/scrolle_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/sector_builder.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/helpers/helper_functions.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';
import 'package:winto/features/organization/e_commerce/utils/validators/validator.dart';

class CreateProductForm extends StatelessWidget {
  CreateProductForm(
      {super.key,
      required this.sectionId,
      required this.type,
      required this.initialList,
     required  this.sectorTitle               ,
 
      required this.vendorId, required this.viewCategory});
  // CategoryModel? suggestingCategory;

  String vendorId;
  String sectionId;
  String type;
   bool viewCategory;
  SectorModel sectorTitle;
   List<ProductModel> initialList;
  @override
  Widget build(BuildContext context) {
    
    const double padding=8;
    // RxList<ProductModel> spotList = <ProductModel>[].obs;
    // spotList.value=initialList;
    RxDouble rotationAngle = 0.0.obs;
     final ScrolleEditController scrolleController = Get.put(ScrolleEditController());
    var addCat=CategoryModel(name: 'Add New Category', arabicName: 'اضف تصنيف جديد');
      final ProductTabControllerX tabController = Get.put(ProductTabControllerX());
    final controller =Get.put(ProductController());
    controller.spotList.value=initialList;

 String? selectedCategoryId;
    //if (suggestingCategory != null) controller.category = suggestingCategory!;
    return Stack(
      children: [
       
        SingleChildScrollView(
            controller: scrolleController.scrollController, 
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                // Center(
                //   child: Text(
                //     isArabicLocale() ? 'اضافة عنصر' : "Add Item",
                //     style: titilliumSemiBold.copyWith(
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
             //  viewTempProducts(vendorId),
              //if(sectorTitle != SectorModel.empty()) TCustomWidgets.buildTitle(isArabicLocale()?sectorTitle.arabicName: sectorTitle.englishName),
        
        //  if(sectorTitle != SectorModel.empty()) SectorBuilder(
        //            cardWidth: 127,
        //             cardHeight: 170,
        //             withTitle:true,
        //             sectorTitle: sectorTitle,
        //             sctionTitle: 'all',
        //             vendorId: vendorId,
        //             editMode: false,
        //             cardType:CardType.smallCard,
               
        //             withPadding: true,
              
          
        //           ),
          Obx(()=>
           controller.spotList.isNotEmpty ?
           Padding(
        padding: EdgeInsets.only(top:20,bottom: 20),
         child: TCustomWidgets.buildTitle(isArabicLocale()
                              ? sectorTitle.arabicName
                              : sectorTitle.englishName),
           ):SizedBox.shrink()
          ),
         Obx(()=>
           controller.spotList.isNotEmpty ?
           
            SizedBox(
             height: 285,
             child:  ListView.builder(
                                // padding: EdgeInsets.symmetric(vertical: 5),
                                scrollDirection: Axis.horizontal,
                                itemCount:  controller.spotList.length,
                                itemBuilder: (context, index) {
              return Padding(
                                      padding: isLocaleEn(context)
                                          ? EdgeInsets.only(
                                              left: padding,
                                              bottom: 20,
                                              right:
                                                  index == controller.spotList.length - 1 ?padding : 0)
                                          : EdgeInsets.only(
                                              right: padding,
                                              bottom: 20,
                                              left: index == controller.spotList.length - 1
                                                  ?padding
                                                  : 0),
                                      child: SizedBox(
                                          width: 127,
                                           height: 127*(4/3)+10,
                                        child: GestureDetector(
                              
                                          onTap: () => Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(milliseconds: 1000),
                                                pageBuilder: (context, anim1, anim2) =>
                                                    ProductDetails(
                                                  product: controller.spotList[index],
                                                  vendorId: vendorId,
                                                ),
                                              )),
                                          child: 
                                             
                                                   ProductWidgetSmall(
                                                    
                                                      product: controller.spotList[index],
                                                      vendorId: vendorId,
                                                    )
                                                 
                                        ),
                                      ),
                                    );}
             ),
        
             
             )
            :const SizedBox.shrink()
           ),
         
        
         
        
        
        
                // const SizedBox(
                //   height: 20,
                // ),
               
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DefaultTabController(
                      initialIndex: isArabicLocale()?0:1,
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
                          height: 210,
                          child: TabBarView(
                            children: <Widget>[
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                     TCustomWidgets.buildLabel('عنوان'),
                                    TextFormField(
                                       focusNode: tabController.arabicFocusNode,
                                      style: titilliumNormal.copyWith(fontSize: 18),
                                      controller: controller.arabicTitle,
                                      onChanged: (value) => controller.a=value,
                                      // validator: (value) =>
                                      //     TValidator.validateEmptyText(
                                      //   'عنوان',
                                      //   value,
                                      // ),
                                      decoration: inputTextField
                                    
                                      
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    TCustomWidgets.buildLabel('وصف'),
                                    TextFormField(
                                      style: titilliumNormal.copyWith(fontSize: 16),
                                      controller: controller.arabicDescription,
                                      maxLines: 3,
                                      decoration: inputTextField.copyWith(
                                        labelStyle: titilliumSemiBold,
                                        // prefixIcon: const Icon(Icons.edit_document),
                                   
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                    TCustomWidgets.buildLabel('Title'),
                                  TextFormField(
                                       focusNode: tabController.englishFocusNode,
                                    style: titilliumNormal.copyWith(
                                      fontSize: 18,
                                    ),
                                      onChanged: (value) => controller.t=value,
                                    // validator: (value) =>
                                    //     TValidator.validateEmptyText(
                                    //   'title *',
                                    //   value,
                                    // ),
                                    controller: controller.title,
                                    decoration: inputTextField
                                     
                                     
                                    
                                  ),
                                  const SizedBox(
                                    height: TSizes.spaceBtwInputFields,
                                  ),
                                   TCustomWidgets.buildLabel('Description'),
                                  TextFormField(
                                    style: titilliumNormal.copyWith(fontSize: 16),
                                    controller: controller.description,
                                    maxLines: 3,
                                    decoration: inputTextField
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
                // TCustomWidgets.buildDivider(),
        
                // const SizedBox(
                //   height: TSizes.spaceBtWItems,
                // ),
               
                Row(
                  children: [
                    const SizedBox(width: 8,),
                    TCustomWidgets.buildLabel( isArabicLocale() ? 'التصنيف' : 'Category',),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CategoryController.instance.isLoading.value
                      ? const TShimmerEffect(width: double.infinity, height: 55)
                      : Center(
                       
                        child: Obx(() {
                         
                              
                      
                          return SizedBox(
                            height: 80,
                            child: DropdownButtonFormField(
        
                              borderRadius: BorderRadius.circular(15),
                              iconSize: 40,
                               decoration: inputTextField,
                              itemHeight: 60, // 
                            
                              items: CategoryController.instance.allItems.map((cat) {
                                return DropdownMenuItem(
                                
                                    value: cat,
                                    child:
                                    Row(
                                              children: [
                                              ClipRRect
                                               (
                                              borderRadius: BorderRadius.circular(300),
                                              child: SizedBox(
                                              height: 40,child: Image.network(cat.image!, width: 40, height: 40, fit: BoxFit.cover))),
                                              const SizedBox(width: 10),
                                              Text(isArabicLocale()? cat.arabicName: cat.name,style: titilliumRegular.copyWith(fontSize: 16), ),
                                              ],
                                            ),
                                  
                                    );
                              }).toList()..add(
                                          DropdownMenuItem(
                                            value:addCat,
                                            child: Row(
                                              children: [
                                              const Icon(Icons.add, color: Colors.blue),
                                              const SizedBox(width: 10),
                                              Text( isArabicLocale()? "إضافة تصنيف جديد":"Add New Category", style: titilliumRegular.copyWith(color: Colors.blue)),
                                              ],
                                            ),
                              )),
                              onChanged: (newValue) {
                               if (newValue == addCat) {
                                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateCategory(
                                        vendorId: vendorId,
                                      )));
                                          }else{
                                  controller.category =
                                      newValue!;}
                                                }),
                          );
                          
                        }),
                      ),
                ),
        
                
                const SizedBox(height: TSizes.spaceBtwInputFields ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                     
                        child: Column(
                          children: [
                             TCustomWidgets.buildLabel( isLocaleEn(context) ? 'Sale Price *' : ' سعر البيع *'),
                            TextFormField(
                              style: titilliumNormal.copyWith(fontSize: 20, color: TColors.primary,fontFamily: 'Poppins'),
                                             
                                            
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
                              
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwInputFields),
                      Expanded(
                        flex: 1,
                        
                  
                        child: Column(
                          children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom: 8.0),
                               child: Text(isLocaleEn(context) ? 'Discount %' : '%نسبة الخصم', style:   titilliumBold.copyWith(fontSize: 10)),
                             ),
                             
                            TextFormField(
                              
                              controller: controller.saleprecentage,
                              onChanged: (value) =>  controller.changePrice(value),
                              style: titilliumBold.copyWith(fontSize: 20,fontFamily: 'Poppins'),keyboardType: TextInputType.number,
                            decoration: inputTextField.copyWith(
                                // prefixIcon: const Icon(Icons.edit_document),
                                labelStyle: titilliumSemiBold,
                               // label: Text('%')
                              
                              ),
                            
                            ),
                          ],
                        )),
                   const SizedBox(width: TSizes.spaceBtwInputFields),
                      Expanded(
                        flex: 2,
                       
                        child: Column(
                          children: [
                              TCustomWidgets.buildLabel(  isLocaleEn(context) ? 'Price' : 'السعر'),
                            TextFormField(
                                 onChanged: (value) =>  controller.changeSalePresentage(value),
                                               //  onChanged: (value) => controller.validateDiscountPrice(value),
                              style: titilliumBold.copyWith(
                                              color: TColors.darkGrey,fontFamily: 'Poppins',
                                             decoration: TextDecoration.lineThrough,
                                            //  decorationStyle: ,
                                              decorationThickness: 1.5,
                                              fontSize: 18),
                              
                              controller: controller.oldPrice,
                             autovalidateMode: AutovalidateMode.onUnfocus,
                              // validator: (value) => TValidator.validateSaleprice(
                              //     value, controller.price.text),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: inputTextField.copyWith(
                                // prefixIcon: const Icon(Icons.edit_document),
                                labelStyle: titilliumSemiBold,
                             
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: TSizes.spaceBtWsections),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Visibility(
                        visible: controller.selectedImage.isNotEmpty,
                        child: TCustomWidgets.buildLabel( isArabicLocale() ? 'الصور' : 'Images',)),
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
                                            height: 270,
                                            child: Obx(
                                              () => ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount:
                                                    controller.selectedImage.length,
                                                itemBuilder: (context, index) {
                                                  return 
        
           GestureDetector(
                                        onTap: () => controller
                                            .cropImage(controller
                                                .selectedImage[index]
                                                .path),
          child: Stack(
           // alignment: Alignment.bottomLeft,
            children: [
          Padding(
            padding: isArabicLocale()
                ? EdgeInsets.only(
                    left: index ==
                            controller
                                    .selectedImage
                                    .length -
                                1
                        ? padding
                        : 0,
                    right: padding)
                : EdgeInsets.only(
                    right: index ==
                            controller
                                    .selectedImage
                                    .length -
                                1
                        ? padding
                        : 0,
                    left: 16),
            child: TRoundedContainer(
              width: 50.w,
              height: 50.w*(4/3),
              showBorder: true,
              radius: BorderRadius
                  .circular(15),
              child: ClipRRect(
                borderRadius:
                    BorderRadius
                        .circular(15),
                child:GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
          controller.updateRotation(details.rotation);
          controller.updateScale(details.scale);
            },
                                                      // onTap: () => controller
                                                      //     .cropImage(controller
                                                      //         .selectedImage[index]
                                                      //         .path),
                  child: Obx(()=>
                     Transform.rotate(
                            angle: rotationAngle.value,
                      child: Image.file(
                        File(controller
                            .selectedImage[
                                index]
                            .path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          
          Positioned(
              bottom: padding,
            right:padding,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: IconButton(
              onPressed: () => controller  .cropImage(controller
                                                                .selectedImage[index]
                                                                .path),
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
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: padding,
            right:padding,
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
                                SizedBox(height: 15,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 28.0, right: 28,bottom: 28,top:0),
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
        
              //  const SizedBox(height: TSizes.spaceBtwInputFields),
                // Text(createController.message.value),
                // Obx(() => Text(createController.message.value)),
                Visibility(
                  visible: false,
                  child: SizedBox(
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
                       
                        scrolleController.scrollToTop();
                       
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // const SizedBox(height: 100),
              ],
            ),
          ),
        ),
     
      Positioned(
                            bottom: 15,
                            right: isArabicLocale() ? null : 7,
                            left: isArabicLocale() ? 7 : null,
          child: showFloatingButton(controller, context, scrolleController),),
     
      ],
    );
  }

  Widget showFloatingButton(ProductController controller, BuildContext context, ScrolleEditController scrolleController) {
    return SizedBox(
      width: 100,
      height: 40,
      child: FloatingActionButton(
      backgroundColor: Colors.transparent,
      
      elevation: 0,
      foregroundColor: Colors.transparent,
      //focusColor: TColors.primary,
          onPressed: () async {
      
      
                        if (controller.formKey.currentState!.validate()) {
                          // await showSimpleLoadingDialog<String>(
                          //   context: context,
                          //   future: () async {
                           controller.showProgressBar();
                              await controller.createProduct(type, vendorId);
                              Get.closeCurrentSnackbar();
                                scrolleController.scrollToTop();}},
          
      child: Center(
          child: TRoundedContainer(
        enableShadow: true,
        width: 90,
        height: 40,
      backgroundColor: Colors.black,
        radius: BorderRadius.circular(300),
        child: Center(
                
                  child: Text(
                     isArabicLocale() ? 'نشر' : 'Post',style: titilliumBold.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),))
      )),
        ),
    );
  }
}
  
  