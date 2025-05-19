import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/create_category_controller.dart';
import 'package:winto/features/organization/e_commerce/features/banner/view/front/promo_slider.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/all_category/widgets/category_grid_item.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/grid_builder.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/grid_builder_custom_card.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/sector_builder.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key, required this.editMode, required this.vendorId});
  final bool editMode;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
   // CategoryController.instance.getCategoryOfUser(vendorId);
    // var categories = CategoryController.instance.allItems;
   
    var controller = ProductController.instance;
    controller.closeList;

    return Column(
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
    
          viewCategories(),
        SizedBox(height: 16,),
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
            withPadding: false,
            cardType: CardType.smallCard,
          ),
    
          SectorBuilder(
            cardWidth: 127,
            cardHeight: 170,
            sectorTitle: SectorModel(
                name: 'all1', englishName: 'Product A', arabicName: 'المنتجات A'),
            sctionTitle: 'all',
            vendorId: vendorId,
           
    withPadding: false,
            editMode: editMode,
           // withTitle: false,
            cardType: CardType.smallCard,
          ),
    
          SectorBuilder(
            cardWidth: 127,
            cardHeight: 170,
            sectorTitle: SectorModel(
                 name: 'all2', englishName: 'Product B', arabicName: 'المنتجات B'),
            sctionTitle: 'all',
            vendorId: vendorId,
            editMode: editMode,
       withPadding: false,
            cardType: CardType.smallCard,
          ),
         SectorBuilder(
            cardWidth: 127,
            cardHeight: 170,
            sectorTitle: SectorModel(
                    name: 'all3', englishName: 'Product C', arabicName: 'المنتجات C'),
            sctionTitle: 'all',
            vendorId: vendorId,
            editMode: editMode,
      withPadding: false,
            cardType: CardType.smallCard,
          ),
          //   SectorBuilder(
          //   cardWidth: 127,
          //   cardHeight: 170,
          //   sectorTitle: SectorModel(
          //          name: 'all4', englishName: 'Product List4', arabicName: 'قائمة المنتجات 4'),
          //   sctionTitle: 'all',
          //   vendorId: vendorId,
          //   editMode: editMode,
           
          //   cardType: CardType.smallCard,
          // ),
          SectorBuilder(
            cardWidth: 85.w,
            cardHeight: 85.w*(8/6),
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
            cardWidth: 70.w,
            cardHeight: 70.w*4/3,
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
            cardType:CardType.mediumCard,
            withTitle: true,
            withPadding: true,
          
  
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
            child: viewCategories()
          ),
      
    
          // CategoryGrid(
          //   vendorId: vendorId,
          //   editMode: editMode,
          // ),
          // const SizedBox(
          //   height: 50,
          // ),
        
        ]);
  }

 viewCategories() {
  
    var controller=ProductController.instance;
    controller.isExpanded(false);
  
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
                      ?
                       Column(
                        children: [
                          Stack(
                              children: [
                                Obx(()=>
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
                                              GestureDetector(
                                                 onTap: () => controller.selectCategory(CategoryController
                                                        .instance.allItems[index],vendorId),
                                                child:
                                                
                                                 Obx(()=>
                                                    TCategoryGridItem(
                                                      category: CategoryController
                                                          .instance.allItems[index],
                                                      editMode: editMode,
                                                      selected:controller.selectedCategory.value ==CategoryController
                                                          .instance.allItems[index] ,
                                                    ),
                                                 )
                                                  
                                                
                                                  ,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      
                    
        
       Obx(() {
            return 
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: controller.isExpanded.value ? 420 : 0,
              child: controller.isExpanded.value
                  ? Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            if (controller.loadProduct.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (controller.products.isEmpty) {
                              return 
                                Center(child: Image.asset(
                          'assets/images/liquid_loading.gif',
                          width: 50.w,
                          height: 50.w,
                        ),);
                            }
                            var spotList=controller.products;
                            return   Padding(
                                     padding: const EdgeInsets.only(left:0, right: 0),
                                    child:ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: spotList.length,
                                      itemBuilder: (context, index) =>

 InkWell(
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
                                          child: Padding(
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
                                            width: 174,
                                              child: ProductWidgetMedium(
                                                prefferWidth: 174,
                                                prefferHeight: 226,
                                                product: spotList[index],
                                                vendorId: vendorId,
                                                editMode: editMode,
                                              ),
                                            ),
                                          ),
                                        )
                                      
                                    )
                                    
                                  ,

                                  );
                         
                          }),
                        ),

                        // زر الإغلاق
                         GestureDetector(
        onTap: controller.closeList,
        child: Center(
          child: Container(
            width: 50,
            padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Center(
              child: Icon(Icons.arrow_circle_up_sharp,color: Colors.white,)
            ),
          ),
        )),
                  SizedBox(height: 15,)     
                      ],
                    )
                  : SizedBox.shrink(),
            );
          }),
                      
                        ],
                      )
                      : 
                      
                      Column(
                        children: [
                          Center(
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
                                    return GestureDetector(
                                         onTap: () => controller.selectCategory(CategoryController
                                              .instance.allItems[index],vendorId),
                                      child: Obx(()=>
                                                  TCategoryGridItem(
                                                    category: CategoryController
                                                        .instance.allItems[index],
                                                    editMode: editMode,
                                                    selected:controller.selectedCategory.value ==CategoryController
                                                        .instance.allItems[index] ,
                                                  ),
                                               )
                                    );
                                  },
                                ),
                              ),
                            ),
                            
       Obx(() {
       
            return 
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: controller.isExpanded.value ? 420 : 0,
              child: controller.isExpanded.value
                  ? Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                          
                            if (controller.loadProduct.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (controller.products.isEmpty) {
                              
                              return Center(child: Image.asset(
                          'assets/images/liquid_loading.gif',
                          width: 50.w,
                          height: 50.w,
                        ),);
                            }
                              if (kDebugMode) {
                                print("-------------------${ controller.products.length}");
                              print( controller.products.length);
                            }
                            var spotList=controller.products;
                            return
                            
                            Padding(
                                   padding: const EdgeInsets.only(left:0, right: 0),
                                  child:ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: spotList.length,
                                    itemBuilder: (context, index) =>
            
             InkWell(
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
                                        child: Padding(
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
                                            width: 174,
                                            child: ProductWidgetMedium(
                                              prefferWidth: 174,
                                              prefferHeight: 226,
                                              product: spotList[index],
                                              vendorId: vendorId,
                                              editMode: editMode,
                                            ),
                                          ),
                                        ),
                                      )
                                    
                                  )
                                  
                                ,
            
                                );
                          }),
                        ),
            
                        // زر الإغلاق
                       // زر الإغلاق
                         GestureDetector(
        onTap: controller.closeList,
        child: Center(
          child: Container(
            width: 50,
            padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Center(
              child: Icon(Icons.arrow_circle_up_sharp,color: Colors.white,)
            ),
          ),
        )),
                      ],
                    )
                  : SizedBox.shrink(),
            );
          }),
              
                        ],
                      );
                }
              
            
  }

  Stack addCategoryItem(int index, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () {
             var controller =Get.put(CreateCategoryController());
    controller.deleteTempItems();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateCategory(
                        vendorId: vendorId,
                        // suggestingCategory:
                        //     category,
                      )));},
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
