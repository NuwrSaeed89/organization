import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/all_products_list.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    // ScrollController scrollController = ScrollController();
    final controller = ProductController.instance;
    return SafeArea(
      child: Directionality(
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
                            builder: (context) => ProductsList(
                                  vendorId: vendorId,
                                ))),
                    child: SizedBox(width: 30, child: Icon(Icons.list)),
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
                                  vendorId: vendorId,
                                  type: '',
                                  sectionId: '',
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
            body: RefreshIndicator(
              onRefresh: () async {
                controller.fetchdata(vendorId);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(TSizes.sm),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const TLoaderWidget();
                    }

                    return ProductTableGrid(
                      vendorId: vendorId,
                    );
                  }),
                ),
              ),
            )),
      ),
    );
  }
}

class ProductTableGrid extends StatelessWidget {
  const ProductTableGrid({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    // controller.fetchdata(vendorId);
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: controller.allItems.isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 50.w,
                  ),
                  const TLoaderWidget(),
                  SizedBox(
                    height: 10.w,
                  ),
                  const Text("No Data")
                ],
              )
            : Obx(
                () => MasonryGridView.count(
                  itemCount: controller.allItems.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        ProductWidgetSmall(
                          product: controller.allItems[index],
                          vendorId: controller.allItems[index].vendorId,
                        ),
                      ],
                    );
                  },
                ),
              ));
  }
}
