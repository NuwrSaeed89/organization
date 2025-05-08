// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/app/data.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';

import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';

class SavedProductsPage extends StatelessWidget {
  final SavedProductsController controller = Get.put(SavedProductsController());

  SavedProductsPage({super.key});
  // Example user ID

  @override
  Widget build(BuildContext context) {
    controller.fetchSavedProducts();

    return Scaffold(
      appBar: CustomAppBar(
        title: isLocaleEn(context) ? 'Saved Product' : 'قائمة الحفظ',
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  TCustomWidgets.buildDivider(),
              itemCount: controller.savedProducts.length,
              itemBuilder: (context, index) {
                var product = controller.savedProducts[index];
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                          width: 124,
                          child: ProductWidgetSmall(
                              product: product, vendorId: '')),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.removeProduct(product.id),
                      ),
                    ),
                  ],
                );
                // ListTile(
                //   title: Text(
                //       isLocaleEn(context) ? product.title : product.arabicTitle),
                //   subtitle: Text("\AED ${product.price}"),
                //   leading: TRoundedContainer(
                //     width: 60,
                //     height: 80,
                //     radius: BorderRadius.circular(15),
                //     child: CustomCaChedNetworkImage(
                //       url: product.images!.first,
                //       width: 60,
                //       height: 80,
                //       raduis: BorderRadius.circular(15),
                //     ),
                //   ),
                //   trailing: IconButton(
                //     icon: Icon(Icons.delete),
                //     onPressed: () => controller.removeProduct(product.id),
                //   ),
                // );
              },
            ),
          )),
    );
  }
}
