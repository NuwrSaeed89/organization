import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/all_products_grid.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_item.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    // ScrollController scrollController = ScrollController();
    final controller = Get.put(ProductController());

    return Directionality(
      textDirection: isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 50,
                child: FloatingActionButton(
                  backgroundColor: Colors.black.withValues(alpha: .5),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductsGrid(
                                vendorId: vendorId,
                              ))),
                  child: const SizedBox(
                      width: 30, child: Icon(CupertinoIcons.grid)),
                ),
              ),
              SizedBox(
                width: 50,
                child: FloatingActionButton(
                  backgroundColor: Colors.black.withValues(alpha: .5),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateProduct(
                            initialList: [],
                                vendorId: vendorId,
                                 sectorTitle: SectorModel( arabicName: '',id: '',englishName: '', name: ''),
                                type: '',
                                sectionId: 'all',
                              ))),
                  child: SizedBox(
                    width: 30,
                    child: Image.asset(
                      TImages.add,
                    ),
                  ),
                ),
              ),
            ],
          ),
          appBar: CustomAppBar(
            title: AppLocalizations.of(context).translate('shop.products'),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.fetchdata(vendorId);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.sm),
                  child: Column(
                    children: [
                      TRoundedContainer(
                        child: Column(
                          children: [
                            Obx(() {
                              if (controller.isLoading.value) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 50.w,
                                    ),
                                    const TLoaderWidget(),
                                    const Text("Loading ..")
                                  ],
                                );
                              }
                
                              return ProductsTable(
                                vendorId: vendorId,
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: FutureBuilder<List<ProductModel>>(
        future: ProductController.instance.fetchAllData(vendorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                SizedBox(
                  height: 50.w,
                ),
                const TLoaderWidget(),
                SizedBox(
                  height: 10.w,
                ),
                const Text("loading Data")
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("حدث خطأ!"));
          } else {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text('Add product here'));
            } else {
              var allProducts = snapshot.data!;

              return Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TRoundedContainer(
                    child: ListView.separated(
                        separatorBuilder: (_, __) =>
                            const Divider(color: TColors.grey),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.allItems.length,
                        itemBuilder: (_, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: TProductItem(
                                  product: controller.allItems[index]),
                            )),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
