import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_vendor_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class GridBuilderCustomCard extends StatelessWidget {
  GridBuilderCustomCard({
    super.key,
    required this.vendorId,
    required this.editMode,
    this.withoutPadding=false
  });

  final String vendorId;
  final bool editMode;
  final bool withoutPadding;
  var showMore = true.obs;
  @override
  Widget build(BuildContext context) {
    RxList<ProductModel> spotList = <ProductModel>[].obs;
    var controller = ProductController.instance;
    controller.fetchOffersData(vendorId, 'mixlin1');
    spotList = controller.mixline1Dynamic;

      var floatControllerVendor =
      Get.put(FloatingButtonsController());
      floatControllerVendor.isEditabel=editMode;
    // SectorBuilder(
    //   cardWidth: 174,
    //   cardHeight: 226,
    //   sectorTitle: SectorModel(
    //       name: 'mixlin1',
    //       englishName: 'try this',
    //       arabicName: 'جرب هذا'),
    //   sctionTitle: 'all',
    //   vendorId: vendorId,
    //   editMode: editMode,
    //   cardType: CardType.mediumCard,
    // ),
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: MasonryGridView.count(
              itemCount: 8,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return TRoundedContainer(
                  width: 174,
                  height: 226,
                  showBorder: true,
                  borderWidth: 1,
                  radius: BorderRadius.circular(15),
                  borderColor: TColors.white,
                  child: TShimmerEffect(
                    width: 174,
                    height: 226,
                    raduis: BorderRadius.circular(15),
                  ),
                );
              },
            ),
          );
        } else {
          if (spotList.isEmpty) {
            return editMode
                ? Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TCustomWidgets.buildTitle(
                            isArabicLocale() ? 'جرب هذا' : 'try this'),
                              TCustomWidgets.buildDivider(),
                        
                        Padding(
                              padding: const EdgeInsets.only(left:14, right: 14, top:10),
                          child: MasonryGridView.count(
                            itemCount: 8,
                             crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return   Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      
                                      TRoundedContainer(
                                        borderColor: TColors.grey,
                                        showBorder: true,
                                        enableShadow: true,
                                        height: 226 + 100,
                                        width: 174,
                                        radius: BorderRadius.circular(15),
                                      ),
                                      InkWell(
                                        onTap: () {
                                           var controller =Get.put(ProductController());
    controller.deleteTempItems();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CreateProduct(
                                                  initialList: spotList,
                                                        vendorId: vendorId,
                                                         sectorTitle: SectorModel( arabicName: 'جرب هذا',id: '',englishName: 'try this', name: 'mixlin1'),
                                                  type: 'mixlin1',
                                                  sectionId: 'all',
                                                    )));},
                                        child: Stack(
                                           alignment: Alignment.center,
                                          children: [
                                            TRoundedContainer(
                                              showBorder: true,
                                              // enableShadow: true,
                                            
                                              // backgroundColor: TColors.grey,
                                              width: 174,
                                              height: 226,
                                              borderColor: TColors.grey
                                                  .withValues(alpha: .5),
                                              radius: const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15)),
                                             
                                              child: Visibility(
                                                visible: index == 0,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0),
                                                    child: TRoundedContainer(
                                                      enableShadow: true,
                                                      width: 50,
                                                      height: 50,
                                                      radius:
                                                          BorderRadius.circular(
                                                              300),
                                                      child: const Icon(
                                                        CupertinoIcons.add,
                                                        color: TColors.primary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                              
                              //  Stack(
                              //   alignment: Alignment.center,
                              //   children: [
                              //     InkWell(
                              //       onTap: () => Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) => CreateProduct(
                              //                     vendorId: vendorId,
                              //                     type: 'mixlin1',
                              //                     sectionId: 'all',
                              //                   ))),
                              //       child: TRoundedContainer(
                              //         width: 174,
                              //         height: 236,
                              //         borderColor: TColors.grey,
                              //         showBorder: true,
                              //         borderWidth: 1,
                              //         child: Visibility(
                              //           visible: index == 0,
                              //           child: Center(
                              //             child: Padding(
                              //               padding: const EdgeInsets.symmetric(
                              //                   horizontal: 20.0),
                              //               child: TRoundedContainer(
                              //                 enableShadow: true,
                              //                 width: 50,
                              //                 height: 50,
                              //                 radius: BorderRadius.circular(300),
                              //                 child: const Icon(
                              //                   CupertinoIcons.add,
                              //                   color: TColors.primary,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // );
                            },
                          ),
                        )
                      ],
                    ),
                )
                : const SizedBox.shrink();
          } else {
            return Padding(
            padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TCustomWidgets.buildTitle(
                      isArabicLocale() ? 'جرب هذا' : 'try this'),
                  const SizedBox(
                    height: TSizes.spaceBtWItems,
                  ),
                  Stack(
                    children: [
                      (spotList.length > 12 && showMore.value)
                          ? Column(
                              children: [
                                Padding(
                                 padding: const EdgeInsets.only(left:14, right: 14),
                                  child: MasonryGridView.count(
                                    itemCount:  editMode? spotList.sublist(0, 12).length+2 :spotList.sublist(0, 12).length,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    padding: const EdgeInsets.all(0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
if(editMode && index == spotList.sublist(0, 12).length+1){
  return GestureDetector(
     onTap: () {
                                 var controller =Get.put(ProductController());
    controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                        initialList: [],
                                            vendorId: vendorId,
                                             sectorTitle: SectorModel( arabicName: 'جرب هذا',id: '',englishName: 'try this', name: 'mixlin1'),
                                                
                                            type: 'mixlin1',
                                            sectionId: 'all',
                                          )));},
    child: emptyMedium( 335, 174));}

if(editMode && index == spotList.sublist(0, 12).length){
  return GestureDetector(
     onTap: () {
                                 var controller =Get.put(ProductController());
    controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                         sectorTitle: SectorModel( arabicName: 'جرب هذا',id: '',englishName: 'try this', name: 'mixlin1'),
                                            initialList: [],
                                            vendorId: vendorId,
                                            type: 'mixlin1',
                                            sectionId: 'all',
                                          )));},
    child: emptyMedium( 335, 174));}



                                      return GestureDetector(
                                             onLongPressStart: (details) {
            if(editMode){
 floatControllerVendor.product=spotList.sublist(0, 12)[index];
              floatControllerVendor.showFloatingButtons(context, details.globalPosition);
            }
           
            },
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 1000),
                                                pageBuilder:
                                                    (context, anim1, anim2) =>
                                                        ProductDetails(
                                                  product: spotList.sublist(0, 12)[index],
                                                  vendorId: vendorId,
                                                ),
                                              ));
                                        },
                                        child: ProductWidgetMedium(
                                          prefferWidth: 174,
                                          prefferHeight: 226,
                                          product: spotList.sublist(0, 12)[index],
                                          vendorId: vendorId,
                                          editMode: editMode,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: showMore.value,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () => showMore.value = false,
                                        child: TRoundedContainer(
                                             width: 100.w,
                                          backgroundColor: TColors.grey,
                                          height: 40,
                                          radius: BorderRadius.circular(15),
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
                                                  CupertinoIcons
                                                      .arrow_down_circle,
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
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                   padding: const EdgeInsets.only(left:14, right: 14,bottom: 14),
                                  child: MasonryGridView.count(
                                    itemCount: editMode? spotList.length+2:spotList.length,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    padding: const EdgeInsets.all(0),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                          if(editMode && index == spotList.length+1){
  return GestureDetector(
     onTap: () {
                                 var controller =Get.put(ProductController());
    controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                         sectorTitle: SectorModel( arabicName: 'جرب هذا',id: '',englishName: 'try this', name: 'mixlin1'),
                                                initialList: [],
                                            vendorId: vendorId,
                                            type: 'mixlin1',
                                            sectionId: 'all',
                                          )));},
    child: emptyMedium( 335, 174));}

