import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/all_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/shemmer/product_horizental_list_shimmer.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key,
      required this.title,
      this.query,
      this.futureMethode,
      required this.editMode,
      required this.vendorId,
      this.categoryId = ''});

  final String title;
  final Query? query;
  final bool editMode;

  final String categoryId;
  final String vendorId;
  final Future<List<ProductModel>>? futureMethode;
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            isLocaleEn(context) ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(
            title: title,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: FutureBuilder(
                    //Text(" category id $categoryId")
                    future: CategoryController.instance.getCategoryProduct(
                        categoryId: categoryId, userId: vendorId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                            builder: (context) => CreateProduct(
                                              initialList: [],
                                               sectorTitle: SectorModel( arabicName: '',id: '',englishName: '', name: ''),
                                                  vendorId: vendorId,
                                                  type: '',
                                                  sectionId: 'all',
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
                                    isArabicLocale() ? "اضافة عنصر" : "Add Item",
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
                                            builder: (context) => CreateProduct(
                                              initialList: [],
                                               sectorTitle: SectorModel( arabicName: '',id: '',englishName: '', name: ''),
                                                  vendorId: vendorId,
                                                  type: '',
                                                  sectionId: 'all',
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
                                    isArabicLocale() ? "اضافة عنصر" : "Add Item",
                                    style: titilliumBold,
                                  )
                                ],
                              )
                            : const SizedBox.shrink();
                      }
            
                      return Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (_, index) => SizedBox(
                                      width: 120,
                                      child: ProductWidgetSmall(
                                        product: products[index],
                                        vendorId: vendorId,
                                      ),
                                    )),
                          ),
                        ],
                      );
            
                      //return TSortableProducts(products: products);
                    }),
              ),
            ),
          ),
        ));
  }
}
