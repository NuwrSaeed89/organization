import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/shemmer/product_horizental_list_shimmer.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/texts/section_heading.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/custom_styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  TCategoryTab(
      {super.key,
      required this.editMode,
      required this.category,
      required this.userId});
  final CategoryModel category;
  final bool editMode;
  final String userId;

  Rx<CategoryModel> selectedCategory = CategoryModel.empty().obs;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    List<ProductModel> featuredItems = [];
    List<ProductModel> offersItems = [];
    List<ProductModel> lastItems = [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ListView(
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 35,
                    child: TextFormField(
                        decoration: inputTextSearchField.copyWith(
                            labelText: AppLocalizations.of(context)
                                .translate('search.search'),
                            prefixIcon: const Icon(Icons.search)),
                        controller: controller.searchTextController,
                        onChanged: (query) => controller.searchQuery(query),
                        style: robotoSmallTitleRegular),
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
                          return const TProductHorizentalShimmer();
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
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateProduct(
                                                    vendorId: userId,
                                                    type: '',
                                                    sectionId: '',
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
                            ],
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('session.someThinggowrong'),
                              style: robotoMedium,
                            ),
                          );
                        }
                        final products = snapshot.data!;
                        offersItems
                            .assignAll(products.where((p) => p.salePrice > 0));
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
                                                    vendorId: userId,
                                                    type: '',
                                                    sectionId: '',
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

                        return Column(
                          children: [
                            SizedBox(
                                height: 225,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: products.length,
                                  itemBuilder: (_, index) => Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizedBox(
                                        height: 310,
                                        width: 120,
                                        child: ProductWidgetSmall(
                                          vendorId: userId,
                                          product: products[index],
                                        ),
                                      )),
                                )),
                          ],
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

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: TSectionHeading(
                      buttonTitle: 'view all',
                      showActionButton: true,
                      title: isLocaleEn(context) ? "Sales" : "العروض"),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 280,
                  child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      scrollDirection: Axis.vertical,
                      itemCount: offersItems.length,
                      itemBuilder: (_, index) => SizedBox(
                            height: 310,
                            width: 120,
                            child: ProductWidgetSmall(
                              vendorId: userId,
                              product: offersItems[index],
                            ),
                          )),
                ),

                FutureBuilder(
                    future: controller.getSubCategories(category.id!, userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Wrap(
                          children: [
                            TShimmerEffect(width: 100, height: 30),
                            SizedBox(
                              width: 6,
                            ),
                            TShimmerEffect(width: 100, height: 30),
                            SizedBox(
                              width: 6,
                            ),
                            TShimmerEffect(width: 100, height: 30),
                          ],
                        );
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return editMode
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  const TShimmerEffect(width: 120, height: 50),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        child: Icon(Icons.add),
                                      ),
                                      SizedBox(
                                        child: Text(
                                          'اضافة فئة فرعية',
                                          style: titilliumBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox();
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('session.someThinggowrong'),
                            style: robotoMedium,
                          ),
                        );
                      }
                      final subcategories = snapshot.data!;
                      if (subcategories.isEmpty) {
                        return const SizedBox(
                          child: Icon(Icons.add),
                        );
                      }

                      return Visibility(
                        visible: false,
                        child: SizedBox(
                          height: 50,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10,
                            ),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: subcategories.length,
                            itemBuilder: (_, index) => InkWell(
                              onTap: () =>
                                  selectedCategory.value = subcategories[index],
                              child: TRoundedContainer(
                                  radius: BorderRadius.circular(40),
                                  showBorder: true,
                                  borderColor: selectedCategory.value ==
                                          subcategories[index]
                                      ? TColors.black
                                      : TColors.darkGrey,
                                  padding: const EdgeInsets.all(8),
                                  child: Center(
                                    child: Text(
                                        isLocaleEn(context)
                                            ? subcategories[index].name
                                            : subcategories[index].arabicName,
                                        style: titilliumSemiBold),
                                  )),
                            ),
                          ),
                        ),
                      );

                      //return TSortableProducts(products: products);
                    }),
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
          ]),
    );
  }
}