if(editMode && index == spotList.length){
  return GestureDetector(
     onTap: () {
                                 var controller =Get.put(ProductController());
    controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                         sectorTitle: SectorModel( arabicName: 'جرب هذا',id: '',englishName: 'try this', name: 'mixlin1'),
                                              initialList: [],  
                                            vendorId: vendorId,
                                            type: 'mixlin1',
                                            sectionId: 'all',
                                          )));},
    child: emptyMedium( 335, 174));}


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
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 1000),
                                                pageBuilder:
                                                    (context, anim1, anim2) =>
                                                        ProductDetails(
                                                  product: spotList[index],
                                                  vendorId: vendorId,
                                                ),
                                              ));
                                        },
                                        child: ProductWidgetMedium(
                                          prefferWidth: 174,
                                          prefferHeight: 226,
                                          product: spotList[index],
                                          vendorId: vendorId,
                                          editMode: editMode,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      !showMore.value && spotList.length > 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => showMore.value = true,
                                      child: TRoundedContainer(
                                          width: 100.w,
                                          backgroundColor: TColors.grey,
                                          height: 40,
                                          radius: BorderRadius.circular(15),
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
                                ),
                              ],
                            ),
                      Visibility(
                        visible: editMode,
                        child: Positioned(
                            bottom: 50,
                            right: isArabicLocale() ? null : 8,
                            left: isArabicLocale() ? 08 : null,
                            child: CustomFloatActionButton(
                              onTap: () {
                                 var controller =Get.put(ProductController());
    controller.deleteTempItems();
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                         sectorTitle: SectorModel( arabicName: 'جرب هذا',id: '',englishName: 'try this', name: 'mixlin1'),
                                                initialList: spotList,
                                            vendorId: vendorId,
                                            type: 'mixlin1',
                                            sectionId: 'all',
                                          )));},
                            )),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        }
      },
    );
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
           enableShadow: true,
           height: cardHeight+120  ,
           width: cardWidth,
           radius: BorderRadius.circular(15),
         ),
         
        ],
      ),
    );

  }
}
