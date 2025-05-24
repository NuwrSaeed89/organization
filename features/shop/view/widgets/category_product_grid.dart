import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/shemmer/product_horizental_list_shimmer.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/texts/section_heading.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class TCategoryProductGrid extends StatelessWidget {
  TCategoryProductGrid(
      {super.key,
      required this.editMode,
      required this.product,
      required this.userId});
  final ProductModel product;
  final bool editMode;
  final String userId;

  Rx<CategoryModel> selectedCategory = CategoryModel.empty().obs;
  @override
  Widget build(BuildContext context) {
    var category=product.category!;
    final controller = CategoryController.instance;
 
   RxList<ProductModel> offersItems = <ProductModel>[].obs;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 35,
                child: TextFormField(
                    decoration: inputTextSearchField.copyWith(
                        labelText: AppLocalizations.of(context)
                            .translate('search.search'),
                        prefixIcon: const Icon(Icons.search)),
                    controller: controller.searchTextController,
                    onChanged: (query) => controller.searchQuery(query ),
                    style: robotoSmallTitleRegular),
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtWItems,
          ),
          // Text(userId.toString()),
          // Text(category.id.toString()),
          Visibility(
            visible: true,
            child: FutureBuilder(
                future: controller.getCategoryProduct(
                    categoryId: category.id!, userId: userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox(
                      height: 300,
                      child: Center(child: const TLoaderWidget()));
                  }
                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.isEmpty) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        const TShimmerEffectdark(
                          width: 120,
                          height: 180,
                        ),
                        if (editMode)
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  ProductController.instance.tempProducts= <ProductModel>[].obs;
                                
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateProduct(
                                              vendorId: userId,
                                              initialList: [],
                                               sectorTitle: SectorModel( arabicName: '',id: '',englishName: '', name: ''),
                                              type: '',
                                              sectionId: '',
                                              // suggestingCategory:
                                              //     category,
                                            )));},
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                isArabicLocale()
                                    ? "اضافة عنصر"
                                    : "Add Item",
                                style: titilliumBold,
                              )
                            ],
                          )
                      ],
                    );
                  }
                 
                  var items = snapshot.data!;
                 var products=[];
                 products.assignAll(items.where((p)=>p!=product));
                

                  offersItems
                      .assignAll(items.where((p) => p.oldPrice! > 0));
                  // .where((p) =>
                  //     int.parse(ProductController.instance
                  //         .calculateSalePresentage(
                  //             p.price, p.salePrice)!) >
                  //     0)
                  // .take(8);
                  // .toList();
      
                  if (products.isEmpty) {
                    return editMode
                        ? Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreateProduct(
                                              initialList: [],
                                              vendorId: userId,
                                              type: '',
                                               sectorTitle: SectorModel( arabicName: '',id: '',englishName: '', name: ''),
                                              sectionId: 'all',
                                              // suggestingCategory:
                                              //     category,
                                            ))),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                isArabicLocale()
                                    ? "اضافة عنصر"
                                    : "Add Item",
                                style: titilliumBold,
                              )
                            ],
                          )
                        : const SizedBox.shrink();
                  }
      
                 return Padding(
                   padding: const EdgeInsets.only(left:8.0,right: 8),
                   child: MasonryGridView.count(
                    itemCount: products.length,
                    crossAxisCount: 100.w> 375? 4:3 ,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: 30.w,
                            height: 30.w*(4/3)+40,
                            child: ProductWidgetSmall(
                            
                              product: products[index],
                              vendorId: products[index].vendorId,
                            ),
                          ),
                        ],
                      );
                    },
                                   ),
                 );
                  //return TSortableProducts(products: products);
                }),
          ),
      
          // const SizedBox(
          //   height: TSizes.spaceBtWsections,
          // ),
      
          ///offers
          ///
          //
      
          // Obx(()=>  (offersItems.isNotEmpty)?
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 18.0),
          //     child: TSectionHeading(
          //         buttonTitle: 'view all',
          //         showActionButton: true,
          //         title: isLocaleEn(context) ? "Sales" : "العروض"),
          //   ) : SizedBox.shrink(),
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          // SizedBox(
          //   height: 280,
          //   child: Obx(()=>
          //      ListView.separated(
          //         physics: const NeverScrollableScrollPhysics(),
          //         shrinkWrap: true,
          //         separatorBuilder: (context, index) =>
          //             const SizedBox(width: 12),
          //         scrollDirection: Axis.vertical,
          //         itemCount: offersItems.length,
          //         itemBuilder: (_, index) => SizedBox(
          //               height: 310,
          //               width: 120,
          //               child: ProductWidgetSmall(
          //                 vendorId: userId,
          //                 product: offersItems[index],
          //               ),
          //             )),
          //   ),
          // ),
      
          // FutureBuilder(
          //     future: controller.getSubCategories(category.id!, userId),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Wrap(
          //           children: [
          //             TShimmerEffect(width: 100, height: 30),
          //             SizedBox(
          //               width: 6,
          //             ),
          //             TShimmerEffect(width: 100, height: 30),
          //             SizedBox(
          //               width: 6,
          //             ),
          //             TShimmerEffect(width: 100, height: 30),
          //           ],
          //         );
          //       }
          //       if (!snapshot.hasData ||
          //           snapshot.data == null ||
          //           snapshot.data!.isEmpty) {
          //         return editMode
          //             ? Stack(
          //                 alignment: Alignment.center,
          //                 children: [
          //                   const TShimmerEffect(width: 120, height: 50),
          //                   Column(
          //                     children: [
          //                       const SizedBox(
          //                         child: Icon(Icons.add),
          //                       ),
          //                       SizedBox(
          //                         child: Text(
          //                           'اضافة فئة فرعية',
          //                           style: titilliumBold,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               )
          //             : const SizedBox();
          //       }
          //       if (snapshot.hasError) {
          //         return Center(
          //           child: Text(
          //             AppLocalizations.of(context)
          //                 .translate('session.someThinggowrong'),
          //             style: robotoMedium,
          //           ),
          //         );
          //       }
          //       final subcategories = snapshot.data!;
          //       if (subcategories.isEmpty) {
          //         return const SizedBox(
          //           child: Icon(Icons.add),
          //         );
          //       }
      
          //       return Visibility(
          //         visible: false,
          //         child: SizedBox(
          //           height: 50,
          //           child: ListView.separated(
          //             separatorBuilder: (context, index) =>
          //                 const SizedBox(
          //               width: 10,
          //             ),
          //             scrollDirection: Axis.horizontal,
          //             shrinkWrap: true,
          //             physics: const NeverScrollableScrollPhysics(),
          //             itemCount: subcategories.length,
          //             itemBuilder: (_, index) => InkWell(
          //               onTap: () =>
          //                   selectedCategory.value = subcategories[index],
          //               child: TRoundedContainer(
          //                   radius: BorderRadius.circular(40),
          //                   showBorder: true,
          //                   borderColor: selectedCategory.value ==
          //                           subcategories[index]
          //                       ? TColors.black
          //                       : TColors.darkGrey,
          //                   padding: const EdgeInsets.all(8),
          //                   child: Center(
          //                     child: Text(
          //                         isLocaleEn(context)
          //                             ? subcategories[index].name
          //                             : subcategories[index].arabicName,
          //                         style: titilliumSemiBold),
          //                   )),
          //             ),
          //           ),
          //         ),
          //       );
      
          //       //return TSortableProducts(products: products);
          //     }),
          // Obx(
          //   () => Text(selectedCategory.value.arabicName),
          // ),
      
          // TGridLayout(
          //     itemCount: products.length,
          //     itemBuilder: (_, index) => TProductCardVertical(
          //           product: ProductModel.empty(),
          //         )),
          const SizedBox(
            height: TSizes.spaceBtWsections,
          ),
        ],
      ),
    );
  }
}
