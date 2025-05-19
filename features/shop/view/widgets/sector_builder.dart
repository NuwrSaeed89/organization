import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_client_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_vendor_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/favorite_widget.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';

class SectorBuilder extends StatelessWidget {
  const SectorBuilder({
    super.key,
    required this.vendorId,
    required this.editMode,
    required this.cardWidth,
    this.withTitle = true,
    required this.cardHeight,
    required this.sectorTitle,
    required this.cardType,
    required this.sctionTitle,
    this.withPadding=true
  });

  final String vendorId;
  final bool editMode;
  final double cardWidth;
  final double cardHeight;
  final bool withTitle;
  final SectorModel sectorTitle;
  final String sctionTitle;
  final CardType cardType;
   final bool withPadding;
//  final Function onAdd;
  //final Function onCardTap;

  @override
  Widget build(BuildContext context) {
     List<IconData> icons = [Icons.favorite, Icons.share, Icons.shopping_cart, Icons.delete];
const  double padding=10;
var floatControllerClient =
      Get.put(FloatingButtonsClientController());
      var floatControllerVendor =
      Get.put(FloatingButtonsVendorController());
    RxList<ProductModel> spotList = <ProductModel>[].obs;
  // final FloatingButtonsController controllerf =
// Get.put(FloatingButtonsController());
    return FutureBuilder<List<ProductModel>>(
      future:
          ProductController.instance.fetchListData(vendorId, sectorTitle.name),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return 
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  height: cardHeight + 16,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) => TShimmerEffect(
                      raduis: BorderRadius.circular(15),
                      height: cardHeight+2,
                      width: cardWidth,
                    ),
                  ),
                ),
              ],
            ),
          );
        }  else {
          spotList.value = getSpotList(sectorTitle.name);
          if (spotList.isEmpty) {
            return editMode
                ? Padding(
                  padding:   withPadding? EdgeInsets.only(top:20):EdgeInsets.only(top:10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: withTitle,
                          child: TCustomWidgets.buildTitle(isArabicLocale()
                              ? sectorTitle.arabicName
                              : sectorTitle.englishName),
                        ),
                        Visibility(
                            visible: withTitle,
                            child: TCustomWidgets.buildDivider()),
                        Visibility(
                          visible: cardType == CardType.mediumCard,
                          child: Container(
                            color: Colors.transparent,
                            height: cardHeight + 110,
                            child: Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Padding(
                                  padding: isLocaleEn(context)
                                      ? EdgeInsets.only(
                                          left:padding,
                                          bottom: 20,
                                          right: index == 5 - 1 ?padding : 0)
                                      : EdgeInsets.only(
                                          right: padding,
                                          bottom: 20,
                                          left: index == 5 - 1 ?padding : 0),
                                  child: 
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      TRoundedContainer(
                                        borderColor: TColors.grey,
                                        showBorder: true,
                                        enableShadow: true,
                                        height: cardHeight + 100,
                                        width: cardWidth,
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
                                                      vendorId: vendorId,
                                                      type: sectorTitle.name,
                                                      initialList: spotList.isNotEmpty ? spotList:[] ,
                                                      sectorTitle:sectorTitle,
                                                      sectionId: sctionTitle,
                                                    )));},
                                        child: Stack(
                                          //   alignment: Alignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: TRoundedContainer(
                                                showBorder: true,
                                                // enableShadow: true,
                                                
                                                // backgroundColor: TColors.grey,
                                                width: cardWidth,
                                                borderColor: TColors.grey
                                                    .withValues(alpha: .5),
                                                radius: const BorderRadius.only(
                                                    topLeft: Radius.circular(15),
                                                    topRight: Radius.circular(15)),
                                                height: cardHeight,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                       
                        
                       
                        Visibility(
                          visible: cardType != CardType.mediumCard,
                          child: Container(
                            color: Colors.transparent,
                            height: cardHeight + 10,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                padding: isLocaleEn(context)
                                    ? EdgeInsets.only(
                                        left: padding,
                                        right: index == 5 - 1 ?padding : 0)
                                    : EdgeInsets.only(
                                        right: padding,
                                        left: index == 5 - 1 ?padding : 0),
                                child: InkWell(
                                   onTap: () {
             var controller =Get.put(ProductController());
    controller.deleteTempItems();
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateProduct(
                        vendorId: vendorId,
                        initialList:spotList,

                        type: sectorTitle.name,
                           sectorTitle:sectorTitle,
                        sectionId: sctionTitle,
                      )));},
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: TColors.shadow
                                                  .withValues(alpha: .2),
                                              spreadRadius: 0,
                                              blurRadius: 3,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: TColors.grey),
                                        ),
                                        //showBorder: true,
                                        height: cardHeight,
                                        width: cardWidth,
                                        //enableShadow: true,
                                        //radius: BorderRadius.circular(15),
                                      ),
                                      Visibility(
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                )
                : const SizedBox.shrink();
          } else {
            if (kDebugMode) {
              print("SSSSSSSSSSSSSS${sectorTitle.arabicName}potlengthis  ${spotList.length}");
            }
            spotList.value = getSpotList(sectorTitle.name);
            return Padding(
                 padding:   withPadding? EdgeInsets.only(top:30):EdgeInsets.only(top:10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: withTitle,
                    child: TCustomWidgets.buildTitle(isArabicLocale()
                        ? sectorTitle.arabicName
                        : sectorTitle.englishName),
                  ),
                  Visibility(
                      visible: withTitle, child: TCustomWidgets.buildDivider()),
                  Stack(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: cardType == CardType.justImage
                            ? cardHeight + 70
                            : cardType == CardType.smallCard
                                ? cardHeight + 120
                                : cardHeight + 130,
                        child: Obx(
                          () => ListView.builder(
                            // padding: EdgeInsets.symmetric(vertical: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: editMode?  spotList.length+2 : spotList.length,
                            itemBuilder: (context, index) {
                                GlobalKey itemKey = GlobalKey();

if(editMode && index == spotList.length+1){
  return Padding(
    
                                padding: isLocaleEn(context)
                                    ? EdgeInsets.only(
                                        left: 7.0,
                                        bottom: 22,
                                        right:14
                                           )
                                    : EdgeInsets.only(
                                        right: 7.0,
                                        bottom: 22,
                                        left:padding
                                            ),
    child:  EmptyAddItem(cardHeight: cardHeight,cardWidth: cardWidth,sctionTitle: sctionTitle,vendorId: vendorId,sectorTitle: sectorTitle, cardType: cardType,),
  );
}
if(editMode && index == spotList.length){
  return Padding(
                                padding: isLocaleEn(context)
                                    ? EdgeInsets.only(
                                        left: 0.0,
                                        bottom: 22,
                                        right:
                                             7 )
                                    : EdgeInsets.only(
                                        right: 0.0,
                                        bottom: 22,
                                        left: 
                                            7
                                          ),child: EmptyAddItem(cardHeight: cardHeight,cardWidth: cardWidth,sctionTitle: sctionTitle,vendorId: vendorId,sectorTitle: sectorTitle, cardType: cardType,));
}

                              return Padding(
                                padding: isLocaleEn(context)
                                    ? EdgeInsets.only(
                                        left: padding,
                                        bottom: 20,
                                        right:
                                            index == spotList.length - 1 ?padding : 0)
                                    : EdgeInsets.only(
                                        right: padding,
                                        bottom: 20,
                                        left: index == spotList.length - 1
                                            ?padding
                                            : 0),
                                child: SizedBox(
                                  height: cardHeight,
                                  width: cardWidth,
                                  child: GestureDetector(
                                     key: itemKey,
          onLongPressStart: (details) {
            if(editMode){
 floatControllerVendor.p=spotList[index];
              floatControllerVendor.showFloatingButtons(context, details.globalPosition);
            }else{

 floatControllerClient.p=spotList[index];
              floatControllerClient.showFloatingButtons(context, details.globalPosition);
            }
           
            },
                                    onTap: () => Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 1000),
                                          pageBuilder: (context, anim1, anim2) =>
                                              ProductDetails(
                                            product: spotList[index],
                                            vendorId: vendorId,
                                          ),
                                        )),
                                    child: cardType == CardType.justImage
                                        ? TRoundedContainer(
                                            width: cardWidth,
                                            height: cardHeight+50,
                                           // radius: BorderRadius.circular(15),
                                          //  enableShadow: true,
                                            child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TRoundedContainer(
                                                      width: cardWidth,
                                                    height: cardHeight,
                                                    radius: BorderRadius.circular(15),
                                                    enableShadow: true,
                                                    showBorder: true,
                                                  child:
                                                  Stack(
                                                    children: [
                                                      TProductImageSliderMini(
                                                                    product: spotList[index],
                                                                    prefferHeight:cardWidth*(4/3),
                                                                    prefferWidth:cardWidth,
                                                                    radius: BorderRadius.circular(15),
                                                                  ),
                                                                  Visibility(
                                                                    visible: editMode,
                                                                    child: Positioned(
                                                                      bottom:0,
                                                                      right: padding/2,
                                                                      child:  GestureDetector(
                                                                        onTapDown: (details) {
                                                                              if(editMode){
                                                                     floatControllerVendor.p=spotList[index];
                                                                                  floatControllerVendor.showFloatingButtons(context, details.globalPosition);
                                                                                }
                                                                                
                                                                        },
                                                                        child:  Icon(Icons.more_horiz, color: Colors.white),
                                                                                          
                                                                                        
                                                                      ),
                                                                      
                                                                    ),
                                                                  ),
                                                    ],
                                                  ),
                                                  
                                             
                                                ),
                                                SizedBox(height: 12,),
                                                  ProductController.getTitle(spotList[index] ,isLocaleEn(context), cardWidth> 50.w ? 15:13 ),
                                               // Text("jjjjjjjjj")
                                              ],
                                            ),
                                          )
                                        : cardType == CardType.smallCard
                                            ? ProductWidgetSmall(
                                                product: spotList[index],
                                                vendorId: vendorId,
                                              )
                                            : cardType == CardType.mediumCard
                                                ? ProductWidgetMedium(
                                                    vendorId: vendorId,
                                                    editMode: editMode,
                                                    prefferWidth: cardWidth,
                                                    prefferHeight: cardHeight,
                                                    product: spotList[index],
                                                  )
                                                : const SizedBox.shrink(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: editMode,
                        child: Positioned(
                            bottom: 15,
                            right: isArabicLocale() ? null : 7,
                            left: isArabicLocale() ? 7 : null,
                            child: CustomFloatActionButton(
                                onTap: () {
             var controller =Get.put(ProductController());
    controller.deleteTempItems();
             Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateProduct(
                    initialList: spotList,
                        vendorId: vendorId,
                        type: sectorTitle.name,
                           sectorTitle:sectorTitle,
                        sectionId: sctionTitle,
                      )));},
                            )),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        }
      },
    );
  }

  // int getDayNumber(String sector) {
  //   switch (sector) {
  //     case 'offers':
  //       return ProductController.instance.offerDynamic.length;
  //     case 'Tuesday':
  //       return 2;
  //     case 'Wednesday':
  //       return 3;
  //     case 'Thursday':
  //       return 4;
  //     case 'Friday':
  //       return 5;
  //     case 'Saturday':
  //       return 6;
  //     case 'Sunday':
  //       return 7;
  //     default:
  //       return 0; // القيمة الافتراضية إذا لم يكن المدخل صحيحاً
  //   }
  // }

  RxList<ProductModel> getSpotList(String sector) {
    switch (sector) {
      case 'offers':
        return ProductController.instance.offerDynamic;
      case 'all':
        return ProductController.instance.allDynamic;
      case 'all1':
        return ProductController.instance.allLine1Dynamic;
      case 'all2':
        return ProductController.instance.allLine2Dynamic;
         case 'all3':
        return ProductController.instance.allLine3Dynamic;
      case 'sales':
        return ProductController.instance.salesDynamic;
      case 'foryou':
        return ProductController.instance.foryouDynamic;
      case 'mixone':
        return ProductController.instance.mixoneDynamic;
      case 'mostdeamand':
        return ProductController.instance.mostdeamandDynamic;
      case 'mixlin1':
        return ProductController.instance.mixline1Dynamic;
      case 'mixlin2':
        return ProductController.instance.mixline2Dynamic;

      default:
        return <ProductModel>[]
            .obs; // القيمة الافتراضية إذا لم يكن المدخل صحيحاً
    }
  }
}

class EmptyAddItem extends StatelessWidget {
  const EmptyAddItem({
    super.key,
    required this.cardHeight,
    required this.cardWidth,
    required this.vendorId,
    required this.sectorTitle,
    required this.sctionTitle,
    required this.cardType
  
  });

  final double cardHeight;
  final double cardWidth;
  final String vendorId;
  final SectorModel sectorTitle;
  final String sctionTitle;
  final CardType cardType;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        alignment: Alignment.topCenter,
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
                          initialList: [],
                          type: sectorTitle.name,
                             sectorTitle:sectorTitle,
                          sectionId: sctionTitle,
                        )));},
            child: TRoundedContainer(
              borderColor: TColors.grey,
              showBorder: true,
              enableShadow: true,
              height: cardType == CardType.mediumCard?cardHeight+120 : cardHeight ,
              width: cardWidth,
              radius: BorderRadius.circular(15),
            ),
          ),
         
        ],
      ),
    );
  }
}
