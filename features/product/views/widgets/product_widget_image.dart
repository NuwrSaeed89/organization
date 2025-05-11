import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class ProductWidgetImage extends StatelessWidget {
  const ProductWidgetImage(
      {super.key, required this.product, required this.vendorId});
  final ProductModel product;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) => ProductDetails(
                product: product,
                vendorId: vendorId,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: TSizes.paddingSizeSmall),
        decoration: BoxDecoration(),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Stack(
              children: [
                Container(
                    height: 127,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: TProductImageSliderMini(
                      product: product,
                      prefferHeight: 127,
                      prefferWidth: 95,
                    )),
                    
              ],
            ),

            // Product Details
          ]),

          // Off
        ]),
      ),
    );
  }
}
