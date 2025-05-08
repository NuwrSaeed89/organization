import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/features/banner/view/front/promo_slider.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/all_category/widgets/category_grid_item.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/sector_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/grid_builder.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/grid_builder_custom_card.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/sector_builder.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key, required this.editMode, required this.vendorId});
  final bool editMode;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    CategoryController.instance.getCategoryOfUser(vendorId);
    // var categories = CategoryController.instance.allItems;
    List<ProductModel> featureProduct = [];
    List<ProductModel> all = [];
    List<ProductModel> saleProduct = ProductController.instance.saleProduct;
    featureProduct.assignAll(ProductController.instance.allItems
        .where((p0) => p0.isFeature == true));
    var controller = ProductController.instance;

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            TPromoSlider(
              editMode: editMode,
              vendorId: vendorId,
            ),
            Container(
                        color: Colors.transparent,
              height: 25,
            ),

            Obx(
              () {
                if (CategoryController.instance.load.value) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: TRoundedContainer(
                                    showBorder: true,
                                    enableShadow: true,
                                    //   borderColor: TColors.darkerGray,
                                    // enableShadow: true,
                                    // decoration: BoxDecoration(
                                    //     border: Border.all(

                                    //         color: TColors.darkerGray,
                                    //         width: 1,
                                    //         strokeAlign: BorderSide
                                    //             .strokeAlignOutside),
                                    //     color: Colors.grey,
                                    radius: BorderRadius.circular(100),
                                    child: TShimmerEffect(
                                      width: 70,
                                      height: 70,
                                      raduis: BorderRadius.circular(300),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                       Container(
                        color: Colors.transparent,
                        height: 20,
                      )
                    ],
                  );
                } else {
                  if (CategoryController.instance.allItems.isEmpty) {
                    return editMode
                        ? Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                height: 86,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: addCategoryItem(index, context),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TRoundedContainer(
                                          backgroundColor: Colors.white,
                                          showBorder: true,
                                          enableShadow: true,
                                          radius: BorderRadius.circular(300),
                                          width: 70,
                                          height: 70,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )
                        : const SizedBox.shrink();
                  } else {
                    return editMode
                        ? Stack(
                            children: [
                              Center(
                                child: TRoundedContainer(
                                  backgroundColor: Colors.transparent,
                                  height: 120,
                                  showBorder: false,
                                  width: 85 *
                                      (CategoryController
                                              .instance.allItems.length +
                                          1),
                                  //borderColor: Colors.red,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: CategoryController
                                            .instance.allItems.length +
                                        1,
                                    itemBuilder: (context, index) {
                                      // if (index == categories.length + 2) {
                                      //   // العنصر الثابت في النهاية
                                      //   return Padding(
                                      //       padding: const EdgeInsets.only(
                                      //           bottom: 41.0),
                                      //       child:
                                      //           addCategoryItem(index, context));
                                      // }

                                      if (index ==
                                          CategoryController
                                              .instance.allItems.length) {
                                        // العنصر الثابت في النهاية
                                        return Center(
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          bottom: 45.0),
                                                  child: addCategoryItem(
                                                      index, context)),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          ),
                                        );
                                      }

                                      return Row(
                                        children: [
                                          if (index == 0)
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          TCategoryGridItem(
                                              category: CategoryController
                                                  .instance.allItems[index],
                                              editMode: editMode,
                                              vendorId: vendorId),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Container(
                              color: Colors.transparent,
                              height: 120,
                              width: 85 *
                                  (CategoryController.instance.allItems.length +
                                      0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    CategoryController.instance.allItems.length,
                                itemBuilder: (context, index) {
                                  return TCategoryGridItem(
                                      category: CategoryController
                                          .instance.allItems[index],
                                      editMode: editMode,
                                      vendorId: vendorId);
                                },
                              ),
                            ),
                          );
                  }
                }
              },
            ),
          
            SectorBuilder(
              cardWidth: 95,
              cardHeight: 127,
              sectorTitle: SectorModel(
                  name: 'offers', englishName: 'Offers', arabicName: 'العروض'),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              withPadding: false,
              cardType: CardType.justImage,
            ),
            
            SectorBuilder(
              cardWidth: 127,
              cardHeight: 170,
              sectorTitle: SectorModel(
                  name: 'all', englishName: 'Product', arabicName: 'الكل'),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              
              cardType: CardType.smallCard,
            ),

            SectorBuilder(
              cardWidth: 127,
              cardHeight: 170,
              sectorTitle: SectorModel(
                  name: 'all1', englishName: 'Product', arabicName: 'الكل'),
              sctionTitle: 'all',
              vendorId: vendorId,
              withPadding: false,

              editMode: editMode,
              withTitle: false,
              cardType: CardType.smallCard,
            ),

            SectorBuilder(
              cardWidth: 127,
              cardHeight: 170,
              sectorTitle: SectorModel(
                  name: 'all2', englishName: 'Product', arabicName: 'الكل'),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              withPadding: false,
              withTitle: false,
              cardType: CardType.smallCard,
            ),
          
            SectorBuilder(
              cardWidth: 93.w,
              cardHeight: 69.h,
              sectorTitle: SectorModel(
                  name: 'sales', englishName: 'Sales', arabicName: 'تنزيلات'),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              cardType: CardType.justImage,
            ),
          
            SectorBuilder(
              cardWidth: 95,
              cardHeight: 127,
              sectorTitle: SectorModel(
                  name: 'foryou',
                  englishName: 'foryou',
                  arabicName: 'هذا لأجلك'),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              cardType: CardType.justImage,
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            GridBuilder(vendorId: vendorId, editMode: editMode),
            
           
            /////////////////////////////

            SectorBuilder(
              cardWidth: 257,
              cardHeight: 342,
              sectorTitle: SectorModel(
                  name: 'mixone',
                  englishName: 'Mix Item',
                  arabicName: 'يوجد لدينا ايضا'),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              cardType: CardType.justImage,
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            GridBuilderCustomCard(vendorId: vendorId, editMode: editMode),

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
        
            SectorBuilder(
              cardWidth: 174,
              cardHeight: 226,
              sectorTitle: SectorModel(
                  name: 'mixlin2',
                  englishName: 'Voutures',
                  arabicName: 'بطاقات خصم '),
              sctionTitle: 'all',
              vendorId: vendorId,
              editMode: editMode,
              withTitle: true,
              cardType: CardType.mediumCard,
            ),
 
            //             SectorBuilder(vendorId: vendorId, editMode: editMode

            //             card: , cardWidth: 95, cardHeight:
            // ,
            //             ),
            //////////////////////////

            // const SizedBox(
            //   height: TSizes.spaceBtWItems,
            // ),

            // if (saleProduct.isNotEmpty)

            /////////////////////mix ones
            Container(
              color: Colors.transparent,
              height: 20,
            ),
            /////////////////////////////
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            /// here is category
            /// 
            /// 
            /// 
            /// 
            /// 
            /// //////////////////////////////
            /// 
           
            Visibility(
              visible:  ProductController.instance.allItems.length>3,
              child: Obx(
                () {
                  if (CategoryController.instance.load.value) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: TRoundedContainer(
                                      showBorder: true,
                                      enableShadow: true,
                                      //   borderColor: TColors.darkerGray,
                                      // enableShadow: true,
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
              
                                      //         color: TColors.darkerGray,
                                      //         width: 1,
                                      //         strokeAlign: BorderSide
                                      //             .strokeAlignOutside),
                                      //     color: Colors.grey,
                                      radius: BorderRadius.circular(100),
                                      child: TShimmerEffect(
                                        width: 70,
                                        height: 70,
                                        raduis: BorderRadius.circular(300),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                         Container(
                          color: Colors.transparent,
                          height: 20,
                        )
                      ],
                    );
                  } else {
                    if (CategoryController.instance.allItems.isEmpty) {
                      return editMode
                          ? Column(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: 86,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 7,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: addCategoryItem(index, context),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TRoundedContainer(
                                            backgroundColor: Colors.white,
                                            showBorder: true,
                                            enableShadow: true,
                                            radius: BorderRadius.circular(300),
                                            width: 70,
                                            height: 70,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          : const SizedBox.shrink();
                    } else {
                      return editMode
                          ? Stack(
                              children: [
                                Center(
                                  child: TRoundedContainer(
                                    backgroundColor: Colors.transparent,
                                    height: 120,
                                    showBorder: false,
                                    width: 85 *
                                        (CategoryController
                                                .instance.allItems.length +
                                            1),
                                    //borderColor: Colors.red,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: CategoryController
                                              .instance.allItems.length +
                                          1,
                                      itemBuilder: (context, index) {
                                        // if (index == categories.length + 2) {
                                        //   // العنصر الثابت في النهاية
                                        //   return Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           bottom: 41.0),
                                        //       child:
                                        //           addCategoryItem(index, context));
                                        // }
              
                                        if (index ==
                                            CategoryController
                                                .instance.allItems.length) {
                                          // العنصر الثابت في النهاية
                                          return Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 45.0),
                                                    child: addCategoryItem(
                                                        index, context)),
                                                const SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          );
                                        }
              
                                        return Row(
                                          children: [
                                            if (index == 0)
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            TCategoryGridItem(
                                                category: CategoryController
                                                    .instance.allItems[index],
                                                editMode: editMode,
                                                vendorId: vendorId),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Container(
                                color: Colors.transparent,
                                height: 120,
                                width: 85 *
                                    (CategoryController.instance.allItems.length +
                                        0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      CategoryController.instance.allItems.length,
                                  itemBuilder: (context, index) {
                                    return TCategoryGridItem(
                                        category: CategoryController
                                            .instance.allItems[index],
                                        editMode: editMode,
                                        vendorId: vendorId);
                                  },
                                ),
                              ),
                            );
                    }
                  }
                },
              ),
            ),
        

            Visibility(
visible: false,
              child: Obx(
                () {
                  if (CategoryController.instance.load.value) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 180,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // عرض عنصرين لكل سطر
                              childAspectRatio: 1, // نسبة العرض إلى الارتفاع
                              crossAxisSpacing: 10, // تباعد بين العناصر عموديًا
                              mainAxisSpacing: 10, // تباعد بين العناصر أفقيًا
                            ),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: TRoundedContainer(
                                      showBorder: true,
                                      enableShadow: true,
                                      //   borderColor: TColors.darkerGray,
                                      // enableShadow: true,
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
              
                                      //         color: TColors.darkerGray,
                                      //         width: 1,
                                      //         strokeAlign: BorderSide
                                      //             .strokeAlignOutside),
                                      //     color: Colors.grey,
                                      radius: BorderRadius.circular(100),
                                      child: TShimmerEffect(
                                        width: 70,
                                        height: 70,
                                        raduis: BorderRadius.circular(300),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  } else {
                    if (CategoryController.instance.allItems.isEmpty) {
                      return editMode
                          ? Column(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: 200,
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // عرض عنصرين لكل سطر
                                      childAspectRatio:
                                          1, // نسبة العرض إلى الارتفاع
                                      crossAxisSpacing:
                                          2, // تباعد بين العناصر عموديًا
                                      mainAxisSpacing:
                                          10, // تباعد بين العناصر أفقيًا
                                    ),
                                    itemCount: 7,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: addCategoryItem(index, context),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TRoundedContainer(
                                            backgroundColor: Colors.white,
                                            showBorder: true,
                                            enableShadow: true,
                                            radius: BorderRadius.circular(300),
                                            width: 70,
                                            height: 70,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          : const SizedBox.shrink();
                    } else {
                      return editMode
                          ? Stack(
                              children: [
                                Center(
                                  child: TRoundedContainer(
                                    backgroundColor: Colors.transparent,
                                    height: 270,
                                    width: 100 *
                                        (CategoryController
                                                .instance.allItems.length +
                                            1 % 2 +
                                            CategoryController
                                                .instance.allItems.length +
                                            1 / 2),
                                    showBorder: false,
              
                                    //borderColor: Colors.red,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // عرض عنصرين لكل سطر
                                        childAspectRatio:
                                            1, // نسبة العرض إلى الارتفاع
                                        crossAxisSpacing:
                                            2, // تباعد بين العناصر عموديًا
                                        mainAxisSpacing:
                                            10, // تباعد بين العناصر أفقيًا
                                      ),
                                      itemCount: CategoryController
                                              .instance.allItems.length +
                                          1,
                                      itemBuilder: (context, index) {
                                        // if (index == categories.length + 2) {
                                        //   // العنصر الثابت في النهاية
                                        //   return Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           bottom: 41.0),
                                        //       child:
                                        //           addCategoryItem(index, context));
                                        // }
              
                                        if (index ==
                                            CategoryController
                                                .instance.allItems.length) {
                                          // العنصر الثابت في النهاية
                                          return Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 45.0),
                                                    child: addCategoryItem(
                                                        index, context)),
                                                const SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          );
                                        }
              
                                        return Row(
                                          children: [
                                            if (index == 0)
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            TCategoryGridItem(
                                                category: CategoryController
                                                    .instance.allItems[index],
                                                editMode: editMode,
                                                vendorId: vendorId),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Container(
                                color: Colors.transparent,
                                height: 240,
                                width: 100 *
                                    (CategoryController.instance.allItems.length %
                                            2 +
                                        CategoryController
                                                .instance.allItems.length /
                                            2),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // عرض عنصرين لكل سطر
                                    childAspectRatio:
                                        1.1, // نسبة العرض إلى الارتفاع
                                    crossAxisSpacing:
                                        2, // تباعد بين العناصر عموديًا
                                    mainAxisSpacing:
                                        10, // تباعد بين العناصر أفقيًا
                                  ),
                                  itemCount:
                                      CategoryController.instance.allItems.length,
                                  itemBuilder: (context, index) {
                                    return TCategoryGridItem(
                                        category: CategoryController
                                            .instance.allItems[index],
                                        editMode: editMode,
                                        vendorId: vendorId);
                                  },
                                ),
                              ),
                            );
                    }
                  }
                },
              ),
            ),

            // CategoryGrid(
            //   vendorId: vendorId,
            //   editMode: editMode,
            // ),
            // const SizedBox(
            //   height: 50,
            // ),
          
          ]),
    );
  }

  Stack addCategoryItem(int index, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateCategory(
                        vendorId: vendorId,
                        // suggestingCategory:
                        //     category,
                      ))),
          child: TRoundedContainer(
            showBorder: false,
            width: 70,
            height: 70,
            radius: BorderRadius.circular(100),
            enableShadow: true,
            child: const Center(
              child: Icon(
                CupertinoIcons.add,
                color: TColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
