import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/product_tab_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/scrolle_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
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
const double padding=8;
      final ScrolleEditController scrolleController = Get.put(ScrolleEditController());
     var addCat=CategoryModel(name: 'Add New Category', arabicName: 'اضف تصنيف جديد');
     // EditProductController.instance.init(product);
          final ProductTabControllerX tabController = Get.put(ProductTabControllerX());
    final controller = EditProductController.instance;
   // var images = product.images!;
    if (CategoryController.instance.allItems.isEmpty) {
      
      CategoryController.instance.fetchCategoryData();
    }

    controller.type = product.productType ?? '';
  var initial= controller.category;
    return SingleChildScrollView(
       controller: scrolleController.scrollController, 
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DefaultTabController(
                  initialIndex: isArabicLocale()?0:1,
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
                                TCustomWidgets.buildLabel('Title '),
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

            Row(
              children: [
                SizedBox(width: 8,),
                Row(
               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    TCustomWidgets.buildLabel( isArabicLocale() ? 'التصنيف' : 'Category',),  
                   
                    // TCustomWidgets.buildLabel(isArabicLocale()? controller.category.arabicName:controller.category.name)
                  ],
                ),
              ],
            ),
  Visibility(
    visible: false,
    child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CategoryController.instance.isLoading.value
                    ? const TShimmerEffect(width: double.infinity, height: 55)
                    : Center(
                     
                      child: Obx(() {
                      
                    
                        return DropdownButtonFormField(
                          
                            borderRadius: BorderRadius.circular(15),
                            iconSize: 40,
                             
                       // value:controller.selectedCategory.value,
                          decoration: inputTextField,
                    
                          items: CategoryController.instance.allItems.map((cat) {
                            return DropdownMenuItem(
                                value: cat,
                                child:
                                Row(
                                          children: [
                    ClipOval
                                           (
                    
                    child: Image.network(cat.image!, width: 40, height:40, fit: BoxFit.cover)),
                    SizedBox(width: 10),
                    Text(isArabicLocale()? cat.arabicName: cat.name,style: titilliumRegular, ),
                                          ],
                                        ),
                                
                              
                                );
                          }).toList()..add(
                                      DropdownMenuItem(
                                        value:addCat,
                                        child: Row(
                                          children: [
                    Icon(Icons.add, color: Colors.blue),
                    SizedBox(width: 10),
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
                              controller.selectedCategory.value =
                                  newValue!;}
                      });
                        
                      }),
                    ),
              ),
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
                        value:  controller.selectedCategory.value.id!.isNotEmpty? controller.selectedCategory.value:null,
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
                                              Text(CategoryController.instance.getAvilableCategoryTitle(cat),style: titilliumRegular.copyWith(fontSize: 16), ),
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
        
                

SizedBox(height: TSizes.spaceBtWsections,),
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
                                             
                                 onChanged: controller.formatInput,            
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
                               child: Text(isLocaleEn(context) ? 'Discount %' : '%نسبة الخصم', style:   titilliumBold.copyWith(fontSize: 13)),
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
                                 
                                               //  onChanged: (value) => controller.validateDiscountPrice(value),
                              style: titilliumBold.copyWith(
                                              color: TColors.darkGrey,fontFamily: 'Poppins',
                                             decoration: TextDecoration.lineThrough,
                                            //  decorationStyle: ,
                                              decorationThickness: 1.5,
                                              fontSize: 18),
                                onChanged: (value) =>  controller.changeSalePresentage(value),
                                
                              controller: controller.oldPrice,
                            // autovalidateMode: AutovalidateMode.onUnfocus,
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
        
              

            const SizedBox(height: TSizes.spaceBtwInputFields),
             TCustomWidgets.buildLabel( isArabicLocale() ? 'الصور' : 'Images',),
           
            const SizedBox(height: TSizes.spaceBtWItems),

            Obx(()=>
        
          
              Column(
                 
                  children: [
                       (controller.initialImage.isNotEmpty)  ?
                    SizedBox(
                height: 310,
                    child: Center(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(width: 8,),
                      
                        itemCount: controller.initialImage.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Stack(
                          children: [
                            Padding(
                              padding: isLocaleEn(context)? EdgeInsets.only(left:8.0) : EdgeInsets.only(right:8.0),
                              child: SizedBox(
                                  width: 220,
                                  height:220*(4/3),
                                  child: CustomCaChedNetworkImage(
                                          width: 220,
                                  height:220*(4/3),
                                      url: controller.initialImage[index],
                                      raduis: BorderRadius.circular(15))
                                  //  Image.network(
                                  //   image,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  ),
                            ),
                            Positioned(
                              top: 0,
                              right: 10,
                              child: IconButton(
                                onPressed: () {
                                  controller.initialImage.removeAt(index);
                                  
                                  // product.images!.(index);
                                   },
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
                  ) :SizedBox.shrink(),
                               
                                 controller.selectedImage.isNotEmpty?
                                    SizedBox(
                height: 280,
                                    child: Obx(()=>
                                       ListView.builder(
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
                                                      left: padding),
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
                                                  child: Image.file(
                                                      File(controller
                                                          .selectedImage[
                                                              index]
                                                          .path),
                                                      fit:
                                                          BoxFit.contain),
                                                ),
                                              ),
                                            ),
                                            
                                           Positioned(
                                            left: padding,
                                            bottom: padding,
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
        
                                            Positioned(
                                              top: padding,
                                              right: padding,
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
                             : SizedBox.shrink(),
                    
                  ],
                )),
                  
                     
                          
                        
            
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
          
            const SizedBox(height: TSizes.spaceBtwInputFields),
            // Text(createController.message.value),
            // Obx(() => Text(createController.message.value)),
            SizedBox(
              width: double.infinity,
              child: CustomButtonBlack(
                text:isArabicLocale()?'نشر': 'Post',
              
                onTap: ()async  {
      
      
                      
                            await  controller.updateProduct(product, vendorId);
                          
                            },  ),
            ),
            const SizedBox(height: 32),
   ])));
        
  
    
  }
}
