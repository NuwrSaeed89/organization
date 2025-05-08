import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/sector_model.dart';
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
    var spotList = [].obs;

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
                  height: cardHeight + 10,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) => TShimmerEffect(
                      raduis: BorderRadius.circular(15),
                      height: cardHeight,
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
                  padding:   withPadding? EdgeInsets.only(top:30):EdgeInsets.only(top:0),
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
                            height: cardHeight + 100,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                padding: isLocaleEn(context)
                                    ? EdgeInsets.only(
                                        left: 14.0,
                                        bottom: 20,
                                        right: index == 5 - 1 ? 14 : 0)
                                    : EdgeInsets.only(
                                        right: 14.0,
                                        bottom: 20,
                                        left: index == 5 - 1 ? 14 : 0),
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
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CreateProduct(
                                                    vendorId: vendorId,
                                                    type: sectorTitle.name,
                                                    sectionId: sctionTitle,
                                                  ))),
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
                                        left: 14.0,
                                        right: index == 5 - 1 ? 14 : 0)
                                    : EdgeInsets.only(
                                        right: 14.0,
                                        left: index == 5 - 1 ? 14 : 0),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateProduct(
                                                vendorId: vendorId,
                                                type: sectorTitle.name,
                                                sectionId: sctionTitle,
                                              ))),
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
                                        height: cardHeight - 10,
                                        width: cardWidth - 10,
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
            spotList.value = getSpotList(sectorTitle.name);
            return Padding(
                 padding:   withPadding? EdgeInsets.only(top:30):EdgeInsets.only(top:0),
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
                            ? cardHeight + 25
                            : cardType == CardType.smallCard
                                ? cardHeight + 100
                                : cardHeight + 100,
                        child: Obx(
                          () => ListView.builder(
                            // padding: EdgeInsets.symmetric(vertical: 5),
                            scrollDirection: Axis.horizontal,
                            itemCount: spotList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: isLocaleEn(context)
                                    ? EdgeInsets.only(
                                        left: 14.0,
                                        bottom: 22,
                                        right:
                                            index == spotList.length - 1 ? 14 : 0)
                                    : EdgeInsets.only(
                                        right: 14.0,
                                        bottom: 22,
                                        left: index == spotList.length - 1
                                            ? 14
                                            : 0),
                                child: SizedBox(
                                  height: cardHeight,
                                  width: cardWidth,
                                  child: GestureDetector(
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
                                            height: cardHeight,
                                            radius: BorderRadius.circular(15),
                                            enableShadow: true,
                                            child: CustomCaChedNetworkImage(
                                              url: spotList[index].images!.first,
                                              width: cardWidth,
                                              height: cardHeight,
                                              raduis: BorderRadius.circular(15),
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
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                            vendorId: vendorId,
                                            type: sectorTitle.name,
                                            sectionId: sctionTitle,
                                          ))),
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
