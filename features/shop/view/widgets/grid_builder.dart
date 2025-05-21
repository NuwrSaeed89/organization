import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';

import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_vendor_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class GridBuilder extends StatelessWidget {
  GridBuilder({
    super.key,
    required this.vendorId,
    required this.editMode,
  });

  final String vendorId;
  final bool editMode;
  var showMore = true.obs;
  @override
  Widget build(BuildContext context) {

      var floatControllerVendor =
      Get.put(FloatingButtonsController());
      floatControllerVendor.isEditabel=editMode;
   RxList<ProductModel> spotList = <ProductModel>[].obs;
    var controller = ProductController.instance;
    controller.fetchOffersData(vendorId, 'newArrival');
    spotList.value= controller.newArrivalDynamic;
//   if (controller.isLoading.value)
   
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child:   
            
            
             Obx(()=>

             controller.isLoading.value?
                MasonryGridView.count(
                itemCount: 9,
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return TRoundedContainer(
                    width: 33.3.w,
                    height: 33.3.w*(4/3),
                    showBorder: true,
                    borderWidth: 1,
                    borderColor: TColors.white,
                    child: TShimmerEffect(
                      width: 33.3.w,
                     
                    height: 33.3.w*(4/3),
                      raduis: BorderRadius.circular(0),
                    ),
                  );
                },
                           ):
             
          
     //loading finish
        
             controller.newArrivalDynamic.isEmpty 
                
                
                
                ? editMode?
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TCustomWidgets.buildTitle(
                          isArabicLocale() ? 'وصلنا حديثا' : 'New Arrival'),
                      const SizedBox(
                        height: TSizes.spaceBtWItems,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: MasonryGridView.count(
                          itemCount: 12,
                          crossAxisCount: 3,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                  
                                   var controller =Get.put(ProductController());
                    controller.deleteTempItems();
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateProduct(
                                                vendorId: vendorId,
                                                type: 'newArrival',
                                                initialList: [],
                                                sectionId: 'all',
                                                sectorTitle: SectorModel(name: 'newArrival', englishName: 'New Arrival', arabicName: 'وصلنا حديثا'),
                                              )));},
                                  child: TRoundedContainer(
                                    width: 33.3.w,
                height: 33.3.w*(4/3),
                                    borderColor: TColors.grey,
                                    showBorder: true,
                                    borderWidth: 1,
                                    child: Visibility(
                                      visible: index == 0,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: TRoundedContainer(
                                            enableShadow: true,
                                            width: 50,
                                            height: 50,
                                            radius: BorderRadius.circular(300),
                                            child: const Icon(
                                              CupertinoIcons.add,
                                              color: TColors.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  )
                : const SizedBox.shrink()
         : 


            
             (spotList.length < 3 &&!editMode)? SizedBox.shrink():
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TCustomWidgets.buildTitle(
                      isArabicLocale() ? 'وصلنا حديثا' : 'New Arrival'),
                  const SizedBox(
                    height: TSizes.spaceBtWItems,
                  ),
                  Stack(
                    children: [
              
                        (spotList.length < 3  &&!editMode)?
                        SizedBox.shrink():
                      (spotList.length > 12 && showMore.value)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: MasonryGridView.count(
                                    itemCount:  editMode? spotList.sublist(0, 12).length+2:spotList.sublist(0, 12).length,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    padding: const EdgeInsets.all(0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      if(editMode && index == spotList.sublist(0, 12).length+1){
                return GestureDetector(
                   onTap: () {
                                 var controller =Get.put(ProductController());
                  controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                            vendorId: vendorId,
                                            type: 'mixlin1',
                                            sectorTitle: SectorModel(name: 'newArrival', englishName: 'New Arrival', arabicName: 'وصلنا حديثا'),
                                              initialList: [],
                                            sectionId: 'all',
                                          )));},
                  child: emptyMedium(33.3.w*(4/3), 33.3.w));}
              
              if(editMode && index == spotList.sublist(0, 12).length){
                return GestureDetector(
                   onTap: () {
                                 var controller =Get.put(ProductController());
                  controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                        sectorTitle: SectorModel(name: 'newArrival', englishName: 'New Arrival', arabicName: 'وصلنا حديثا'),
                                              initialList: [],
                                            vendorId: vendorId,
                                            type: 'mixlin1',
                                            sectionId: 'all',
                                          )));},
                  child: emptyMedium(33.3.w*(4/3), 33.3.w));}
              
                                      return GestureDetector(
                                             onLongPressStart: (details) {
                          if(editMode){
               floatControllerVendor.product=spotList.sublist( 0, 12)[index];
              floatControllerVendor.showFloatingButtons(context, details.globalPosition);
                          }else{
              
               
                          }
                         
                          },
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration: const Duration(
                                                    milliseconds: 1000),
                                                pageBuilder:
                                                    (context, anim1, anim2) =>
                                                        ProductDetails(
                                                  product: spotList.sublist(
                                                      0, 12)[index],
                                                  vendorId: vendorId,
                                                ),
                                              ));
                                        },
                                        child: TRoundedContainer(
                                          width: 141,
                                          height: 191,
                                          showBorder: true,
                                          borderWidth: 1,
                                          borderColor: TColors.white,
                                          child: CustomCaChedNetworkImage(
                                              width: 141,
              
                                              enableShadow: false,
                                              height: 191,
                                              raduis: BorderRadius.circular(0),
                                              url: spotList
                                                  .sublist(0, 12)[index]
                                                  .images!
                                                  .first),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: showMore.value,
                                  child: GestureDetector(
                                    onTap: () => showMore.value = false,
                                    child: TRoundedContainer(
                                        width: 100.w,
                                        backgroundColor: TColors.grey,
                                        height: 40,
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              isLocaleEn(context)
                                                  ? "Show More"
                                                  : "عرض المزيد",
                                              style: titilliumBold.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            const Icon(
                                              CupertinoIcons.arrow_down_circle,
                                              color: Colors.black,
              
                                              // SvgPicture.asset(
                                              //   'assets/images/ecommerce/icons/arrowdown.svg',
                                              //   width: 7,
                                              //   height: 12,
                                              // ),
                                            )
                                          ],
                                        ))),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: MasonryGridView.count(
                                    itemCount:editMode? 12: spotList.length,//editMode? spotList.length+2:spotList.length,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    padding: const EdgeInsets.all(0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      if(editMode && index >= spotList.length){
                return InkWell(
                   onTap: () {
                                 var controller =Get.put(ProductController());
                  controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                        sectorTitle: SectorModel(name: 'newArrival', englishName: 'New Arrival', arabicName: 'وصلنا حديثا'),
                                              initialList: spotList,
                                            vendorId: vendorId,
                                            type: 'newArrival',
                                            sectionId: 'all',
                                          )));},
                  child: emptyMedium( 33.3.w*(4/3), 33.3.w));}
              
              // if(editMode && index == spotList.length){
              //   return GestureDetector(
              //      onTap: () {
              //                                  var controller =Get.put(ProductController());
              //     controller.deleteTempItems();
              //                                Navigator.push(
              //                                   context,
              //                                   MaterialPageRoute(
              //                                       builder: (context) => CreateProduct(
              //                                             vendorId: vendorId,
              //                                        type: 'newArrival',
              //                                             sectionId: 'all',
              //                                           )));},
              //     child: emptyMedium(   44.7.w, 33.3.w
              //                                            ));}
              
                                      return GestureDetector(
                                             onLongPressStart: (details) {
                          if(editMode){
               floatControllerVendor.product=spotList[index];
              floatControllerVendor.showFloatingButtons(context, details.globalPosition);
                          
                          }
                         
                          },
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration: const Duration(
                                                    milliseconds: 1000),
                                                pageBuilder:
                                                    (context, anim1, anim2) =>
                                                        ProductDetails(
                                                  product: spotList[index],
                                                  vendorId: vendorId,
                                                ),
                                              ));
                                        },
                                        child: TRoundedContainer(
                                        width: 33.333.w,
                                        height: 33.3.w*(4/3),
                                          showBorder: true,
                                          borderWidth: 1,
                                          borderColor: TColors.white,
                                          // showBorder: true,
                                          child: CustomCaChedNetworkImage(
                                            
                                             width: 33.3.w,
                  height: 33.3.w*(4/3),
                                              enableShadow: false,
                                              raduis: BorderRadius.circular(0),
                                              url: spotList[index].images!.first),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      !showMore.value && spotList.length > 12,
                                  child: GestureDetector(
                                    onTap: () => showMore.value = true,
                                    child: TRoundedContainer(
                                        width: 100.w,
                                        backgroundColor: TColors.grey,
                                        height: 40,
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              isLocaleEn(context)
                                                  ? "Show Less"
                                                  : "عرض أقل",
                                              style: titilliumBold.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            const Icon(
                                              CupertinoIcons.arrow_up_circle,
                                              color: Colors.black,
              
                                              // SvgPicture.asset(
                                              //   'assets/images/ecommerce/icons/arrowdown.svg',
                                              //   width: 7,
                                              //   height: 12,
                                              // ),
                                            )
                                          ],
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                      Visibility(
                        visible: false,
                        child: Positioned(
                            bottom: 40,
                            right: isArabicLocale() ? null : 8,
                            left: isArabicLocale() ? 8 : null,
                            child: CustomFloatActionButton(
                              onTap: () {
                                
                                 var controller =Get.put(ProductController());
                  controller.deleteTempItems();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                            vendorId: vendorId,
                                            sectorTitle: SectorModel(name: 'newArrival', englishName: 'New Arrival', arabicName: 'وصلنا حديثا'),
                                              initialList: spotList,
                                            type: 'newArrival',
                                            sectionId: 'all',
                                          )));},
                            )),
                      )
                    ],
                  ),
                ],
              )));
          }
        }
  

  Widget emptyMedium( double cardHeight,double cardWidth) {
return   SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
         TRoundedContainer(
           borderColor: TColors.grey,
           showBorder: true,
          // enableShadow: true,
           height: cardHeight  ,
           width: cardWidth,
           radius: BorderRadius.circular(0),
         ),
         
        ],
      ),
    );

  }

